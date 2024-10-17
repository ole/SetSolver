import ARKit
import OSLog
import SceneKit
import SwiftUI
import Vision

private let logger = Logger(subsystem: #fileID, category: Bundle.main.bundleIdentifier!)

struct LiveCameraView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> ARSCNView {
        logger.debug(#function)
        let view = ARSCNView()
        view.delegate = context.coordinator
        view.session.delegate = context.coordinator
        view.session.delegateQueue = context.coordinator.arSessionQueue
        let scene = SCNScene()
        view.scene = scene

        return view
    }
    
    func updateUIView(_ view: ARSCNView, context: Context) {
        logger.debug(#function)
        if context.coordinator.isFirstUpdate {
            defer { context.coordinator.isFirstUpdate = false }
            logger.info("Configuring Vision request for Set cards")
            do {
                try context.coordinator.setupVision()
            } catch {
                logger.warning("Error setting up Vision request: \(error)")
            }

            logger.info("Starting ARSession")
            let configuration = ARWorldTrackingConfiguration()
            view.session.run(configuration)
        }
    }
}

extension LiveCameraView {
    final class Coordinator: NSObject {
        var isFirstUpdate: Bool = true
        let arSessionQueue: DispatchQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier!).ARSessionDelegate")
        private var visionRequest: Optional<Vision.CoreMLRequest> = nil

        func setupVision() throws {
            let mlModelFilename = "SetCards.mlmodelc"
            guard let modelURL = Bundle.main.url(forResource: mlModelFilename, withExtension: nil) else {
                throw AppError(message: "CoreML model \(mlModelFilename) not found in bundle")
            }
            let model = try MLModel(contentsOf: modelURL)
            let modelContainer = try CoreMLModelContainer(model: model)
            var visionRequest = CoreMLRequest(model: modelContainer)
            visionRequest.cropAndScaleAction = .scaleToFill
            self.visionRequest = visionRequest
        }
    }
}

extension LiveCameraView.Coordinator: ARSCNViewDelegate {
}

extension LiveCameraView.Coordinator: ARSessionDelegate {
    /// Provides a newly captured camera image and accompanying AR information.
    ///
    /// Runs on ``arSessionQueue``.
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        dispatchPrecondition(condition: .onQueue(arSessionQueue))
        logger.debug("Received frame from ARSession – timestamp=\(frame.timestamp)")
        guard let visionRequest else { return }
        Task.detached { [visionRequest] in
            do {
                let observations = try await visionRequest.perform(on: frame.capturedImage)
                    .compactMap { $0 as? RecognizedObjectObservation }
                logger.info("Detected \(observations.count) Set cards")
                for observation in observations {
                    let labels = observation.labels.sorted { $0.confidence > $1.confidence }
                    let best = labels[0]
                    logger.info("\(observation.confidence) – \(best.identifier) \(best.confidence)")
                }
            } catch {
                logger.warning("CoreMLRequest error: \(error)")
            }
        }
    }
}

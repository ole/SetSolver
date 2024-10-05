import ArgumentParser
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SetVision
import UniformTypeIdentifiers

@main
struct DetectRectangles: AsyncParsableCommand {
    @Argument(
        help: "Input image files",
        completion: .file(extensions: ["jpg", "jpeg", "png"])
    ) var inputImages: [String]

    @Option(
        help: "Output directory (default: current dir)",
        completion: .directory
    )
    var outputDir: String? = nil

    @Option(help: "The minimum size a rectangle must have to be detected, as a proportion of the width or height of the source image, whichever is smaller. A value between 0 and 1.")
    var minSize: Float = 0.1

    @Option(help: "The minimum acceptable confidence level for detected rectangles. A value between 0 and 1.")
    var minConfidence: Float = 1.0

    func run() async throws {
        let ciContext = CIContext()
        for filename in inputImages {
            let imageURL = URL(fileURLWithPath: filename)
            print(imageURL.lastPathComponent)
            let rectangles = try await detectRectangles(in: imageURL, minimumSize: minSize, minimumConfidence: minConfidence)
            print("Found \(rectangles.count) rectangles")
            for (counter, rectangle) in rectangles.enumerated() {
                guard let ciImage = CIImage(contentsOf: imageURL) else {
                    print("Unable to create CIImage")
                    continue
                }
                let imageSize = ciImage.extent.size
                let filter = CIFilter.perspectiveCorrection()
                filter.inputImage = ciImage
                filter.topLeft = rectangle.topLeft.toImageCoordinates(imageSize)
                filter.topRight = rectangle.topRight.toImageCoordinates(imageSize)
                filter.bottomLeft = rectangle.bottomLeft.toImageCoordinates(imageSize)
                filter.bottomRight = rectangle.bottomRight.toImageCoordinates(imageSize)
                guard let outputImage = filter.outputImage else {
                    print("CIFilter does not produce an output image")
                    continue
                }
                let outputImageSize = outputImage.extent.size
                guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                    print("Unable to create CGImage")
                    continue
                }
                let basename = imageURL.deletingPathExtension().lastPathComponent
                let outputFileType = UTType.png
                let outputFilename = "\(basename)-\(counter + 1).\(outputFileType.preferredFilenameExtension!)"
                let outputDirectory = URL(filePath: outputDir ?? FileManager.default.currentDirectoryPath)
                let outputURL = outputDirectory
                    .appending(component: outputFilename, directoryHint: .notDirectory)
                guard let imageDestination = CGImageDestinationCreateWithURL(
                    outputURL as CFURL,
                    outputFileType.identifier as CFString,
                    1,
                    nil
                )
                else {
                    print("Unable to create CGImageDestination")
                    continue
                }
                CGImageDestinationAddImage(imageDestination, cgImage, nil)
                guard CGImageDestinationFinalize(imageDestination) else {
                    print("CGImageDestinationFinalize returned false")
                    continue
                }
                let f = FloatingPointFormatStyle<Double>.number.precision(.fractionLength(0))
                print("'\(outputFilename)' (\(outputImageSize.width.formatted(f))×\(outputImageSize.height.formatted(f)) px)")
            }
            print("---")
        }
    }
}

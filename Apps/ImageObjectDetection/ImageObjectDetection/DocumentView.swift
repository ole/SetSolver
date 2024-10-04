import SwiftUI

struct DocumentView: View {
    var imageURL: URL

    var body: some View {
        if let image {
            DetectRectanglesView(image: image, imageURL: imageURL)
        } else {
            Text("Unable to load image.")
        }
    }

    var image: Image? {
        guard let cgImageSource = CGImageSourceCreateWithURL(imageURL as CFURL, nil),
              let cgImage: CGImage = CGImageSourceCreateImageAtIndex(cgImageSource, 0, nil)
        else {
            return nil
        }
        return Image(cgImage, scale: 1, label: Text(""))
    }
}


//
//  PhotoDetailView.swift
//  EcoApp
//
//  Created by Allan Jones on 12/5/23.
//

import SwiftUI

struct PhotoDetailView: View {
    var photo: PhotoItem

    var body: some View {
        let backgroundColor = UIImage(named: "photos/" + photo.imageName)?.averageColor.map(Color.init)

        VStack {
            Text(photo.name)
                .font(.title)
                .padding()

            VStack(alignment: .leading, spacing: 2) {
                Text("Scientific Name: \(photo.scientificName)")
            }

            if let uiImage = UIImage(named: "photos/" + photo.imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .cornerRadius(10)
                    .background(backgroundColor)
            } else {
                Text("Image not found: \(photo.imageName)")
            }

            Text("Description:")
                .font(.headline)

            Text(photo.description)
                .padding()
        }
        .padding()
        .navigationTitle("Photo Details")
        .background(backgroundColor) // Set the background color of the entire view
    }
}

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}

// #Preview {
//    PhotoDetailView()
// }

//
//  PhotoDetailView.swift
//  EcoApp
//
//  Created by Allan Jones on 12/5/23.
//

import SwiftUI

struct PhotoDetailView: View {
    var photo: PhotoItem
    var uploadedPhotos: [UploadedPhoto]

    var body: some View {
        let uploadedPhoto = uploadedPhotos.first(where: { $0.name == photo.name })
        let uploadedImage = uploadedPhoto?.image
        let backgroundColor = uploadedImage?.averageColor.map(Color.init)
        let complementaryColor = uploadedImage?.complementaryColor.map(Color.init)

        VStack {
            Text(self.photo.name)
                .font(.title)
                .padding()
                .foregroundColor(complementaryColor)

            VStack(alignment: .leading, spacing: 2) {
                Text("Scientific Name: \(self.photo.scientificName)")
                    .foregroundColor(complementaryColor)
            }

            if let uiImage = uploadedImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(backgroundColor)
                    .cornerRadius(10)
            } else {
                Text("No Image")
            }

            Text("Description:")
                .font(.headline)
                .foregroundColor(complementaryColor)

            Text(self.photo.description)
                .padding()
                .foregroundColor(complementaryColor)
        }
        .padding()
        .navigationTitle("Photo Details")
        .background(backgroundColor)
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

    var complementaryColor: UIColor? {
        guard let averageColor = averageColor else { return nil }

        // Calculate complementary color
        let ciColor = CIColor(cgColor: averageColor.cgColor)
        let complementaryRed = 1.0 - ciColor.red
        let complementaryGreen = 1.0 - ciColor.green
        let complementaryBlue = 1.0 - ciColor.blue

        return UIColor(red: complementaryRed, green: complementaryGreen, blue: complementaryBlue, alpha: 1.0)
    }
}

// #Preview {
//    PhotoDetailView()
// }

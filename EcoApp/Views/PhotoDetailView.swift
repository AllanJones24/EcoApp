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
        let backgroundColor = UIImage(named: "photos/" + self.photo.imageName)?.averageColor.map(Color.init)
        let complementaryColor = UIImage(named: "photos/" + self.photo.imageName)?.complementaryColor.map(Color.init)

        VStack {
            Text(self.photo.name)
                .font(.title)
                .padding()
                .foregroundColor(complementaryColor)

            VStack(alignment: .leading, spacing: 2) {
                Text("Scientific Name: \(self.photo.scientificName)")
                    .foregroundColor(complementaryColor)
            }

            if let uiImage = UIImage(named: "photos/" + photo.imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(backgroundColor)
                    .cornerRadius(10)
            } else {
                Text("Image not found: \(self.photo.imageName)")
                    .foregroundColor(complementaryColor)
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

// extension Color {
//    func complementaryColor() -> Color {
//        let uiColor = UIColor(self)
//
//        var hue: CGFloat = 0
//        var saturation: CGFloat = 0
//        var brightness: CGFloat = 0
//        var alpha: CGFloat = 0
//
//        uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
//
//        // Increase the saturation to make the color more vibrant
//        let vibrantSaturation = min(saturation * 1.5, 1.0)
//
//        // Calculate the complementary color with the adjusted saturation
//        let complementaryColor = UIColor(hue: hue, saturation: vibrantSaturation, brightness: brightness, alpha: alpha)
//
//        return Color(complementaryColor)
//    }
// }

// #Preview {
//    PhotoDetailView()
// }

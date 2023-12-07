//
//  PhotoRowView.swift
//  EcoApp
//
//  Created by Allan Jones on 12/5/23.
//

import SwiftUI

struct PhotoRowView: View {
    var photo: PhotoItem
    var photosPath: String

    var body: some View {
        HStack {
            if let firstImageName = photo.imageNames.first, let firstImage = UIImage(named: "\(photosPath)/\(firstImageName)") {
                Image(uiImage: firstImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            }

            VStack(alignment: .leading) {
                Text(photo.name)
                    .font(.headline)
                    .lineLimit(1)
            }
            .padding(.leading, 8)
        }
        .frame(maxWidth: .infinity)
    }
}

// remove uploaded photo from photo set

// #Preview {
//    PhotoRowView()
// }

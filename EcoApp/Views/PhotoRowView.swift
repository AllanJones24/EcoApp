//
//  PhotoRowView.swift
//  EcoApp
//
//  Created by Allan Jones on 12/5/23.
//

import SwiftUI

// rename
struct PhotoRowView: View {
    var photo: PhotoItem

    var body: some View {
        HStack {
            if let secondImageName = photo.imageNames[safe: 1], let secondImage = UIImage(named: "photos/" + secondImageName) {
                Image(uiImage: secondImage)
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

// An extension to safely access an element at a given index
extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

// #Preview {
//    PhotoRowView()
// }

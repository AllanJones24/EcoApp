//
//  PhotoRowView.swift
//  EcoApp
//
//  Created by Allan Jones on 12/5/23.
//

import SwiftUI

//change name to something else
struct PhotoRowView: View {
    var photo: PhotoItem

    var body: some View {
        HStack {
            // Add other image here
            Image(photo.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(photo.name)
                    .font(.headline)
                    .lineLimit(1)

                Text(photo.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            .padding(.leading, 8)
        }
    }
}

// #Preview {
//    PhotoRowView()
// }

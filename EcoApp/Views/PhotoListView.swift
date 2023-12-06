//
//  PhotoListView.swift
//  EcoApp
//
//  Created by Allan Jones on 12/5/23.
//

import SwiftUI

struct PhotoListView: View {
    var photoSet: PhotoSet
    @State private var selectedPhoto: PhotoItem?

    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("mountains")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.5) // Adjust opacity as needed

                // List with Photos
                List(photoSet.photos) { photo in
                    Button {
                        selectedPhoto = photo
                    } label: {
                        PhotoRowView(photo: photo)
                            .padding(.vertical, 8)
                            .background(Color.white.cornerRadius(10).shadow(color: .gray, radius: 3, x: 0, y: 2))
                    }.listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle()) // Use PlainListStyle to remove the default list style
                .sheet(item: $selectedPhoto) { photo in
                    PhotoDetailView(photo: photo)
                }
                .navigationTitle("Discoveries")
                .navigationBarItems(trailing: Image(systemName: "info.circle"))
                
            }
        }
    }
}

// #Preview {
//    PhotoListView()
// }

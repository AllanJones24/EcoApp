//
//  PhotoListView.swift
//  EcoApp
//
//  Created by Allan Jones on 12/5/23.
//

import SwiftUI

struct PhotoListView: View {
    @State private var isAddingItem = false
    @State private var selectedPhoto: PhotoItem?
    @State private var photos: [PhotoItem] = []
    @State private var uploadedPhotos: [UploadedPhoto] = []
    @State private var selectedImage: UIImage?

    var photoSet: PhotoSet

    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("mountains")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.5) // Adjust opacity as needed

                VStack {
                    // Welcome Text with Image
                    if photos.isEmpty {
                        Text("Welcome to the Eco App, Get Started by adding your newly found discovery!!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding()

                        Image("collection")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)

                        Button("Add Item") {
                            isAddingItem.toggle()
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                    }

                    // List with Photos
                    List {
                        ForEach(photos) { photo in
                            Button {
                                selectedPhoto = photo
                            } label: {
                                PhotoRowView(photo: photo, photosPath: photoSet.photosPath)
                                    .padding(8)
                                    .background(Color.white.opacity(0.8).cornerRadius(30))
                            }
                            .listRowBackground(Color.clear)
                        }
                        .onDelete(perform: deletePhoto)
                    }
                    .listStyle(PlainListStyle())
                    .sheet(item: $selectedPhoto) { photo in
                        PhotoDetailView(photo: photo, uploadedPhotos: uploadedPhotos)
                    }
                    .navigationTitle("Discoveries")
                    .navigationBarItems(
                        leading: EditButton(),
                        trailing: Button("Add Item") {
                            isAddingItem.toggle()
                        }
                    )
                    .sheet(isPresented: $isAddingItem) {
                        AddItemView(
                            itemNames: photoSet.photos.map { $0.name },
                            selectedItems: photos.map { $0.name },
                            selectedImage: $selectedImage
                        ) { selectedItem, selectedImage in
                            if let selectedPhoto = photoSet.photos.first(where: { $0.name == selectedItem }) {
                                let newPhoto = PhotoItem(
                                    imageNames: selectedPhoto.imageNames,
                                    name: selectedItem,
                                    scientificName: selectedPhoto.scientificName,
                                    description: selectedPhoto.description
                                )
                                photos.append(newPhoto)

                                if let selectedImage = selectedImage {
                                    let uploadedPhoto = UploadedPhoto(name: selectedItem, image: selectedImage)
                                    uploadedPhotos.append(uploadedPhoto)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private func deletePhoto(at offsets: IndexSet) {
        photos.remove(atOffsets: offsets)
    }
}







// #Preview {
//    PhotoListView()
// }

//
//  AddItemView.swift
//  EcoApp
//
//  Created by Allan Jones on 12/7/23.
//

import SwiftUI

struct AddItemView: View {
    var itemNames: [String]
    var selectedItems: [String]
    @Binding var selectedImage: UIImage?
    var onItemSelected: (String, UIImage?) -> Void

    @Environment(\.presentationMode) private var presentationMode
    @State private var selectedItem: String?
    @State private var isImagePickerPresented: Bool = false

    var availableItems: [String] {
        itemNames.filter { !selectedItems.contains($0) }
    }

    var body: some View {
        NavigationView {
            List(availableItems, id: \.self) { itemName in
                Button {
                    selectedItem = itemName
                    isImagePickerPresented = true
                } label: {
                    HStack {
                        Text(itemName)
                            .foregroundColor(selectedItem == itemName ? .white : .primary)
                            .font(.headline)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .cornerRadius(8)
                    }
                }
                .listRowBackground(selectedItem == itemName ? Color.gray : Color.clear)
                .padding(.vertical, 4)
            }
            .navigationTitle("Select Item to Add")
            .navigationBarItems(trailing:
                Button("Add") {
                    if let selectedItem = selectedItem {
                        onItemSelected(selectedItem, selectedImage)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .disabled(selectedItem == nil)
            )
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage, imagePickerController: UIImagePickerController())
            }
        }
    }
}

// #Preview {
//    AddItemView()
// }

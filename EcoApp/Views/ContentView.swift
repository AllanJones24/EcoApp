//
//  ContentView.swift
//  EcoApp
//
//  Created by Allan Jones on 12/5/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if let photoSet = PhotoSetLoader.load(jsonFileName: "photos") {
            PhotoListView(photoSet: photoSet)
        } else {
            Text("Error loading photo set.")
        }
    }
}

#Preview {
    ContentView()
}

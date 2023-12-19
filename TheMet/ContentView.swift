//
//  ContentView.swift
//  TheMet
//
//  Created by Gaspare Monte on 19/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var store = TheMetStore()

    var body: some View {
        NavigationStack {
            List(store.objects, id: \.objectID) { object in
                NavigationLink {
                    SafariView(url: URL(string: object.objectURL)!)
                } label: {
                    HStack {
                        Text(object.title)
                        Spacer()
                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                            .font(.footnote)
                    }
                }

            }
            .navigationTitle("The Met")
        }
    }
}

#Preview {
    ContentView()
}

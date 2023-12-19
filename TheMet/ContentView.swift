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
                if !object.isPublicDomain,
                   let url = URL(string: object.objectURL) {
                    NavigationLink(value: url) {
                        WebIndicatorView(title: object.title)
                    }
                    .listRowBackground(Color.metBg)
                    .foregroundStyle(.white)
                } else {
                    NavigationLink(value: object) {
                        Text(object.title)
                    }
                    .listRowBackground(Color.metFg)
                }
            }
            .navigationTitle("The Met")
            .navigationDestination(for: URL.self) { url in
                SafariView(url: url)
                    .navigationBarTitleDisplayMode(.inline)
                    .ignoresSafeArea()
            }
            .navigationDestination(for: Object.self) { object in
                ObjectView(object: object)
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WebIndicatorView: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                .font(.footnote)
        }
    }
}

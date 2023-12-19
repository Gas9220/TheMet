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
                NavigationLink(object.title) {
                    ObjectView(object: object)
                }
            }
            .navigationTitle("The Met")
        }
    }
}

#Preview {
    ContentView()
}

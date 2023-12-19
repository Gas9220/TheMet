//
//  ObjectView.swift
//  TheMet
//
//  Created by Gaspare Monte on 19/12/23.
//

import SwiftUI

struct ObjectView: View {
    let object: Object

    var body: some View {
        VStack {
            Text(object.title)
                .multilineTextAlignment(.leading)
                .font(.callout)
                .frame(minHeight: 44)

            if object.isPublicDomain {
                PlaceholderView(note: "Display image here")
            } else {
                PlaceholderView(note: "Image not in public domain.")
            }

            Text(object.creditLine)
                .font(.caption)
                .padding()
                .background(Color.metForeground)
                .cornerRadius(10)
        }
        .padding(.vertical)
    }
}

struct PlaceholderView: View {
    let note: String
    var body: some View {
        ZStack {
            Rectangle()
                .inset(by: 7)
                .fill(Color.metForeground)
                .border(Color.metBackground, width: 7)
                .padding()
            Text(note)
                .foregroundColor(.metBackground)
        }
    }
}

#Preview {
    ObjectView(object:
                Object(
                    objectID: 452174,
                    title: "Bahram Gur Slays the Rhino-Wolf",
                    creditLine: "Gift of Arthur A. Houghton Jr., 1970",
                    objectURL: "https://www.metmuseum.org/art/collection/search/452174",
                    isPublicDomain: true,
                    primaryImageSmall: "https://images.metmuseum.org/CRDImages/is/original/DP107178.jpg")
    )
}
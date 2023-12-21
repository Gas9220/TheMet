//
//  WidgetView.swift
//  TheMetWidgetExtension
//
//  Created by Gaspare Monte on 21/12/23.
//

import SwiftUI
import WidgetKit

struct WidgetView: View {
    let entry: Provider.Entry

    var body: some View {
        Text(entry.object.title)
    }
}

#Preview {
    WidgetView(entry: SimpleEntry(date: Date(), object: Object.sample(isPublicDomain: true)))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
}

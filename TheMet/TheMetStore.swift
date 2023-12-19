//
//  TheMetStore.swift
//  TheMet
//
//  Created by Gaspare Monte on 19/12/23.
//

import Foundation

class TheMetStore: ObservableObject {
    @Published var objects: [Object] = []

    init() {
#if DEBUG
        createDevData()
#endif
    }
}

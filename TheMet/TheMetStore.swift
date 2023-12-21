//
//  TheMetStore.swift
//  TheMet
//
//  Created by Gaspare Monte on 19/12/23.
//

import Foundation

class TheMetStore: ObservableObject {
    @Published var objects: [Object] = []

    let service = TheMetService()
    let maxIndex: Int

    init(_ maxIndex: Int = 30) {
        self.maxIndex = maxIndex
        //#if DEBUG
        //        createDevData()
        //#endif
    }

    func fetchObjects(for queryTerm: String) async throws {
        if let objectIDs = try await service.getObjectIDs(from: queryTerm) {
            for (index, objectID) in objectIDs.objectIDs.enumerated() where index < maxIndex {
                if let object = try await service.getObject(from: objectID) {
                    await MainActor.run {
                        objects.append(object)
                    }
                }
            }
        }
    }
}

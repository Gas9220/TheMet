//
//  Object.swift
//  TheMet
//
//  Created by Gaspare Monte on 19/12/23.
//

import Foundation

struct Object: Codable, Hashable {
    let objectID: Int
    let title: String
    let creditLine: String
    let objectURL: String
    let isPublicDomain: Bool
    let primaryImageSmall: String
}

struct ObjectIDs: Codable {
    let total: Int
    let objectIDs: [Int]
}

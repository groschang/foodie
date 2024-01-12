//
//  IdentifiableObject.swift
//  foodie
//
//  Created by Konrad Groschang on 09/01/2024.
//

import Foundation

typealias ObjectID = String

protocol Identifier: Identifiable {
    var identifier: ObjectID { get }
}

extension Identifier {
    var identifier: ObjectID { "\(id)" }
}

protocol IdentifiableObject: Identifier, Hashable, Codable, Equatable {
    var id: ObjectID { get }
}

struct ObjectId: IdentifiableObject {
    let id: ObjectID

    init(_ id: ObjectID) {
        self.id = id
    }
}

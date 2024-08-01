//
// Fruit.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct Fruit: Codable, JSONEncodable, Hashable {

    public var name: String
    public var id: Int
    public var family: String
    public var order: String
    public var genus: String
    public var nutritions: FruitNutritions

    public init(name: String, id: Int, family: String, order: String, genus: String, nutritions: FruitNutritions) {
        self.name = name
        self.id = id
        self.family = family
        self.order = order
        self.genus = genus
        self.nutritions = nutritions
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case id
        case family
        case order
        case genus
        case nutritions
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(family, forKey: .family)
        try container.encode(order, forKey: .order)
        try container.encode(genus, forKey: .genus)
        try container.encode(nutritions, forKey: .nutritions)
    }
}

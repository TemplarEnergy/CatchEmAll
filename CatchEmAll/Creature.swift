//
//  Creature.swift
//  CatchEmAll
//
//  Created by Thomas Radford on 31/01/2023.
//

import Foundation

struct Creature: Codable, Identifiable {
    let id = UUID().uuidString
    
   var name: String
   var url: String // url for details on Pokemon
    
    enum CodingKeys: CodingKey {
        case name, url
    }
}

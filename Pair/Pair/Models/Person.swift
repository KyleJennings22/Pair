//
//  Person.swift
//  Pair
//
//  Created by Kyle Jennings on 12/20/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import Foundation

// Creating a person with name and ID
// ID is important because people can have the same name, so deleting just based off name could cause issues. ID is unique
class Person: Codable {
  let name: String
  let id: String
  
  // Giving ID a unique identifier when it is created
  init(name: String, id: String = UUID().uuidString) {
    self.name = name
    self.id = id
  }
}

// Conforming to equatable to delete
extension Person: Equatable {
  static func == (lhs: Person, rhs: Person) -> Bool {
    return lhs.id == rhs.id
  }
}

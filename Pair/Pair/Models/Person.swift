//
//  Person.swift
//  Pair
//
//  Created by Kyle Jennings on 12/20/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import Foundation

class Person: Codable {
  let name: String
  let id: String
  
  init(name: String, id: String = UUID().uuidString) {
    self.name = name
    self.id = id
  }
}

extension Person: Equatable {
  static func == (lhs: Person, rhs: Person) -> Bool {
    return lhs.id == rhs.id
  }
}

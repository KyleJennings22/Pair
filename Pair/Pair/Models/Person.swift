//
//  Person.swift
//  Pair
//
//  Created by Kyle Jennings on 12/20/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import Foundation

struct Person: Codable {
  let name: String
  
  init(name: String) {
    self.name = name
  }
}

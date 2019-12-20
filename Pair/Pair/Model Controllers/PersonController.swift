//
//  PersonController.swift
//  Pair
//
//  Created by Kyle Jennings on 12/20/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import Foundation

class PersonController {
  static let shared = PersonController()
  var people: [Person] = []
  
  // Loading the current people
  init() {
    loadFromPersistentStore()
  }
  
  // Creating a person
  func createPerson(name: String) {
    let person = Person(name: name)
    people.append(person)
    saveToPersistentStore()
  }
  
  // Deleting a person
  func deletePerson(person: Person) {
    guard let index = people.firstIndex(of: person) else {return}
    people.remove(at: index)
    saveToPersistentStore()
  }
  
  // Creating our file and returning a url of that filepath
  func fileURL() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let fileName = "people.json"
    let documentDirectoryURL = paths[0].appendingPathComponent(fileName)
    return documentDirectoryURL
  }
  
  // Saving using codable
  func saveToPersistentStore() {
    let encoder = JSONEncoder()
    
    do {
      let data = try encoder.encode(people)
      try data.write(to: fileURL())
    } catch {
      print(error)
    }
  }
  
  // Loading using codable
  func loadFromPersistentStore() {
    let decoder = JSONDecoder()
    
    do {
      let data = try Data(contentsOf: fileURL())
      let people = try decoder.decode([Person].self, from: data)
      self.people = people
    } catch {
      print(error)
    }
  }
  
}

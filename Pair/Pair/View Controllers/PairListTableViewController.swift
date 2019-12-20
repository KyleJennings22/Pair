//
//  PairListTableViewController.swift
//  Pair
//
//  Created by Kyle Jennings on 12/20/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import UIKit

class PairListTableViewController: UITableViewController {
  // MARK: - Properties

  // Creating a count to properly display the names in the cells and sections
  var count = 0
  
  // Creating a dictionary to help with Deleting
  var personDict: [IndexPath: Person] = [:]
  
  // MARK: - Lifecycle Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.reloadData()
  }
  
  // MARK: - Actions
  @IBAction func addPersonButtonTapped(_ sender: UIBarButtonItem) {
    newPersonAlert()
  }
  
  @IBAction func refreshButtonTapped(_ sender: Any) {
    // Shuffling the array
    PersonController.shared.people.shuffle()
    // Need to set the count back to zero before updating the tableview
    self.count = 0
    self.tableView.reloadData()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // Creating peopleCount variable
    let peopleCount = PersonController.shared.people.count
    
    // If there is an even amount of people, return half the amount of people, if there is an odd, return half the amount plus 1
    if peopleCount % 2 == 0 {
      return peopleCount / 2
    } else {
      return (peopleCount / 2) + 1
    }
  }
  
  // Our Headers need titles, its easy to get with the section
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Group \(section + 1)"
  }
  
  // This part wasn't fun
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    // Creating a variable for the number of sections
    let sections = tableView.numberOfSections
    
    // Creating a variable for the amount of people in our array
    let peopleCount = PersonController.shared.people.count
    
    // If there are an even amount of people, return 2 rows per section
    // If there are an odd number of people, if the section that we are currently at equals the total number of sections minus 1, then we return 1 else we return 2. Basically if the current section is at the same index of the last section, we want to only return 1 row since there are an odd amount of people
    if peopleCount % 2 == 0 {
      return 2
    } else {
      if section == sections - 1 {
        return 1
      } else {
        return 2
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
    
    // Creating our person using the count variable I used above. Every time a new cell is added, the count is incremented
    let person = PersonController.shared.people[count]
    
    cell.textLabel?.text = person.name
    
    // Adding to the dictionary to help with deleting
    personDict[indexPath] = person
    // Incrementing the count
    count += 1
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        
        // Grabbing our person
        guard let person = personDict[indexPath] else {return}
        
        // Deleting our person
        PersonController.shared.deletePerson(person: person)
        
        // Setting the count back to zero before reloading the tableview
        count = 0
        tableView.reloadData()
      }
  }
  
  // MARK: - Custom Functions
  
  // Decided to make this into a custom function rather than do it in the button tapped function
  func newPersonAlert() {
    
    // Creating the alert
    let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
    // Creating the textfield and giving it placeholder text
    alertController.addTextField { (textField) in
      textField.placeholder = "Full Name"
    }
    
    // Creating actions
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
      // Need to guard against the text being empty
      guard let fullName = alertController.textFields?[0].text,
        !fullName.isEmpty
        else {return}
      
      // Creating our person using the shared instance
      PersonController.shared.createPerson(name: fullName)
      self.count = 0
      self.tableView.reloadData()
    }
    
    // Adding actions and presenting alert
    alertController.addAction(cancelAction)
    alertController.addAction(addAction)
    self.present(alertController, animated: true)
  }
}

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
  var groupedPeople: [Person] = []
  var groupedPeopleCount = 0
  var count = 0
  // MARK: - Lifecycle Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    groupedPeople = PersonController.shared.people
    tableView.reloadData()
  }
  
  // MARK: - Actions
  @IBAction func addPersonButtonTapped(_ sender: UIBarButtonItem) {
    newPersonAlert()
  }
  @IBAction func refreshButtonTapped(_ sender: Any) {
    PersonController.shared.people.shuffle()
    self.count = 0
    self.tableView.reloadData()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    let peopleCount = PersonController.shared.people.count
    if peopleCount % 2 == 0 {
      return peopleCount / 2
    } else {
      return (peopleCount / 2) + 1
    }
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Group \(section + 1)"
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sections = tableView.numberOfSections
    let peopleCount = PersonController.shared.people.count
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
    print(count)
    let person = PersonController.shared.people[count]
    cell.textLabel?.text = person.name
    count += 1
    print(count)
    return cell
  }
  
  // MARK: - Custom Functions
  func newPersonAlert() {
    let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
    alertController.addTextField { (textField) in
      textField.placeholder = "Full Name"
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
      guard let fullName = alertController.textFields?[0].text,
        !fullName.isEmpty
        else {return}
      print(PersonController.shared.people.count)
      PersonController.shared.createPerson(name: fullName)
      self.count = 0
      self.tableView.reloadData()
    }
    alertController.addAction(cancelAction)
    alertController.addAction(addAction)
    self.present(alertController, animated: true)
  }
}

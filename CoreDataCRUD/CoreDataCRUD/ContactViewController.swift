//
//  ContactViewController.swift
//  CoreDataCRUD
//
//  Created by Ary on 22/07/2020.
//  Copyright © 2020 Ary. All rights reserved.
//

import UIKit

class ContactViewController: UITableViewController {

    var contactList:[Contact] = []
    let core = CoreDataController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactList = core.read()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = contactList[indexPath.row].name
        cell.detailTextLabel?.text = contactList[indexPath.row].phone
 
        return cell
    }
 
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { action, indexPath in
            
            let name = tableView.cellForRow(at: indexPath)?.textLabel?.text
            self.core.delete(name: name!)
            self.contactList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: {action, indexPath in
            
            let editController = UIAlertController(title: nil, message: "Edit Contact", preferredStyle: .alert)
            editController.addTextField(configurationHandler: {
                
                (textfield) in textfield.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
            })
            
            editController.addTextField(configurationHandler: {
                
                (textfield) in textfield.text = tableView.cellForRow(at: indexPath)?.detailTextLabel?.text
            })
            
            editController.addAction(UIAlertAction(title: "Save", style: .default, handler: {Action in
                
                let name = tableView.cellForRow(at: indexPath)?.textLabel?.text
                let contactName = (editController.textFields!.first!).text!
                let contactPhone = (editController.textFields!.last!).text!
                let contact = Contact(name: contactName, phone: contactPhone)
                self.core.update(name: name!, contact: contact)
                self.contactList[indexPath.row] = contact
                tableView.reloadRows(at: [indexPath], with: .fade)
                
            }))
            
            editController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(editController, animated: true)
            
        })
        
        return [deleteAction, editAction]
    }
    
    @IBAction func AddAction(_ sender: UIBarButtonItem) {
        
        let inputController = UIAlertController(title: nil, message: "New Contact", preferredStyle: .alert)
        
        inputController.addTextField(configurationHandler: {
            
            (textField) in textField.placeholder = "Name"
        })
        
        inputController.addTextField(configurationHandler: {
            
            (textField) in textField.placeholder = "Phone"
        })
        
        inputController.addAction(UIAlertAction(title: "OK", style: .default, handler: {Action in
            
            let contactName = (inputController.textFields!.first!).text!
            let contactPhone = (inputController.textFields!.last!).text!
            let contact = Contact(name: contactName, phone: contactPhone)
            self.contactList.append(contact)
            self.tableView.reloadData()
            self.core.create(contact: contact)
        }))
        
        inputController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(inputController, animated: true)
    }
        
}

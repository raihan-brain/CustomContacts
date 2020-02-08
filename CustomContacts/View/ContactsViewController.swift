//
//  ContactsViewController.swift
//  CustomContacts
//
//  Created by Shan Zaman on 3/2/20.
//  Copyright © 2020 Shan Zaman. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactsViewController: UITableViewController {
    
    var contactManager = ContactsHandler()
    var count: Int = 0
    var contacts = [ContactModel]()
    @objc func handelShowIndex() {
        print("testing")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if contactManager.authorizationStatus {
            contacts = contactManager.fetchContact()
            
            //            for contact in contacts {
            //                print(contact)
            //            }
            
            tableView.reloadData()
            
        } else {
            print("permission not granted")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handelShowIndex))
        
        let searchController = UISearchController(searchResultsController: nil)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        CNContactStore().requestAccess(for: .contacts) { (permission, error) in
            
            if (error != nil) {
                print("error when permission asked \(error!)")
            }
            
            if permission {
                self.contacts = self.contactManager.fetchContact()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("permission not granted")
            }
            
            
        }
        
        contactManager.getAuthorizationStatus()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.backgroundColor = .gray
//        label.text = contacts[section].header
//        return label
//    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if contacts[section].contacts?.count ?? 0  > 0 {
            return contacts[section].header
        }
        return nil
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts[section].contacts?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        if let customContact = contacts[indexPath.section].contacts?[indexPath.row] {
            cell.textLabel?.text = customContact.givenName + " " + customContact.familyName
        }
        
//        cell.textLabel?.text = contacts[indexPath.row].givenName + " " + contacts[indexPath.row].familyName
        
        // Configure the cell...
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

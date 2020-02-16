//
//  ContactsHandler.swift
//  CustomContacts
//
//  Created by Shan Zaman on 4/2/20.
//  Copyright © 2020 Shan Zaman. All rights reserved.
//

import Foundation
import Contacts
import ContactsUI

struct ContactsHandler {
    
    
    var authorizationStatus: Bool = false
    
    //MARK: - Ask for contact authorization
    
    public func askPermission() {
        CNContactStore().requestAccess(for: .contacts) { (granted, _ error) in
            
            if let e = error {
                print("error fetching contacts \(e)")
            } else {
                print("permission granted \(granted)")
            }
        }
    }
    
    
    //MARK: - get authorization status
    public mutating func getAuthorizationStatus()  {
        
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
        case .authorized:
            authorizationStatus = true
        case .denied:
            authorizationStatus = false
        case .restricted:
            authorizationStatus = false
        default:
            authorizationStatus = false
        }
    }
    
    
    //MARK: - fetch contacts
    
    public func fetchContact() -> [ContactModel] {
        
        let contactManager: CNContactStore = CNContactStore()
        var contacts: [CNContact] = [CNContact]()
        
        let fetchRequest: CNContactFetchRequest = CNContactFetchRequest(keysToFetch: [CNContactVCardSerialization.descriptorForRequiredKeys(), CNContactViewController.descriptorForRequiredKeys()])
        fetchRequest.sortOrder = CNContactSortOrder.givenName
        
        do {
            try contactManager.enumerateContacts(with: fetchRequest, usingBlock: { (contact, _) in
                if contact.givenName.count > 0 {
                    contacts.append(contact)
                }
            })
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        
        let arrayContacts =  createContacts(contacts: contacts)
        
        return arrayContacts
        
    }
    
    //MARK: - create the contact model
    
    private func createContacts(contacts: [CNContact]) -> [ContactModel] {
        let aScalars = "A".unicodeScalars
        
        let aCode = aScalars[aScalars.startIndex].value
        
        let letters: [Character] = (0..<26).map {
            i in Character(UnicodeScalar(aCode + i)!)
        }
        
        var arrayOfContact = [ContactModel]()
        
        for letter in letters {
            var demoContact = ContactModel(header: String(letter))
            demoContact.contacts = [CNContact]()
//            demoContact.
            for contact in contacts {
                if contact.givenName.prefix(1) == String(letter) {
                    demoContact.contacts?.append(contact)
                }
            }
            arrayOfContact.append(demoContact)
        }
        return arrayOfContact
    }
    
    
    //MARK: - search for contacts
    
    public func searchContact(searchText: String) ->[CNContact] {
        var searchContacts = [CNContact]()
        let contactStore: CNContactStore = CNContactStore()
        let predicate: NSPredicate = CNContact.predicateForContacts(matchingName: searchText)
        
        do {
            searchContacts = try contactStore.unifiedContacts(matching: predicate, keysToFetch: [CNContactVCardSerialization.descriptorForRequiredKeys(), CNContactViewController.descriptorForRequiredKeys()])
        } catch let error as NSError{
            print("error while searching \(error)")
        }
        
        return searchContacts
    }
    
}

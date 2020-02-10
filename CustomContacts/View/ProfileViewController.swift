//
//  ProfileViewController.swift
//  CustomContacts
//
//  Created by Shan Zaman on 10/2/20.
//  Copyright © 2020 Shan Zaman. All rights reserved.
//

import UIKit
import Contacts

class ProfileViewController: UIViewController {
    
    var selectedContact: CNContact?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let contact = selectedContact {
            print(contact.givenName)
            navigationItem.title = contact.givenName
            let pic = UIImage(data: contact.imageData!)
            let imageView = UIImageView(image: pic)
            navigationItem.titleView = imageView
        } else {
            print("no")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

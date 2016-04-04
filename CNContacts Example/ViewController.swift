//
//  ViewController.swift
//  CNContacts Example
//
//  Created by Justin Doan on 4/3/16.
//  Copyright © 2016 Justin Doan. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate {
    
    //outlet reference for textfields
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtP1: UITextField!
    @IBOutlet var txtP2: UITextField!
    @IBOutlet var txtP3: UITextField!
    @IBOutlet var txtE1: UITextField!
    @IBOutlet var txtE2: UITextField!
    @IBOutlet var txtE3: UITextField!
    @IBOutlet var txtRelationship: UITextField!
    
    //outlet references for labels
    @IBOutlet var lblP1: UILabel!
    @IBOutlet var lblP2: UILabel!
    @IBOutlet var lblP3: UILabel!
    @IBOutlet var lblE1: UILabel!
    @IBOutlet var lblE2: UILabel!
    @IBOutlet var lblE3: UILabel!
    
    var contactStore = CNContactStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.askForContactAccess()
        
    }
    
    func askForContactAccess() {
        let authorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        
        switch authorizationStatus {
        case .Denied, .NotDetermined:
            self.contactStore.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (access, accessError) -> Void in
                if !access {
                    if authorizationStatus == CNAuthorizationStatus.Denied {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                            let alertController = UIAlertController(title: "Contacts", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                            
                            let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
                            }
                            
                            alertController.addAction(dismissAction)
                            
                            self.presentViewController(alertController, animated: true, completion: nil)
                        })
                    }
                }
            })
            break
        default:
            break
        }
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        NSNotificationCenter.defaultCenter().postNotificationName("addNewContact", object: nil, userInfo: ["contactToAdd": contact])
        
        
        self.txtName.text = contact.givenName + " " + contact.familyName
        
        if contact.phoneNumbers.count > 0 {
            self.txtP1.text = (contact.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as? String
            let pLabel = contact.phoneNumbers[0].label
            let pLabel2 = pLabel.characters.split("<").map(String.init)
            let pLabel3 = pLabel2[1].characters.split(">").map(String.init)
            self.lblP1.text = pLabel3[0]
        } else {
            self.txtP1.text = ""
            self.lblP1.text = "Phone 1"
        }
        
        if contact.phoneNumbers.count > 1 {
            self.txtP2.text = (contact.phoneNumbers[1].value as! CNPhoneNumber).valueForKey("digits") as? String
            let pLabel = contact.phoneNumbers[1].label
            let pLabel2 = pLabel.characters.split("<").map(String.init)
            let pLabel3 = pLabel2[1].characters.split(">").map(String.init)
            self.lblP2.text = pLabel3[0]
        } else {
            self.txtP2.text = ""
            self.lblP2.text = "Phone 2"
        }
        
        if contact.phoneNumbers.count > 2 {
            self.txtP3.text = (contact.phoneNumbers[2].value as! CNPhoneNumber).valueForKey("digits") as? String
            let pLabel = contact.phoneNumbers[2].label
            let pLabel2 = pLabel.characters.split("<").map(String.init)
            let pLabel3 = pLabel2[1].characters.split(">").map(String.init)
            self.lblP3.text = pLabel3[0]
        } else {
            self.txtP3.text = ""
            self.lblP3.text = "Phone 3"
        }
        
        
        
        if contact.emailAddresses.count > 0 {
            self.txtE1.text = "\(contact.emailAddresses[0].value)"
            let eLabel = contact.emailAddresses[0].label
            let eLabel2 = eLabel.characters.split("<").map(String.init)
            let eLabel3 = eLabel2[1].characters.split(">").map(String.init)
            self.lblE1.text = eLabel3[0]
        } else {
            self.txtE1.text = ""
            self.lblE1.text = "Email 1"
        }
        
        if contact.emailAddresses.count > 1 {
            self.txtE2.text = "\(contact.emailAddresses[1].value)"
            let eLabel = contact.emailAddresses[1].label
            let eLabel2 = eLabel.characters.split("<").map(String.init)
            let eLabel3 = eLabel2[1].characters.split(">").map(String.init)
            self.lblE2.text = eLabel3[0]
        } else {
            self.txtE2.text = ""
            self.lblE2.text = "Email 2"
        }
        
        if contact.emailAddresses.count > 2 {
            self.txtE3.text = "\(contact.emailAddresses[2].value)"
            let eLabel = contact.emailAddresses[0].label
            let eLabel2 = eLabel.characters.split("<").map(String.init)
            let eLabel3 = eLabel2[1].characters.split(">").map(String.init)
            self.lblE3.text = eLabel3[0]
        } else {
            self.txtE3.text = ""
            self.lblE3.text = "Email 3"
        }
        
        
        if contact.contactRelations.count > 0 {
            txtRelationship.text = contact.contactRelations[0].value as? String
        } else {
            txtRelationship.text = ""
        }
        
    }
    
    @IBAction func btnChoose(sender: AnyObject) {
        
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        self.presentViewController(contactPicker, animated: true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  MainViewController.swift
//  ERPLite
//
//  Created by RInz on 14-6-7.
//  Copyright (c) 2014年 RInz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ContactsViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func BtnContacts(sender : UIButton) {
        performSegueWithIdentifier("goToContacts", sender: self)
    }
    
    @IBAction func BtnEvent(sender : UIButton) {
        performSegueWithIdentifier("goToEvents", sender: self)
    }
    
    @IBAction func BtnCalendar(sender : UIButton) {
        performSegueWithIdentifier("goToCalendar", sender: self)
    }
    
    @IBAction func BtnMessage(sender : UIButton) {
        performSegueWithIdentifier("goToMessage", sender: self)
    }
    
    @IBAction func BtnSetting(sender : UIButton) {
        performSegueWithIdentifier("goToSetting", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "goToContacts"){
            let navigationController = segue.destinationViewController as UINavigationController
            let contactsViewController = navigationController.viewControllers[0] as ContactsViewController
            contactsViewController.delegate = self
        }
        if (segue.identifier == "goToEvents"){
//            let navigationController = segue.destinationViewController as UINavigationController
//            let contactsViewController = navigationController.viewControllers[0] as ContactsViewController
//            contactsViewController.delegate = self
        }
    }
    
    func ContactsViewControllerDidBack(controller: ContactsViewController){
        dismissModalViewControllerAnimated(true)
    }

}

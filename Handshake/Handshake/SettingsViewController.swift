//
//  SettingsViewController.swift
//  Handshake
//
//  Created by Sharukh Hasan on 2/27/16.
//  Copyright © 2016 TintPoint. All rights reserved.
//

import Foundation
import CoreData

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var currentUserID: NSString = ""
    var user: Person?
    var context: NSManagedObjectContext?
    
    let arraySettings = ["First Name", "Last Name", "Email"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userEmail = NSUserDefaults.standardUserDefaults().objectForKey("UserEmail") as! String
        user = try! context?.objectWithType("Person", identifier: userEmail, forKey: "email") as! Person
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    @IBAction func doneButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SettingsCell")! as! SettingsCell
        cell.backgroundColor = UIColor.clearColor()
        cell.nameLabel?.text = arraySettings[indexPath.row]
        
        switch indexPath.row {
            case 0:
                cell.textField?.text = user?.firstName
                break
            case 1:
                cell.textField?.text = user?.lastName
                break
            case 2:
                cell.textField?.text = user?.email
                break
            default:
                break
            
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("DetailedViewSegue", sender: self)
    }
}
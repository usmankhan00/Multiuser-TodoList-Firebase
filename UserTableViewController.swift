//
//  UserTableViewController.swift
//  firebaseApp
//
//  Created by Faiq on 4/20/15.
//  Copyright (c) 2015 Faiq. All rights reserved.
//

import UIKit

var retrieveDictOfTask = [:]
var arrOfTask:[String] = []
var arrOfDesc: [String] = []
var arrToRemove = []


class UserTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableViewOutlet: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref = Firebase(url:"https://todolistapp293.firebaseio.com")
        
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            retrieveDictOfTask = snapshot.value as NSDictionary
            println(globalVarKeys)
            
            retrieveDictOfTask = retrieveDictOfTask.valueForKey(globalVarKeys)as NSDictionary
            arrToRemove = retrieveDictOfTask.allKeys
            
            println(globalVarKeys)
            arrOfTask = retrieveDictOfTask.allKeys as [String]
            arrOfDesc = retrieveDictOfTask.allValues as [String]
                self.tableViewOutlet.reloadData()
            
            
            }, withCancelBlock: { error in
                println(error.description)
        })
        

        
        
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return arrOfTask.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = "\(arrOfTask[indexPath.row])"
        cell.detailTextLabel?.text = "\(arrOfDesc[indexPath.row])"
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            var index = indexPath.row
            
            arrOfTask.removeAtIndex(indexPath.row)
            
            //arrOfTask.removeAtIndex([indexPath.row])
            
            var ref = Firebase(url:"https://todolistapp293.firebaseio.com")
            
            
            ref.childByAppendingPath(globalVarKeys).childByAppendingPath(arrOfTask[indexPath.row]).removeValue()
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableViewOutlet.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
            tableViewOutlet.reloadData()
        }
        
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "CellToViewController"){
            let VC = segue.destinationViewController as DeleteSaveEditViewController
            VC.keyOfUser = arrOfTask[self.tableViewOutlet.indexPathForSelectedRow()!.row] as String
            VC.keyOfDesc = arrOfDesc[self.tableViewOutlet.indexPathForSelectedRow()!.row] as String
       }
    
    }
    

}

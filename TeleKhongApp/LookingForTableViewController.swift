//
//  LookingForTableViewController.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 21/10/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit

var items = [settingItem]()

class LookingForTableViewController: UITableViewController,CustomCellDelegate {
    
    var lk = LookingForTableViewCell()
    var looking = Looking()
    var json = JSONFunction()
    var itemsForJson = [Int]()
    let archive = archiveFunction()
    
    @IBAction func done(_ sender: AnyObject) {
        itemsForJson = []
        for i in 0...6{
            if items[i].checked{
                itemsForJson.append(1)
            }else{
                itemsForJson.append(0)
            }
        }
        json.jsonSetting(fb_id, food: itemsForJson[0], fashion: itemsForJson[1], sport: itemsForJson[2], entertain: itemsForJson[3], book: itemsForJson[4], it: itemsForJson[5], healty: itemsForJson[6])
        archive.saveChecklistItems()
        let protectedPage = self.storyboard?.instantiateViewController(withIdentifier: "SettingTableViewController") as! SettingTableViewController
        let protectedPageNav = UINavigationController(rootViewController: protectedPage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = protectedPageNav
        
    }
    
    
    required init(coder aDecoder: NSCoder){
        if items.isEmpty{
        items = looking.getData()
        }
        super.init(coder: aDecoder)!
//        archive.saveChecklistItems()
        archive.loadChecklistItems()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LookingForTableViewCell

        cell.delegate = self
//        cell.lookingName.text = items[indexPath.row].text
//        if items[indexPath.row].checked{
//            cell.mySwitcher.on = true
//        }else{
//            cell.mySwitcher.on = false
//        }
//        saveChecklistItems()
        
//        cell.textLabel?.text = items[indexPath.row].text
        cell.tag = (indexPath as NSIndexPath).row
        cell.settingName.text = items[(indexPath as NSIndexPath).row].text
        cell.mySwitcher.isOn = items[(indexPath as NSIndexPath).row].checked
        
        

        archive.saveChecklistItems()
        return cell
        
    }
    
    func cellButtonTapped(_ cell: LookingForTableViewCell) {
        let indexPath = self.tableView.indexPathForRow(at: cell.center)!
//        let item = items[indexPath.row]
//        item.toggleChecked()
        items[(indexPath as NSIndexPath).row].toggleChecked()
        archive.saveChecklistItems()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let item = items[indexPath.row]
//            item.toggleChecked()
//        items[indexPath.row] = item
//        
//        
////        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        saveChecklistItems()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

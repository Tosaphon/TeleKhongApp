//
//  SettingTableViewController.swift
//  Promotion2You_2
//
//  Created by Apple Macintosh on 5/12/15.
//  Copyright (c) 2015 Apple Macintosh. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class SettingTableViewController: UITableViewController {
    
    
    @IBAction func Back(_ sender: AnyObject) {
//        self.dismissViewControllerAnimated(false, completion: nil)
        goToHomePage()
        
    }
    let menuList = ["Looking for","Contact us","Log out"]
    
    var lookingForList = ["Food","Fashion","Sport","Cooking","Music","Dance"]
    var contractUsList = ["Facebook","Web Site"]

    let archive = archiveFunction()
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func goToHomePage(){
        let tabBarController = UITabBarController()
        let newfeedPage = self.storyboard?.instantiateViewController(withIdentifier: "FeedPromotionTableViewController") as! FeedPromotionTableViewController
        let favPage = self.storyboard?.instantiateViewController(withIdentifier: "FavoriteTableViewController") as! FavoriteTableViewController
        let subscribePage = self.storyboard?.instantiateViewController(withIdentifier: "SubscribeTableViewController") as! SubscribeTableViewController
        
        
        let newfeedPageNav = UINavigationController(rootViewController: newfeedPage)
        newfeedPageNav.tabBarItem.image = UIImage(named: "rss-7.png")
        newfeedPageNav.tabBarItem.title = "New Feed"
        let favPageNav = UINavigationController(rootViewController: favPage)
        favPageNav.tabBarItem.image = UIImage(named: "star-7.png")
        favPageNav.tabBarItem.title = "Favorite"
        let subscribePageNav = UINavigationController(rootViewController: subscribePage)
        subscribePageNav.tabBarItem.image = UIImage(named: "heart-7.png")
        subscribePageNav.tabBarItem.title = "Follow"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        tabBarController.viewControllers = [newfeedPageNav, favPageNav,subscribePageNav]
        appDelegate.window?.rootViewController = tabBarController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return menuList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 

        // Configure the cell...
        
        cell.textLabel!.text = menuList[(indexPath as NSIndexPath).row]

        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vTemp : [String] = []
        var vName = ""
        if let indexPath = self.tableView.indexPathForSelectedRow{
            switch (indexPath as NSIndexPath).row{
            case 0:
                vTemp = lookingForList
                vName = "Looking For"
            case 1:
                vTemp = contractUsList
                vName = "Contract Us"
            case 2:
                vName = "Log out"
                tableView.deselectRow(at: indexPath, animated: true)
                let alertController = UIAlertController(title: "Logout", message: "Do you want to logout?", preferredStyle: .alert)
                
                let OKbutton = UIAlertAction(title: "Logout", style: .default){
                    (action)-> Void in
                    status = "nil"
                    profile.remove(at: 0)
                    self.archive.saveProfile()
                    let loginManager = FBSDKLoginManager()
                    loginManager.logOut()
                    let protectedPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginFacebookViewController") as! LoginFacebookViewController
                    let protectedPageNav = UINavigationController(rootViewController: protectedPage)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = protectedPageNav
                }
                let CancelButton = UIAlertAction(title: "Cancel", style: .cancel){
                    (action)-> Void in
                }
                alertController.addAction(OKbutton)
                alertController.addAction(CancelButton)
                self.present(alertController, animated: true, completion: nil)
            default:
                break
            }
            
            (segue.destination as! SecondSettingTableViewController).pLists = vTemp
            (segue.destination as! SecondSettingTableViewController).pName = vName
            }
        
        
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

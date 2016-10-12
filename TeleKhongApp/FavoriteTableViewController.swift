//
//  FavoriteTableViewController.swift
//  Promotion2You_2
//
//  Created by Apple Macintosh on 5/11/15.
//  Copyright (c) 2015 Apple Macintosh. All rights reserved.
//

import UIKit
import CoreData

class FavoriteTableViewController: UITableViewController {
    
    var infoData = Array<AnyObject>()
    var infoImgUrl = [String]()
    var infoName = [String]()
//    var infoDesc = [String]()
    var currTime = ""
    var totalMessage = 0
    var favList = [InfoObj]()
    
    let archive = archiveFunction()
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        archive.loadFavorite()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite"
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(FavoriteTableViewController.refreshStories), for: UIControlEvents.valueChanged)
        if currTime.isEmpty{
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        }else{
            refreshControl.attributedTitle = NSAttributedString(string: "Last Update: \(getTime())")
        }
        
        refreshControl.tintColor = UIColor.gray
        refreshControl.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
        
        self.refreshControl = refreshControl
        self.tableView?.reloadData()
        tableView.estimatedRowHeight = 5.0
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getTime() -> String{
        let date = Date();
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM d, h:mm a")
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func refreshStories() {
        print("---refreshing---")
        archive.loadFavorite()
        self.tableView?.reloadData()
        refreshControl?.endRefreshing()
        refreshControl!.attributedTitle = NSAttributedString(string: "Last Update: \(getTime())")
        currTime = getTime()
        
        print("---endrefreshing---")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        if favoriteLists.isEmpty{
            messageLabel.text = "No data is currently available. Please pull down to refresh."
            messageLabel.textAlignment = NSTextAlignment.center
            messageLabel.numberOfLines = 0
            messageLabel.font = UIFont(name: "Palatino-Italic", size: 20)
            messageLabel.sizeToFit()
            self.tableView.backgroundView = messageLabel;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            return 0
        }else{
            messageLabel.text = ""
            self.tableView.backgroundView = messageLabel;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return favoriteLists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoriteTableViewCell
        let index = (indexPath as NSIndexPath).row
        let item = favoriteLists[index]
        
        cell.infoPic.downloadedFrom(link: item.infoPic)
        cell.infoName.text = item.infoName
        cell.infoDesc.text = item.infoDesc
        cell.expireDate.text = item.infoExpire

        print(item.infoName)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            (segue.destination as! ViewInformationViewController).infoItem = favoriteLists[(indexPath as NSIndexPath).row]
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = infoLists.index(where: {$0.infoId == favoriteLists[(indexPath as NSIndexPath).row].infoId})
            infoLists[index!].isFavorite = false
            favoriteLists.remove(at: (indexPath as NSIndexPath).row)
            archive.saveFavorite()
            archive.saveInfoItems()
            if tableView.numberOfRows(inSection: (indexPath as NSIndexPath).row) == 1{
                tableView.deleteSections(IndexSet(integer: (indexPath as NSIndexPath).row), with: .automatic)
            }else{
            tableView.deleteRows(at: [indexPath], with: .fade)
            }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  FeedPromotionTableViewController.swift
//  Promotion2You_2
//
//  Created by Apple Macintosh on 5/11/15.
//  Copyright (c) 2015 Apple Macintosh. All rights reserved.
//
import CoreBluetooth
import CoreLocation
import UIKit
import CoreData
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import Social


class FeedPromotionTableViewController: UITableViewController,CLLocationManagerDelegate,DeleteInfoDelegate,FavoriteDelegate,ShareDelegate{
    
    
    var infoName = [String]()
    var infoDesc = [String]()
    var bleManager: BLEManager!
    var st_id : String = ""
    var storeName = [String]()
    var json = JSONFunction()
    var infoData = Array<AnyObject>()
    var storeData = Array<AnyObject>()
    var telekhong = Array<AnyObject>()
    var pictureUrl = [String]()
    var pictureStore = [String]()
    var totalMessage = 0
    var currTime = ""
    var stObj = storeObj()
    var cellIndex = 0
    var archive = archiveFunction()
    var infoFiltered = [Int]()
    
    
    
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        archive.loadAll()
        archive.loadChecklistItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        infoFiltered = [Int]()
        
//        if !infoLists.isEmpty{
//            for i in 0...infoLists.count-1{
//                let cat = infoLists[i].catagory
//                print("\(infoLists[i].infoName) : \(infoLists[i].catagory)")
//                if filter(cat){
//                    infoFiltered.append(i)
//                    print(infoFiltered)
//                    
//                }
//            }
//        }
//       print(infoFiltered.count)
        
        refreshStories()
        let index = khongLists.count
        if index > 0 && index > bStr.count{
            for i in 0...index-1{
                bStr.append(khongLists[i].khongString)
            }
            
        }

    }
    
    func getUserInfo(){
        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, picture.type(large), email"], tokenString: FBSDKAccessToken.current().tokenString, version: nil, httpMethod: "GET")
        req?.start(completionHandler: { (connection, result, error : NSError!) -> Void in
            if(error == nil)
            {
                fb_id = result["id"] as! String
            }
            else
            {
                print("error \(error)")
            }
        })
    }
    
    func goToLoginPage(){
        status = "nil"
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        let protectedPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginFacebookViewController") as! LoginFacebookViewController
        let protectedPageNav = UINavigationController(rootViewController: protectedPage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = protectedPageNav
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        archive.loadAll()
        
        
        self.title = "TeleKhong"
        if (FBSDKAccessToken.current() == nil){
        self.goToLoginPage()
        }else{
            if(bStr.isEmpty){
            bleManager = BLEManager()
            }
        }
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(FeedPromotionTableViewController.refreshStories), for: UIControlEvents.valueChanged)
        if currTime.isEmpty{
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        }else{
            refreshControl.attributedTitle = NSAttributedString(string: "Last Update: \(getTime())")
        }
        
        refreshControl.tintColor = UIColor.gray
        refreshControl.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
        
        self.refreshControl = refreshControl
        
        tableView.estimatedRowHeight = 5.0
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
//        json.jsonInfo2("")
//        archive.loadAll()
        print("info list : \(infoLists.count)")
        print("khong list : \(khongLists.count)")
        print("store list : \(storeLists.count)")
        
        self.tableView?.reloadData()
        refreshControl?.endRefreshing()
        refreshControl!.attributedTitle = NSAttributedString(string: "Last Update: \(getTime())")
        currTime = getTime()
        print("---endrefreshing---")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toViewInfo"{
            if let indexPath = (sender! as AnyObject).tag{
            let picUrl = infoLists[indexPath].infoPic
            let infoDesc = infoLists[indexPath].infoDesc
            let storeText = infoLists[indexPath].storeName
            let qrCode = infoLists[indexPath].qr
            
            (segue.destination as!
                ViewInformationViewController).picUrl = picUrl
            (segue.destination as! ViewInformationViewController).pInfoDesc = infoDesc
            (segue.destination as! ViewInformationViewController).storeName = storeText
            (segue.destination as! ViewInformationViewController).qrString = qrCode
            (segue.destination as! ViewInformationViewController).infoItem = infoLists[indexPath]
            (segue.destination as! ViewInformationViewController).storeItem = storeLists[indexPath]
            }
        }
        
        if segue.identifier == "toStoreDetail" {
            if let indexPath = (sender! as AnyObject).tag{
                (segue.destination as! StoreDetailViewController).storeItem = storeLists[indexPath]

            }
        }
        
    }
    func deleteTapped(_ sender: AnyObject) {
        if let indexPath = sender.tag{
            
            let alertController = UIAlertController(title: "Delete Confirm", message: "Do you want to delete this message?", preferredStyle: .alert)
            
            let OKbutton = UIAlertAction(title: "Ok", style: .default){
                (action)-> Void in
                //delete
                print(indexPath)
                infoLists.remove(at: indexPath)
                khongLists.remove(at: indexPath)
                storeLists.remove(at: indexPath)
//                self.infoFiltered.removeAtIndex(indexPath)
                self.archive.saveAll()
//                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                let index = IndexPath(row: indexPath, section: 0)
                if self.tableView.numberOfRows(inSection: indexPath) == 1{
                    self.tableView.deleteSections(IndexSet(integer: indexPath), with: .automatic)
                }else{
                self.tableView.deleteRows(at: [index], with: .fade)
                }
            }
            let CancelButton = UIAlertAction(title: "Cancel", style: .cancel){
                (action)-> Void in
            }
            alertController.addAction(OKbutton)
            alertController.addAction(CancelButton)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func favoriteTapped(_ sender: AnyObject) {
        if let indexPath = sender.tag{
            json.jsonFavorite(fb_id: fb_id, info_id: infoLists[indexPath].infoId)
            
            let traget = infoLists[indexPath]
            infoLists[indexPath].toggleStatus()
            
            if traget.isFavorite == true{
                favoriteLists.append(infoLists[indexPath])
            }else{
                let index = favoriteLists.index(where: {$0.infoId == infoLists[indexPath].infoId})
                favoriteLists.remove(at: index!)
            }
            self.archive.saveFavorite()
            self.archive.saveInfoItems()
//            print("favorite : " + infoLists[indexPath].infoName)
            let index = IndexPath(row: indexPath, section: 0)
            self.tableView.reloadRows(at: [index], with: .none)
        }
    }
    
    func shareTapped(_ sender: AnyObject) {
        if let indexPath = sender.tag{
            let shareToFacebook : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            shareToFacebook.setInitialText("Test")
            if let url = URL(string: infoLists[indexPath].infoPic) {
                if let data = try? Data(contentsOf: url){
                    shareToFacebook.add(UIImage(data: data))
                }
            }
            present(shareToFacebook, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        let messageLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        if infoLists.isEmpty{
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
    
    func filter(_ catagory: String) -> Bool{
        if !items.isEmpty{
            for i in 0...6{
                if items[i].text == catagory{
                    if items[i].checked == true{
                        return true
                    }else{
                        return false
                    }
                }
            }
        }
        return true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
//        return promotionName.count
        return infoLists.count
    }
    func cellButtonTapped(_ cell: FeedInfoTableViewCell) {
        let indexPath = self.tableView.indexPathForRow(at: cell.center)!
        cellIndex = (indexPath as NSIndexPath).row
        
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedInfoTableViewCell
        cell.deleteDelegate = self
        cell.shareDelegate = self
        cell.favoriteDelegate = self
        if storeLists.count == infoLists.count{
            
//            cell.hidden = false
        let picUrl = infoLists[(indexPath as NSIndexPath).row].infoPic
        let infoText = infoLists[(indexPath as NSIndexPath).row].infoName
        let infoDes = infoLists[(indexPath as NSIndexPath).row].infoDesc
        let storeText = infoLists[(indexPath as NSIndexPath).row].storeName
        let qrcode = infoLists[(indexPath as NSIndexPath).row].qr
        let storeUrl = storeLists[(indexPath as NSIndexPath).row].storePic
        cell.myImage.downloadedFrom(link: picUrl)
//            cell.myImage.image = UIImage(picUrl)
        
        if qrcode == "nil"{
        cell.preQR.isHidden = true
        }else if qrcode == ""{
        cell.preQR.isHidden = true
            print("Something worng with QRCode : " + String((indexPath as NSIndexPath).row))
        }else{
         cell.preQR.isHidden = false
            print("QRCode at " + String((indexPath as NSIndexPath).row) + " : " + qrcode)
        }
        
            if infoLists[(indexPath as NSIndexPath).row].isFavorite == true{
                cell.likeButton.setImage(UIImage(named: "star51_yellow.png"), for: UIControlState())
            }else{
                cell.likeButton.setImage(UIImage(named: "star51.png"), for: UIControlState())
            }
            
        cell.storePic.downloadedFrom(link: storeUrl)
        cell.storePic.layer.borderWidth = 1
        cell.storePic.layer.masksToBounds = false
        cell.storePic.layer.borderColor = UIColor.white.cgColor
        cell.storePic.layer.cornerRadius = cell.storePic.frame.height/2
        cell.storePic.clipsToBounds = true
        cell.imageButton.tag = (indexPath as NSIndexPath).row
        cell.myStore.tag = (indexPath as NSIndexPath).row
        cell.shareButton.tag = (indexPath as NSIndexPath).row
        cell.likeButton.tag = (indexPath as NSIndexPath).row
        cell.deleteButton.tag = (indexPath as NSIndexPath).row
            
        
//        cell.shareButton.setImage(UIImage(named: "arrow423.png"), forState: UIControlState.Normal)
//        cell.likeButton.setImage(UIImage(named: "star51.png"), forState: UIControlState.Normal)
//        cell.deleteButton.setImage(UIImage(named: "waste2.png"), forState: UIControlState.Normal)
            
            let date = infoLists[(indexPath as NSIndexPath).row].detectTime
            
            cell.detectTime.text = Date().offsetFrom(date)
        cell.myInfo.text = infoText
        cell.myDesc.text = infoDes
        cell.myStore.setTitle(storeText, for: UIControlState())
        archive.saveAll()
        }
        return cell
        
    }

    
    
//    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
//        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
//            completion(data: data)
//            }.resume()
//    }
    
    
//    func downloadImage(url:NSURL){
//        print("Started downloading \"\(url.lastPathComponent!.stringByDeletingPathExtension)\".")
//        getDataFromUrl(url) { data in
//            dispatch_async(dispatch_get_main_queue()) {
//                print("Finished downloading \"\(url.lastPathComponent!.stringByDeletingPathExtension)\".")
//                imageURL.image = UIImage(data: data!)
//            }
//        }
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//
//        if editingStyle == .Delete {
//                infoLists.removeAtIndex(indexPath.row)
//                khongLists.removeAtIndex(indexPath.row)
//                storeLists.removeAtIndex(indexPath.row)
//                archive.saveAll()
//            
//            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        }
//
//        
//}
    

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

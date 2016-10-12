//
//  StoreDetailViewController.swift
//  Promotion2You_2
//
//  Created by Apple Macintosh on 5/11/15.
//  Copyright (c) 2015 Apple Macintosh. All rights reserved.
//

import UIKit
import CoreData
class StoreDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var openTime: UILabel!
    @IBOutlet weak var address: UILabel!
    
//    var storeData : AnyObject?
    var storeName = ""
    var picUrl = "http://www.telekhong.me.ipv4.sixxs.org/images/store/"
    var storeDetail = ""
    var storeItem = storeObj()
    var storeId = ""
    
    let archive = archiveFunction()
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }

    
    @IBAction func subscribe() {
        let alertController = UIAlertController(title: "Followed", message: "Congreatulation, you Followed \(storeName)", preferredStyle: .alert)
        let OKbutton = UIAlertAction(title: "Ok", style: .default){
            (action)-> Void in
            print("you pressed Ok")
            followLists.append(self.storeItem)
            self.archive.saveFollow()
        }
        
        alertController.addAction(OKbutton)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.height = 500
        
        if storeItem.storeId.isEmpty{
        let index = storeLists.index(where: {$0.storeId == storeId})
            storeItem = storeLists[index!]
        }
            storeName = storeItem.storeName
            picUrl = storeItem.storePic
            storeDetail = storeItem.storeDetail
        
        self.title = storeName
        
        print("index is :" + String(describing: index))

        imageView.downloadedFrom(link: picUrl)
        
        detail.text = storeDetail
        openTime.text = storeItem.storeOpentime
        address.text = storeItem.storeAddress
        tel.text = storeItem.storeTel
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//            (segue.destinationViewController as! SubscribeTableViewController).storeName.append(storeName)
    }
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

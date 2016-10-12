//
//  ViewInformationViewController.swift
//  TeleKhong
//
//  Created by SleepyJob on 5/22/2558 BE.
//  Copyright (c) 2558 SleepyJob. All rights reserved.
//

import UIKit
import CoreData
import Social
import FBSDKShareKit
import AVFoundation

class ViewInformationViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var qrcode: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoDesc: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var qrCodeButton: UIButton!
    
    var json = JSONFunction()
    var infoItem = InfoObj()
    var storeItem = storeObj()
    var storeName = ""
    var isFavorited = false
    var picUrl = ""
    var storeUrl = ""
    var pInfoDesc = ""
    var qrString = ""
    let archive = archiveFunction()
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    @IBAction func getQrCode(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "QR CODE", message: "QR CODE : ", preferredStyle: .alert)
        let imageView = UIImageView(frame: CGRect(x: 100, y: 10, width: 40, height: 40))
        imageView.image = generateQRCodeFromString(qrString)

        
        let Cancel = UIAlertAction(title: "Ok", style: .cancel){
            (action)-> Void in
        }
        alertController.addAction(Cancel)
        alertController.view.addSubview(imageView)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if infoItem.isFavorite == true{
            favoriteButton.setImage(UIImage(named: "star51_yellow.png"), for: UIControlState())
        }else{
            favoriteButton.setImage(UIImage(named: "star51.png"), for: UIControlState())
        }
    }
    
    
    @IBAction func Share(_ sender: AnyObject) {
        let shareToFacebook : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        shareToFacebook.setInitialText("Test")
        if let url = URL(string: picUrl) {
            if let data = try? Data(contentsOf: url){
                shareToFacebook.add(UIImage(data: data))
            }
        }
        present(shareToFacebook, animated: true, completion: nil)
    }
    
    
    @IBAction func Favorite() {
        
        
        infoItem.toggleStatus()
        json.jsonFavorite(fb_id: fb_id, info_id: infoItem.infoId)
        if infoItem.isFavorite == true {
            let alertController = UIAlertController(title: "Favorited", message: "Congreatulation, you Favorited \(storeName)", preferredStyle: .alert)
            
            let OKbutton = UIAlertAction(title: "Ok", style: .default){
                (action)-> Void in
                print("you pressed Ok")
                    favoriteLists.append(self.infoItem)
                self.favoriteButton.setImage(UIImage(named: "star51_yellow.png"), for: UIControlState())
            }
            alertController.addAction(OKbutton)
            self.present(alertController, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Unfavorited", message: "you are unfavorited \(storeName)", preferredStyle: .alert)
            let OKbutton = UIAlertAction(title: "Ok", style: .default){
                (action)-> Void in
                print("you pressed Ok")
                let index = favoriteLists.index(where: {$0.infoId == self.infoItem.infoId})
                favoriteLists.remove(at: index!)
                self.favoriteButton.setImage(UIImage(named: "star51.png"), for: UIControlState())
            }
            alertController.addAction(OKbutton)
            self.present(alertController, animated: true, completion: nil)
        }
        archive.saveFavorite()
        archive.saveInfoItems()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize.height = 450
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        storeName = infoItem.infoName
        picUrl = infoItem.infoPic
        qrString = infoItem.qr
        pInfoDesc = infoItem.infoDesc
        
        self.title = storeName
        
        
        
        imageView.downloadedFrom(link: picUrl)
        infoDesc.text = pInfoDesc
        if qrString != "nil"{
        qrcode.image = generateQRCodeFromString(qrString)
            
        }
    }
    func generateQRCodeFromString(_ string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.isoLatin1)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.applying(transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if storeItem.storeName.isEmpty {
            (segue.destination as! StoreDetailViewController).storeId = infoItem.storeId
        }else{
            (segue.destination as! StoreDetailViewController).storeItem = self.storeItem
        }
        
//        (segue.destinationViewController as! StoreDetailViewController).storeName = storeName
//        (segue.destinationViewController as! StoreDetailViewController).storeData = storeData
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

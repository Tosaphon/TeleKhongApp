//
//  RegisterViewController.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 14/10/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class RegisterViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var bdTxt: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var submitButton: UIButton!
    var genderTxt = ""
    let json = JSONFunction()
    
//    var LoginFunc = LoginFacebookViewController()
    
    @IBAction func Cancel(_ sender: AnyObject) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        let protectedPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginFacebookViewController") as! LoginFacebookViewController
        let protectedPageNav = UINavigationController(rootViewController: protectedPage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = protectedPageNav
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: AnyObject) {
        if (nameTxt.text == "" || emailTxt.text == "" || bdTxt.text == "" || genderTxt == "") {
            let alertController = UIAlertController(title: "Empty text", message: "Please enter your information to continue.", preferredStyle: .alert)
            
            let OKbutton = UIAlertAction(title: "Ok", style: .default){
                (action)-> Void in
                print("you pressed Ok")
            }
            alertController.addAction(OKbutton)
            self.present(alertController, animated: true, completion: nil)
        }else{
            json.jsonLogin(fb_id, gender: genderTxt, birth: bdTxt.text!, name: nameTxt.text!)
            let protectedPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginFacebookViewController") as! LoginFacebookViewController
            let protectedPageNav = UINavigationController(rootViewController: protectedPage)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = protectedPageNav
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func bdTxtEdited(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(RegisterViewController.datePickerValueChanged(_:)), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(_ sender:UIDatePicker) {
        
//        let dateFormatter = NSDateFormatter()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
//        let dateFormatter = NSDateFormatter.dateFormatFromTemplate("MMddyyyy", options: 0, locale: NSLocale(localeIdentifier: "en-GB"))
        bdTxt.text = dateFormatter.string(from: sender.date)
        
        
    }
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        let oldTxt : NSString = bdTxt.text!
//        let newTxt : NSString = oldTxt.stringByReplacingCharactersInRange(range, withString: string)
//            submitButton.enabled = (newTxt.length > 0)
//        return true
//    }
//    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        bdTxt.delegate = self
        getUserInfo()
    }
    
    func getUserInfo(){
        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, picture.type(large), email"], tokenString: FBSDKAccessToken.current().tokenString, version: nil, httpMethod: "GET")
        req?.start(completionHandler: { (connection, result, error : NSError!) -> Void in
            if(error == nil)
            {
                self.nameTxt.text = result["name"] as? String
                self.emailTxt.text = result["email"] as? String
            }
            else
            {
                print("error \(error)")
            }
        })
    }
    
    func segmentedControlValueChanged(_ segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            genderTxt = "Male"
        }else if segment.selectedSegmentIndex == 1{
            genderTxt = "Female"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
//        submitButton.enabled = false
        gender.addTarget(self, action: #selector(RegisterViewController.segmentedControlValueChanged(_:)), for: UIControlEvents.valueChanged)
        
        
        
        // Do any additional setup after loading the view.
    }
    func DismissKeyboard(){
        view.endEditing(true)
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

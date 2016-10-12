
import UIKit
import CoreData
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

var profile = [facebookProfile]()


class LoginFacebookViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
//    var fb_id = ""
    var fb_name = ""
    var fb_email = ""
    var isMem : Bool = false
    var lookingForObj : Looking?
    var looking = Looking()
    let json = JSONFunction()
    
    let archive = archiveFunction()
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        archive.loadProfile()
    }

    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
                print(fb_id)
                loginButton.delegate = self
                loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (FBSDKAccessToken.current() != nil && profile.isEmpty != true){
            json.jsonLogin(profile[0].id, gender: "", birth: "", name: "")
            status = "true"
                goToHomePage()
        }
        print(status)
    }
    
    func goToRegisterPage(){
        let protectedPage = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        let protectedPageNav = UINavigationController(rootViewController: protectedPage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = protectedPageNav
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
    
    func getUserInfo(){
        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, picture.type(large), email"], tokenString: FBSDKAccessToken.current().tokenString, version: nil, httpMethod: "GET")
        req?.start(completionHandler: { (connection, result, error : NSError!) -> Void in
            if(error == nil)
            {
                if let r = result{
                self.fb_name = r["name"] as! String
                self.fb_email = r["email"] as! String
                    fb_id = r["id"] as! String
                }
            }
            else
            {
                print("error \(error)")
            }
        })
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        let p = facebookProfile()
        if ((error) != nil)
        {
            // Process error
            print(error.localizedDescription)
            return
        }
        if let userToken = result.token{
            _ = userToken
            print("Token = \(FBSDKAccessToken.current().tokenString))")
            print("User ID = \(FBSDKAccessToken.current().userID))")
            fb_id = FBSDKAccessToken.current().userID
            json.jsonCheckLogin(fb_id)
            p.id = FBSDKAccessToken.current().userID
            profile.append(p)
            archive.saveProfile()
            let identify = Identify(id: FBSDKAccessToken.current().userID)
            
            identify.login{ (isOK) -> Void in
                if (isOK) {
                    print(isOK)
                    items = self.looking.getData()
                    self.getUserInfo()
                    self.json.jsonLogin(fb_id, gender: "", birth: "", name: self.fb_name)
                    self.goToHomePage()
                    //do good stuff here
                }else{
                    self.goToRegisterPage()
                    // do error handling here
                }
            }
            
            
            
//            if status == "true" {
//                print("status login is : true")
//                items = looking.getData()
//                getUserInfo()
//                json.jsonLogin(fb_id, gender: "", birth: "", name: fb_name)
//                //setup setting
//                goToHomePage()
//            }else if status == "false"{
//                print("status login is : false")
//                goToRegisterPage()
////                goToHomePage()
//            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("loged out")
    }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
}

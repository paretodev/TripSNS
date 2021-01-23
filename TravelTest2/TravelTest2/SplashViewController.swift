//
//  ViewController.swift
//  TravelTest2
//
//  Created by 한석희 on 1/13/21.
//

import UIKit
import Alamofire

class SplashViewController: UIViewController {
    
    var userToken : String = ""
    var directSegue : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userToken =  UserDefaults.standard.string(forKey: "UserToken") ?? ""
        if !userToken.isEmpty{
            ApiMananger.sharedInstance.callingTokenValidCheckAPI(token: userToken){ isValid in
                self.directSegue = isValid
            }
        }
        //
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            if self.directSegue == true {
                print("me")
                self.performSegue(withIdentifier: "TokenValidServiceMain", sender: nil)
            }
            else {
                print("me2")
                self.performSegue(withIdentifier: "LogInVC", sender: nil)
            }
        }
        //
    }

    //MARK : Segue Prep
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "TokenValidServiceMain"{
            let controller = (segue.destination as! ServiceMainViewController)
            controller.userToken = self.userToken
            controller.objectID = UserDefaults.standard.string(forKey: "ObjectID")! // 자동적으로 두 가지가 동시에 저장됨.
        }
    }
    //
}


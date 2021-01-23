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
        userToken =  UserDefaults.standard.string(forKey: "UserToken") ?? ""
        //MARK:- [내용 정리] Token이 있을 경우 조회 후, 자동 로그인에 활용 / ObjectID도 넘겨주어야 하는 이유 작성
        if !(userToken.isEmpty){
            ApiMananger.sharedInstance.callingTokenValidCheckAPI(token: userToken){ isValid in
                self.directSegue = isValid
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            if directSegue == true {
                self.performSegue(withIdentifier: "TokenValidServiceMain", sender: nil)
            }
            else {
                self.performSegue(withIdentifier: "LogInVC", sender: nil)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MARK:- UserDefault에 저장해놓았던 Token이 유효할 경우
        if segue.identifier == "TokenValidServiceMain"{
            let controller = (segue.destination as! ServiceMainViewController)
            controller.userToken = self.userToken
            controller.objectID = UserDefaults.standard.string(forKey: "ObjectID")!
        }
    }
    
    //MARK:- End of VC.
}


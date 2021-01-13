//
//  ViewController.swift
//  TravelTest2
//
//  Created by 한석희 on 1/13/21.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "LogInVC", sender: nil)
        }
        //
    }

}


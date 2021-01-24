//
//  ServiceMainViewController.swift
//  TravelTest2
//
//  Created by 한석희 on 1/18/21.
//

import UIKit

class ServiceMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //
    @IBOutlet weak var mainTableView: UITableView!
    //
    var userToken : String!
    var objectID : String!
    var data = ["1","2","3"]
    
    //MARK:- Check For Memory Leak
    deinit {
        print("ServiceMainViewController Deinited 👍🏻.")
    }
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
            print("Segue Delivered User Token : ", userToken)
            print("Segue Delivered Object ID : ", objectID)
        
        //MARK:- TableView Delegation
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseIdentifier", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]

        // Configure the cell...

        return cell
    }
    //
}

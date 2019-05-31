//
//  NursingFacltViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 31/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class NursingFacltSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lastSearchTableView: UITableView!
    @IBOutlet weak var SearchField: UITextField!
    
    var SearchLast : [String] = []
    
    var myurl = "https://openapi.gg.go.kr/ChildBringingUpFacility?KEY=edca732aac4047cabe0b0508aba9616d&pIndex=1&pSize=100&SIGUN_NM="
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("View ReLoaded!")
        print(SearchLast)
        
        lastSearchTableView!.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "segueToNursingInfoTableView"
        {
            if let navController = segue.destination as? UITableViewController
            {
                if let nursingFacltTableViewController = navController as? NursingFacltTableViewController
                {
                    nursingFacltTableViewController.cityname = SearchField.text
                    let sigunname = SearchField.text!
                    SearchLast.append(sigunname)
                    let sigunname_utf8 = sigunname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                    nursingFacltTableViewController.url = myurl + sigunname_utf8
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return SearchLast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = SearchLast[indexPath.row]
        
        return cell
    }
    
}


//
//  SearchViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 29/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var lastSearchTableView: UITableView!
    @IBOutlet weak var SearchField: UITextField!
    
    var myurl = "https://openapi.gg.go.kr/ChildPlayFacility?KEY=edca732aac4047cabe0b0508aba9616d&pIndex=1&pSize=100&SIGUN_NM="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "segueToPlayInfoTableView"
        {
            if let navController = segue.destination as? UITableViewController
            {
                if let playinfoTableViewController = navController as? PlayInfoTableViewController
                {
                    print(SearchField.text as Any)
                    playinfoTableViewController.cityname = SearchField.text
                    let sigunname = SearchField.text!
                    let sigunname_utf8 = sigunname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                    playinfoTableViewController.url = myurl + sigunname_utf8
                    print(playinfoTableViewController.url)
                }
            }
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

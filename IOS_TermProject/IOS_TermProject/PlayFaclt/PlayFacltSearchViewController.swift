//
//  SearchViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 29/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lastSearchTableView: UITableView!
    @IBOutlet weak var SearchField: UITextField!
    
    var SearchLast : [String] = []
    
    var myurl = "https://openapi.gg.go.kr/ChildPlayFacility?KEY=edca732aac4047cabe0b0508aba9616d&pIndex=1&pSize=1000&SIGUN_NM="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lastSearchTableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("View ReLoaded!")
        print(SearchLast)
        
        lastSearchTableView!.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print(segue.identifier)
        if segue.identifier == "segueToPlayInfoTableView"
        {
            if let navController = segue.destination as? UITableViewController
            {
                if let playinfoTableViewController = navController as? PlayInfoTableViewController
                {
                    playinfoTableViewController.cityname = SearchField.text
                    let sigunname = SearchField.text!
                    SearchLast.append(sigunname)
                    let sigunname_utf8 = sigunname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                    playinfoTableViewController.url = myurl + sigunname_utf8
                }
            }
        }
        if segue.identifier == "segueToPlayInfoTableViewFromTable"
        {
            if let navController = segue.destination as? UITableViewController
            {
                if let cell = sender as? UITableViewCell
                {
                    if let playinfoTableViewController = navController as? PlayInfoTableViewController
                    {
                        print(cell.textLabel?.text)
                        playinfoTableViewController.cityname = cell.textLabel?.text
                        let sigunname = cell.textLabel?.text
                        let sigunname_utf8 = sigunname!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                        playinfoTableViewController.url = myurl + sigunname_utf8
                    }
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
        cell.backgroundColor = UIColor.clear
        var bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.cyan.withAlphaComponent(0.2)
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .began{
            print("began")
        }
        if sender.state == .ended{
            print("ended")
        }
        if sender.state == .changed{
            print("changed")
        }
        if sender.state == .cancelled{
            print("cancelled")
        }
        if sender.state == .failed{
            print("failed")
        }
        if sender.state == .possible{
            print("possible")
        }
        if sender.state == .ended{
            let point = sender.location(in: self.view)
            let stars = StardustView(frame: CGRect(x: point.x, y: point.y, width: 2, height: 2))
            self.view.addSubview(stars)
            self.view.sendSubviewToBack(_: stars)
        }
        sender.cancelsTouchesInView = false
    }

}

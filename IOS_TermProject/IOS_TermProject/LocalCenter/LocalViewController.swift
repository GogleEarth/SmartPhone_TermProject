//
//  LocalViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 09/06/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class LocalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate {
    
    // MARK: - Properties
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchFooter: SearchFooter!
    
    var detailViewController: LocalCenterDetailTableViewController? = nil
    var filteredCandies = [Local]()
    var candies = [Local]()
    let searchController = UISearchController(searchResultsController: nil)
    
    var url : String = "https://openapi.gg.go.kr/ChildWelfareRegionChildCener?KEY=edca732aac4047cabe0b0508aba9616d&pIndex=1&pSize=1000"
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var FACLT_NM = NSMutableString() //이름
    var REFINE_LOTNO_ADDR = NSMutableString() // 주소
    var REFINE_WGS84_LOGT = NSMutableString() //xpos
    var REFINE_WGS84_LAT = NSMutableString() //ypos
    var WELFARE_FACLT_TELNO = NSMutableString() // 전화번호
    var FACLT_PSN_CAPA = NSMutableString() // 정원수
    
    // MARK: - View Setup
    func searchBarIsEmpty() -> Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All"){
        filteredCandies = candies.filter({(candy : Local) -> Bool in
            let doesCategoryMatch = (scope == "All") || (candy.addr == scope)
            
            if searchBarIsEmpty(){
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && candy.name.lowercased().contains(searchText.lowercased())
            }
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && !searchBarIsEmpty() || searchBarScopeIsFiltering
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Name"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        searchController.searchBar.delegate = self
        
        tableView.tableFooterView = searchFooter
        
        beginParsing()
        var count = 0
        for post in posts{
            let name = (post as AnyObject).value(forKey: "FACLT_NM") as! NSMutableString as String
            let addr = (post as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSMutableString as String
            
            candies.append(Local(name: name, addr: addr, index: count))
            count = count + 1
        }
        
        //if let splitViewController = splitViewController {
        //    let controllers = splitViewController.viewControllers
        //    detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? LocalCenterDetailTableViewController
        //}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //if splitViewController!.isCollapsed {
        //    if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
        //        self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
        //    }
        //}
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering(){
            searchFooter.setIsFilteringToShow(filteredItemCount: filteredCandies.count, of: candies.count)
            return filteredCandies.count
        }
        searchFooter.setNotFiltering()
        return candies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let candy : Local
        if isFiltering(){
            candy = filteredCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        cell.textLabel!.text = candy.name
        cell.detailTextLabel!.text = candy.addr
        return cell
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToLocalDetail"
        {
            if let cell = sender as? UITableViewCell
            {
                var candy : Local?
                if let indexPath = tableView.indexPathForSelectedRow {
                    if isFiltering(){
                        candy = filteredCandies[indexPath.row]
                    } else {
                        candy = candies[indexPath.row]
                    }
                }
                if let localCenterDetailTableViewController = segue.destination as? LocalCenterDetailTableViewController
                {
                    localCenterDetailTableViewController.FACLT_NM = (posts.object(at: candy!.index) as AnyObject).value(forKey: "FACLT_NM") as! NSMutableString as String
                    localCenterDetailTableViewController.REFINE_LOTNO_ADDR = (posts.object(at: candy!.index) as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSMutableString as String
                    localCenterDetailTableViewController.REFINE_WGS84_LOGT = (posts.object(at: candy!.index) as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSMutableString as String
                    localCenterDetailTableViewController.REFINE_WGS84_LAT = (posts.object(at: candy!.index) as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSMutableString as String
                    localCenterDetailTableViewController.WELFARE_FACLT_TELNO = (posts.object(at: candy!.index) as AnyObject).value(forKey: "WELFARE_FACLT_TELNO") as! NSMutableString as String
                    localCenterDetailTableViewController.FACLT_PSN_CAPA = (posts.object(at: candy!.index) as AnyObject).value(forKey: "FACLT_PSN_CAPA") as! NSMutableString as String
                }
            }
        }
    }
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf:( URL(string:url))!)!
        parser.delegate = self
        parser.parse()
        tableView!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "row")
        {
            elements = NSMutableDictionary()
            elements = [:]
            FACLT_NM = NSMutableString()
            FACLT_NM = ""
            REFINE_LOTNO_ADDR = NSMutableString()
            REFINE_LOTNO_ADDR = ""
            WELFARE_FACLT_TELNO = NSMutableString()
            WELFARE_FACLT_TELNO = ""
            REFINE_WGS84_LOGT = NSMutableString()
            REFINE_WGS84_LOGT = ""
            REFINE_WGS84_LAT = NSMutableString()
            REFINE_WGS84_LAT = ""
            FACLT_PSN_CAPA = NSMutableString()
            FACLT_PSN_CAPA = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "FACLT_NM")
        {
            FACLT_NM.append(string)
        }
        else if element.isEqual(to: "REFINE_LOTNO_ADDR")
        {
            REFINE_LOTNO_ADDR.append(string)
        }
        else if element.isEqual(to: "REFINE_WGS84_LOGT")
        {
            REFINE_WGS84_LOGT.append(string)
        }
        else if element.isEqual(to: "REFINE_WGS84_LAT")
        {
            REFINE_WGS84_LAT.append(string)
        }
        else if element.isEqual(to: "WELFARE_FACLT_TELNO"){
            WELFARE_FACLT_TELNO.append(string)
        }
        else if element.isEqual(to: "FACLT_PSN_CAPA"){
            FACLT_PSN_CAPA.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "row")
        {
            if !FACLT_NM.isEqual(nil)
            {
                elements.setObject(FACLT_NM, forKey: "FACLT_NM" as NSCopying)
            }
            if !REFINE_LOTNO_ADDR.isEqual(nil)
            {
                elements.setObject(REFINE_LOTNO_ADDR, forKey: "REFINE_LOTNO_ADDR" as NSCopying)
            }
            if !REFINE_WGS84_LOGT.isEqual(nil)
            {
                elements.setObject(REFINE_WGS84_LOGT, forKey: "REFINE_WGS84_LOGT" as NSCopying)
            }
            if !REFINE_WGS84_LAT.isEqual(nil)
            {
                elements.setObject(REFINE_WGS84_LAT, forKey: "REFINE_WGS84_LAT" as NSCopying)
            }
            if !FACLT_PSN_CAPA.isEqual(nil){
                elements.setObject(FACLT_PSN_CAPA, forKey: "FACLT_PSN_CAPA" as NSCopying)
            }
            if !WELFARE_FACLT_TELNO.isEqual(nil){
                elements.setObject(WELFARE_FACLT_TELNO, forKey: "WELFARE_FACLT_TELNO" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
}

extension LocalViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        //let searchBar = searchController.searchBar
        //let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension LocalViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        filterContentForSearchText(searchBar.text!)
    }
}

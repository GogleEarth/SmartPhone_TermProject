//
//  HouseInfoTableViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 31/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class HouseInfoTableViewController: UITableViewController, XMLParserDelegate {
    var cityname : String?
    @IBOutlet var PlayInfoTableView: UITableView!
    
    var url : String?
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var KIDGARTN_NM = NSMutableString() //이름
    var REFINE_LOTNO_ADDR = NSMutableString() // 주소
    var KIDGARTN_DIV_NM = NSMutableString() //유형
    var REFINE_WGS84_LOGT = NSMutableString() //xpos
    var REFINE_WGS84_LAT = NSMutableString() //ypos
    var KIDGARTN_TELNO = NSMutableString() // 전화번호
    var PSN_CAPA_CNT = NSMutableString() // 정원수
    
    var hospitalname = ""
    var hospitalname_utf8 = ""
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf:( URL(string:url!))!)!
        parser.delegate = self
        parser.parse()
        PlayInfoTableView!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "row")
        {
            elements = NSMutableDictionary()
            elements = [:]
            KIDGARTN_NM = NSMutableString()
            KIDGARTN_NM = ""
            REFINE_LOTNO_ADDR = NSMutableString()
            REFINE_LOTNO_ADDR = ""
            KIDGARTN_DIV_NM = NSMutableString()
            KIDGARTN_DIV_NM = ""
            REFINE_WGS84_LOGT = NSMutableString()
            REFINE_WGS84_LOGT = ""
            REFINE_WGS84_LAT = NSMutableString()
            REFINE_WGS84_LAT = ""
            KIDGARTN_TELNO = NSMutableString()
            KIDGARTN_TELNO = ""
            PSN_CAPA_CNT = NSMutableString()
            PSN_CAPA_CNT = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "KIDGARTN_NM")
        {
            KIDGARTN_NM.append(string)
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
        else if element.isEqual(to: "KIDGARTN_DIV_NM"){
            KIDGARTN_DIV_NM.append(string)
        }
        else if element.isEqual(to: "KIDGARTN_TELNO"){
            KIDGARTN_TELNO.append(string)
        }
        else if element.isEqual(to: "PSN_CAPA_CNT"){
            PSN_CAPA_CNT.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "row")
        {
            if !KIDGARTN_NM.isEqual(nil)
            {
                elements.setObject(KIDGARTN_NM, forKey: "KIDGARTN_NM" as NSCopying)
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
            if !KIDGARTN_DIV_NM.isEqual(nil){
                elements.setObject(KIDGARTN_DIV_NM, forKey: "KIDGARTN_DIV_NM" as NSCopying)
            }
            if !KIDGARTN_TELNO.isEqual(nil){
                elements.setObject(KIDGARTN_TELNO, forKey: "KIDGARTN_TELNO" as NSCopying)
            }
            if !PSN_CAPA_CNT.isEqual(nil){
                elements.setObject(PSN_CAPA_CNT, forKey: "PSN_CAPA_CNT" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "KIDGARTN_NM") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSString as String
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailHouseInfo"
        {
            if let cell = sender as? UITableViewCell
            {
                let indexPath = tableView.indexPath(for: cell)
                if let houseDetailTableViewController = segue.destination as? HouseDetailTableViewController
                {
                    houseDetailTableViewController.KIDGARTN_NM = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "KIDGARTN_NM") as! NSMutableString as String
                    houseDetailTableViewController.REFINE_LOTNO_ADDR = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSMutableString as String
                    houseDetailTableViewController.KIDGARTN_DIV_NM = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "KIDGARTN_DIV_NM") as! NSMutableString as String
                    houseDetailTableViewController.REFINE_WGS84_LOGT = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSMutableString as String
                    houseDetailTableViewController.REFINE_WGS84_LAT = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSMutableString as String
                    houseDetailTableViewController.KIDGARTN_TELNO = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "KIDGARTN_TELNO") as! NSMutableString as String
                    houseDetailTableViewController.PSN_CAPA_CNT = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "PSN_CAPA_CNT") as! NSMutableString as String
                }
            }
        }
    }
}

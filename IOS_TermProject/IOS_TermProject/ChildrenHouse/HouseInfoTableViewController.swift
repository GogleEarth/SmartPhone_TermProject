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
    var PLAY_FACLT_NM = NSMutableString() //이름
    var REFINE_LOTNO_ADDR = NSMutableString() // 주소
    var PRVATE_PUBL_DIV_NM = NSMutableString() //공공?
    var REFINE_WGS84_LOGT = NSMutableString() //xpos
    var REFINE_WGS84_LAT = NSMutableString() //ypos
    var INOUTDR_DIV_NM = NSMutableString() //실내실외?
    var INSTL_DE = NSMutableString() //건설일자
    var INSTL_PLC = NSMutableString() //위치?
    
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
            PLAY_FACLT_NM = NSMutableString()
            PLAY_FACLT_NM = ""
            REFINE_LOTNO_ADDR = NSMutableString()
            REFINE_LOTNO_ADDR = ""
            PRVATE_PUBL_DIV_NM = NSMutableString()
            PRVATE_PUBL_DIV_NM = ""
            REFINE_WGS84_LOGT = NSMutableString()
            REFINE_WGS84_LOGT = ""
            REFINE_WGS84_LAT = NSMutableString()
            REFINE_WGS84_LAT = ""
            INOUTDR_DIV_NM = NSMutableString()
            INOUTDR_DIV_NM = ""
            INSTL_DE = NSMutableString()
            INSTL_DE = ""
            INSTL_PLC = NSMutableString()
            INSTL_PLC = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "PLAY_FACLT_NM")
        {
            PLAY_FACLT_NM.append(string)
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
        else if element.isEqual(to: "PRVATE_PUBL_DIV_NM"){
            PRVATE_PUBL_DIV_NM.append(string)
        }
        else if element.isEqual(to: "INOUTDR_DIV_NM"){
            INOUTDR_DIV_NM.append(string)
        }
        else if element.isEqual(to: "INSTL_DE"){
            INSTL_DE.append(string)
        }
        else if element.isEqual(to: "INSTL_PLC"){
            INSTL_PLC.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "row")
        {
            if !PLAY_FACLT_NM.isEqual(nil)
            {
                elements.setObject(PLAY_FACLT_NM, forKey: "PLAY_FACLT_NM" as NSCopying)
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
            if !PRVATE_PUBL_DIV_NM.isEqual(nil){
                elements.setObject(PRVATE_PUBL_DIV_NM, forKey: "PRVATE_PUBL_DIV_NM" as NSCopying)
            }
            if !INOUTDR_DIV_NM.isEqual(nil){
                elements.setObject(INOUTDR_DIV_NM, forKey: "INOUTDR_DIV_NM" as NSCopying)
            }
            if !INSTL_DE.isEqual(nil){
                elements.setObject(INSTL_DE, forKey: "INSTL_DE" as NSCopying)
            }
            if !INSTL_PLC.isEqual(nil){
                elements.setObject(INSTL_PLC, forKey: "INSTL_PLC" as NSCopying)
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
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "PLAY_FACLT_NM") as! NSString as String
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
                    houseDetailTableViewController.PLAY_FACLT_NM = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "PLAY_FACLT_NM") as! NSMutableString as String
                    houseDetailTableViewController.REFINE_LOTNO_ADDR = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSMutableString as String
                    houseDetailTableViewController.PRVATE_PUBL_DIV_NM = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "PRVATE_PUBL_DIV_NM") as! NSMutableString as String
                    houseDetailTableViewController.REFINE_WGS84_LOGT = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSMutableString as String
                    houseDetailTableViewController.REFINE_WGS84_LAT = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSMutableString as String
                    houseDetailTableViewController.INOUTDR_DIV_NM = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "INOUTDR_DIV_NM") as! NSMutableString as String
                    houseDetailTableViewController.INSTL_DE = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "INSTL_DE") as! NSMutableString as String
                    houseDetailTableViewController.INSTL_PLC = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "INSTL_PLC") as! NSMutableString as String
                }
            }
        }
    }
}

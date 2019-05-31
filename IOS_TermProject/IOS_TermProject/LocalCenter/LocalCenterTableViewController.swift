//
//  LocalCenterTableViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 31/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class LocalCenterTableViewController: UITableViewController, XMLParserDelegate {
    var cityname : String?
    @IBOutlet var PlayInfoTableView: UITableView!
    
    var url : String?
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "FACLT_NM") as! NSString as String
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
        if segue.identifier == "segueToLocalDetailInfoTableView"
        {
            if let cell = sender as? UITableViewCell
            {
                let indexPath = tableView.indexPath(for: cell)
                if let localCenterDetailTableViewController = segue.destination as? LocalCenterDetailTableViewController
                {
                    localCenterDetailTableViewController.FACLT_NM = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "FACLT_NM") as! NSMutableString as String
                    localCenterDetailTableViewController.REFINE_LOTNO_ADDR = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSMutableString as String
                    localCenterDetailTableViewController.REFINE_WGS84_LOGT = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSMutableString as String
                    localCenterDetailTableViewController.REFINE_WGS84_LAT = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSMutableString as String
                    localCenterDetailTableViewController.WELFARE_FACLT_TELNO = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "WELFARE_FACLT_TELNO") as! NSMutableString as String
                    localCenterDetailTableViewController.FACLT_PSN_CAPA = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "FACLT_PSN_CAPA") as! NSMutableString as String
                }
            }
        }
    }
}

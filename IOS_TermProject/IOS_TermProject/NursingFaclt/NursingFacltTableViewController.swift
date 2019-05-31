//
//  NursingFacltTableViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 31/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class NursingFacltTableViewController: UITableViewController, XMLParserDelegate {
    var cityname : String?
    @IBOutlet var PlayInfoTableView: UITableView!
    
    var url : String?
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var FACLT_NM = NSMutableString() // 시설이름
    var REFINE_LOTNO_ADDR = NSMutableString() // 주소
    var FACLTCHEF_NM = NSMutableString() //시설장명
    var TELNO = NSMutableString() // 전화번호
    var ACEPTNC_CHILD_PSN_CAPA = NSMutableString() // 수용아동정원
    var ACEPTNC_CHILD_NOWPSN_CNT = NSMutableString() // 수용아동현재원
    var ENFLPSN_CNT = NSMutableString() // 종사자수
    var REFINE_WGS84_LOGT = NSMutableString() //xpos
    var REFINE_WGS84_LAT = NSMutableString() //ypos
    
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
            FACLTCHEF_NM = NSMutableString()
            FACLTCHEF_NM = ""
            REFINE_WGS84_LOGT = NSMutableString()
            REFINE_WGS84_LOGT = ""
            REFINE_WGS84_LAT = NSMutableString()
            REFINE_WGS84_LAT = ""
            TELNO = NSMutableString()
            TELNO = ""
            ACEPTNC_CHILD_PSN_CAPA = NSMutableString()
            ACEPTNC_CHILD_PSN_CAPA = ""
            ACEPTNC_CHILD_NOWPSN_CNT = NSMutableString()
            ACEPTNC_CHILD_NOWPSN_CNT = ""
            ENFLPSN_CNT = NSMutableString()
            ENFLPSN_CNT = ""
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
        else if element.isEqual(to: "FACLTCHEF_NM"){
            FACLTCHEF_NM.append(string)
        }
        else if element.isEqual(to: "TELNO"){
            TELNO.append(string)
        }
        else if element.isEqual(to: "ACEPTNC_CHILD_PSN_CAPA"){
            ACEPTNC_CHILD_PSN_CAPA.append(string)
        }
        else if element.isEqual(to: "ACEPTNC_CHILD_NOWPSN_CNT"){
            ACEPTNC_CHILD_NOWPSN_CNT.append(string)
        }
        else if element.isEqual(to: "ENFLPSN_CNT"){
            ENFLPSN_CNT.append(string)
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
            if !FACLTCHEF_NM.isEqual(nil){
                elements.setObject(FACLTCHEF_NM, forKey: "FACLTCHEF_NM" as NSCopying)
            }
            if !TELNO.isEqual(nil){
                elements.setObject(TELNO, forKey: "TELNO" as NSCopying)
            }
            if !ACEPTNC_CHILD_PSN_CAPA.isEqual(nil){
                elements.setObject(ACEPTNC_CHILD_PSN_CAPA, forKey: "ACEPTNC_CHILD_PSN_CAPA" as NSCopying)
            }
            if !ACEPTNC_CHILD_NOWPSN_CNT.isEqual(nil){
                elements.setObject(ACEPTNC_CHILD_NOWPSN_CNT, forKey: "ACEPTNC_CHILD_NOWPSN_CNT" as NSCopying)
            }
            if !ENFLPSN_CNT.isEqual(nil){
                elements.setObject(ENFLPSN_CNT, forKey: "ENFLPSN_CNT" as NSCopying)
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
        if segue.identifier == "segueToDetailNursingInfo"
        {
            if let cell = sender as? UITableViewCell
            {
                let indexPath = tableView.indexPath(for: cell)
                if let nursingFacltDetailTableViewController = segue.destination as? NursingFacltDetailTableViewController
                {
                    nursingFacltDetailTableViewController.FACLT_NM = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "FACLT_NM") as! NSMutableString as String
                    nursingFacltDetailTableViewController.REFINE_LOTNO_ADDR = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSMutableString as String
                    nursingFacltDetailTableViewController.FACLTCHEF_NM = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "FACLTCHEF_NM") as! NSMutableString as String
                    nursingFacltDetailTableViewController.REFINE_WGS84_LOGT = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSMutableString as String
                    nursingFacltDetailTableViewController.REFINE_WGS84_LAT = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSMutableString as String
                    nursingFacltDetailTableViewController.TELNO = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "TELNO") as! NSMutableString as String
                    nursingFacltDetailTableViewController.ACEPTNC_CHILD_PSN_CAPA = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "ACEPTNC_CHILD_PSN_CAPA") as! NSMutableString as String
                    nursingFacltDetailTableViewController.ACEPTNC_CHILD_NOWPSN_CNT = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "ACEPTNC_CHILD_NOWPSN_CNT") as! NSMutableString as String
                    nursingFacltDetailTableViewController.ENFLPSN_CNT = (posts.object(at: indexPath!.row) as AnyObject).value(forKey: "ENFLPSN_CNT") as! NSMutableString as String
                }
            }
        }
    }
}

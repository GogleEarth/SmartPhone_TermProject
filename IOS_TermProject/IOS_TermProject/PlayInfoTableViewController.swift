//
//  PlayInfoTableViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 30/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class PlayInfoTableViewController: UITableViewController, XMLParserDelegate {
    var cityname : String?
    @IBOutlet var PlayInfoTableView: UITableView!
    
    var url : String?
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var PALY_FACLT_NM = NSMutableString()
    var REFINE_LOTNO_ADDR = NSMutableString() // 주소
    var PRVATE_PUBL_DIV_NM = NSMutableString() //공공?
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
            PALY_FACLT_NM = NSMutableString()
            PALY_FACLT_NM = ""
            REFINE_LOTNO_ADDR = NSMutableString()
            REFINE_LOTNO_ADDR = ""
            PRVATE_PUBL_DIV_NM = NSMutableString()
            PRVATE_PUBL_DIV_NM = ""
            REFINE_WGS84_LOGT = NSMutableString()
            REFINE_WGS84_LOGT = ""
            REFINE_WGS84_LAT = NSMutableString()
            REFINE_WGS84_LAT = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "PALY_FACLT_NM")
        {
            PALY_FACLT_NM.append(string)
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
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "row")
        {
            if !PALY_FACLT_NM.isEqual(nil)
            {
                elements.setObject(PALY_FACLT_NM, forKey: "PALY_FACLT_NM" as NSCopying)
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
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "PALY_FACLT_NM") as! NSString as String
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//       if segue.identifier == "segueToMapView"
//       {
//            if let mapViewController = segue.destination as? MapViewController
//            {
//               mapViewController.posts = posts
//            }
//        }
//
//        if segue.identifier == "segueToHospitalDetail"
//        {
//            if let cell = sender as? UITableViewCell
//            {
//                let indexPath = tableView.indexPath(for: cell)
//                hospitalname = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "yadmNm") as! NSString as String
//                hospitalname_utf8 = hospitalname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//                if let detailHospitalTableViewController = segue.destination as? DetailHospitalTableViewController
//                {
//                    detailHospitalTableViewController.url = url! + "&yadmNm=" + hospitalname_utf8
//                }
//            }
//        }
//    }

}

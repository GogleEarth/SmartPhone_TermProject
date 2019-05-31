//
//  PlayDetailTableViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 30/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class PlayDetailTableViewController: UITableViewController {
    
    
    var PLAY_FACLT_NM : String? //이름
    var REFINE_LOTNO_ADDR : String? // 주소
    var PRVATE_PUBL_DIV_NM : String? //공공?
    var REFINE_WGS84_LOGT : String? //xpos
    var REFINE_WGS84_LAT : String? //ypos
    var INOUTDR_DIV_NM : String? //실내실외?
    var INSTL_DE : String? //건설일자
    var INSTL_PLC : String? //위치?
    
    let postsname : [String] = ["이름", "주소", "설치일자", "설치장소", "민간공공구분명", "실내외구분명", "위도", "경도", ]
    var posts : [String] = ["","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posts[0] = PLAY_FACLT_NM!
        posts[1] = REFINE_LOTNO_ADDR!
        posts[2] = INSTL_DE!
        posts[3] = INSTL_PLC!
        posts[4] = PRVATE_PUBL_DIV_NM!
        posts[5] = INOUTDR_DIV_NM!
        posts[6] = REFINE_WGS84_LAT!
        posts[7] = REFINE_WGS84_LOGT!
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = postsname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToMapView"
        {
            if let mapViewController = segue.destination as? MapViewController
            {
                mapViewController.PLAY_FACLT_NM = PLAY_FACLT_NM!
                mapViewController.REFINE_LOTNO_ADDR = REFINE_LOTNO_ADDR!
                mapViewController.xpos = (REFINE_WGS84_LOGT as! NSMutableString as NSString).doubleValue
                mapViewController.ypos = (REFINE_WGS84_LAT as! NSMutableString as NSString).doubleValue
            }
        }
    }

}

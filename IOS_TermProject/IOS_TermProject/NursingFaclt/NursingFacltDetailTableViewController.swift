//
//  NursingFacltDetailTableViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 31/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class NursingFacltDetailTableViewController: UITableViewController {
    
    
    var FACLT_NM : String? // 시설이름
    var REFINE_LOTNO_ADDR : String? // 주소
    var FACLTCHEF_NM : String? //시설장명
    var TELNO : String? // 전화번호
    var ACEPTNC_CHILD_PSN_CAPA : String? // 수용아동정원
    var ACEPTNC_CHILD_NOWPSN_CNT : String? // 수용아동현재원
    var ENFLPSN_CNT : String? // 종사자수
    var REFINE_WGS84_LOGT : String? //xpos
    var REFINE_WGS84_LAT : String? //ypos
    
    let postsname : [String] = ["시설이름", "주소", "시설장명", "전화번호", "수용아동정원", "수용아동현재원", "종사자수", "위도", "경도"]
    var posts : [String] = ["","","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posts[0] = FACLT_NM!
        posts[1] = REFINE_LOTNO_ADDR!
        posts[2] = FACLTCHEF_NM!
        posts[3] = TELNO!
        posts[4] = ACEPTNC_CHILD_PSN_CAPA!
        posts[5] = ACEPTNC_CHILD_NOWPSN_CNT!
        posts[6] = ENFLPSN_CNT!
        posts[7] = REFINE_WGS84_LAT!
        posts[8] = REFINE_WGS84_LOGT!
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
                mapViewController.PLAY_FACLT_NM = FACLT_NM!
                mapViewController.REFINE_LOTNO_ADDR = REFINE_LOTNO_ADDR!
                mapViewController.xpos = (REFINE_WGS84_LOGT as! NSMutableString as NSString).doubleValue
                mapViewController.ypos = (REFINE_WGS84_LAT as! NSMutableString as NSString).doubleValue
            }
        }
    }
    
}

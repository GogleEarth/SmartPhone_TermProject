//
//  HouseDetailTableViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 31/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class HouseDetailTableViewController: UITableViewController {
    
    
    var KIDGARTN_NM : String? //이름
    var REFINE_LOTNO_ADDR : String? // 주소
    var KIDGARTN_DIV_NM : String? //유형
    var REFINE_WGS84_LOGT : String? //xpos
    var REFINE_WGS84_LAT : String? //ypos
    var KIDGARTN_TELNO : String? // 전화번호
    var PSN_CAPA_CNT : String? // 정원수
    
    let postsname : [String] = ["어린이집명", "주소", "어린이집유형구분", "정원수", "어린이집전화번호", "위도", "경도" ]
    var posts : [String] = ["","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "어린이집 이미지.png")!)
        self.tableView.backgroundView?.alpha = 0.5
        
        posts[0] = KIDGARTN_NM!
        posts[1] = REFINE_LOTNO_ADDR!
        posts[2] = KIDGARTN_DIV_NM!
        posts[3] = PSN_CAPA_CNT!
        posts[4] = KIDGARTN_TELNO!
        posts[5] = REFINE_WGS84_LAT!
        posts[6] = REFINE_WGS84_LOGT!
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
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = postsname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToMapView"
        {
            if let mapViewController = segue.destination as? MapViewController
            {
                mapViewController.PLAY_FACLT_NM = KIDGARTN_NM!
                mapViewController.REFINE_LOTNO_ADDR = REFINE_LOTNO_ADDR!
                mapViewController.xpos = (REFINE_WGS84_LOGT as! NSMutableString as NSString).doubleValue
                mapViewController.ypos = (REFINE_WGS84_LAT as! NSMutableString as NSString).doubleValue
            }
        }
    }
    
}

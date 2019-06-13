//
//  LocalCenterDetailTableViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 31/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class LocalCenterDetailTableViewController: UITableViewController {
    
    @IBOutlet var DetailTableView: UITableView!
    
    var FACLT_NM : String? //이름
    var REFINE_LOTNO_ADDR : String? // 주소
    var REFINE_WGS84_LOGT : String? //xpos
    var REFINE_WGS84_LAT : String? //ypos
    var WELFARE_FACLT_TELNO : String? // 전화번호
    var FACLT_PSN_CAPA : String? // 정원수
    
    let postsname : [String] = ["시설명", "주소", "전화번호", "정원수","위도", "경도" ]
    var posts : [String] = ["","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posts[0] = FACLT_NM!
        posts[1] = REFINE_LOTNO_ADDR!
        posts[2] = WELFARE_FACLT_TELNO!
        posts[3] = FACLT_PSN_CAPA!
        posts[4] = REFINE_WGS84_LAT!
        posts[5] = REFINE_WGS84_LOGT!
        
        let backgroundimage = UIImage(named: "아동센터 이미지.png")
        let imageView = UIImageView(image: backgroundimage)
        
        DetailTableView.backgroundView = imageView
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
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
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

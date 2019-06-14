//
//  NursingFacltDetailTableViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 31/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class NursingFacltDetailTableViewController: UITableViewController {
    
    
    @IBOutlet weak var back_button: UIButton!
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
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "보육원 이미지.jpg")!)
        self.tableView.backgroundView?.alpha = 0.5
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
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
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = postsname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.cyan.withAlphaComponent(0.35)
        cell.selectedBackgroundView = bgColorView
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
    
    @IBAction func back_button_action(_ sender: Any) {
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .began{
            print("began")
        }
        if sender.state == .ended{
            print("ended")
        }
        if sender.state == .changed{
            print("changed")
        }
        if sender.state == .cancelled{
            print("cancelled")
        }
        if sender.state == .failed{
            print("failed")
        }
        if sender.state == .possible{
            print("possible")
        }
        if sender.state == .ended{
            let point = sender.location(in: self.view)
            let stars = StardustView(frame: CGRect(x: point.x, y: point.y, width: 2, height: 2))
            self.view.addSubview(stars)
            self.view.sendSubviewToBack(_: stars)
        }
        sender.cancelsTouchesInView = false
    }
    
}

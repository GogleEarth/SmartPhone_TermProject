//
//  ChildrenHouseSearchViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 31/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class ChildrenHouseSearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerDataSource = ["가평군", "고양시", "과천시", "광명구", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시", "양평군", "여주시", "연천군", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"]
    var cityName : String = "가평군"
    var myurl = "https://openapi.gg.go.kr/ChildHouse?KEY=edca732aac4047cabe0b0508aba9616d&pIndex=1&pSize=1000&SIGUN_NM="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "segueToHouseInfoTableView"
        {
            if let navController = segue.destination as? UITableViewController
            {
                if let houseinfoTableViewController = navController as? HouseInfoTableViewController
                {
                    print("\(cityName)")
                    houseinfoTableViewController.cityname = cityName
                    let sigunname = cityName
                    let sigunname_utf8 = sigunname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                    houseinfoTableViewController.url = myurl + sigunname_utf8
                }
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityName = pickerDataSource[row]
    }

}

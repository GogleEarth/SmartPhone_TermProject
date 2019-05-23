//
//  ViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 20/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBAction func doneToPickerViewController(segue:UIStoryboardSegue)
    {
    }
    
    var pickerDataSource = ["놀이시설", "어린이집", "지역 아동센터", "아동양육시설"]
    var myurl = "http://apis.data.go.kr/B551182/hospInfoService/getHospBasisList?pageNo=1&numOfRows=10&serviceKey=sea100UMmw23Xycs33F1EQnumONR%2F9ElxBLzkilU9Yr1oT4TrCot8Y2p0jyuJP72x9rG9D8CN5yuEs6AS2sAiw%3D%3D&sidoCd=110000&sgguCd="
    var sgguCd: String = "110023"
    
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
        if row == 0
        {
            sgguCd = "110023"
        }
        else if row == 1
        {
            sgguCd = "110005"
        }
        else if row == 2
        {
            sgguCd = "110007"
        }
        else
        {
            sgguCd = "110016"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "segueToTableView"
        {
            if let navController = segue.destination as? UINavigationController
            {
                
            }
        }
    }

}

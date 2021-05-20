//
//  ViewController_2.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/21.
//
import UIKit

class ViewController_2: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
 
    @IBOutlet weak var pickerView: UIPickerView!
    var pickerDataSource = ["서울특별시", "부산광역시", "대구광역시", "인천시", "광주시", "대전시", "울산시", "경기도", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주도"]
    
    var url : String = "http://apis.data.go.kr/B552584/EvCharger/getChargerInfo?serviceKey=S8rzdkL5i25h2g%2Bk0QgRu%2B4GJ8ShKEiyJAR1xCDbaOj%2Ffh2BCT04Om0AKgQx4mSH1Cu%2BK3GOIB2GwivyW%2B1FSg%3D%3D&pageNo=1&numOfRows=100&zcode="
    var zcode : String = "11" // 서울시
    


    @IBAction func doneToPickerViewController(segue: UIStoryboardSegue){
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            zcode = "11" //서울특별시
        } else if row == 1{
            zcode = "26"  //부산광역시
        } else if row == 2 {
            zcode = "27"   //대구시
        } else if row == 3 {
            zcode = "28"   //인천시
        } else if row == 4{
            zcode = "29"  //광주시
        } else if row == 5 {
            zcode = "30"   //대전시
        } else if row == 6 {
            zcode = "31"   //울산시
        } else if row == 7{
            zcode = "41"  //경기도
        } else if row == 8 {
            zcode = "42"   //강원도
        } else if row == 9 {
            zcode = "43"   //충북도
        } else if row == 10{
            zcode = "44"  //충남도
        } else if row == 11 {
            zcode = "45"   //전북도
        } else if row == 12 {
            zcode = "46"   //전남도
        } else if row == 13{
            zcode = "47"  //경북도
        } else if row == 14 {
            zcode = "48"   //경남도
        } else if row == 15 {
            zcode = "50"   //제주도
        } else {
            zcode = "11"   //종로구
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTableView" {
            if let navController = segue.destination as? UINavigationController {
                if let chargingStationTableViewController = navController.topViewController as?
                    ChargingStationTableViewController {
                    chargingStationTableViewController.url = url + zcode
                }
            }
        }
    }
    
override func viewDidLoad() {
    super.viewDidLoad()
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}


}

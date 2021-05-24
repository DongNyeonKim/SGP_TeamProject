//
//  CarSubsidyViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/24.
//

import UIKit

class CarSubsidyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet var tbData: UITableView!
    let cellIdentifier: String = "CarSubsidyCell"
    
    let hyundai_car: [String] = ["코나\n기본형, PTC, 모던)","코나\n(기본형, PTC, 프리미엄)","코나\n(기본형, HP, 모던)","코나\n(기본형, HP, 프리미엄)","코나\n(경제형, PTC, 모던)","코나\n(경제형, PTC, 프리미엄)","코나\n(경제형, HP, 모던)","코나\n(경제형, HP, 프리미엄)","아이오닉(HP)","아이오닉(PTC)","아이오닉5\n(롱레인지 2WD, 프레스티지)","아이오닉5\n(롱레인지 2WD, 익스클루시브,\n빌트인 캠 미적용)","아이오닉5\n(롱레인지 2WD, 익스클루시브)","아이오닉5\n(롱레인지 4WD, 프레스티지)","아이오닉5\n(롱레인지 4WD, 익스클루시브, 빌트인캠)"]
    
    let hyundai_subsidy: [String] = ["800"
                                     ,"800"
                                     ,"800"
                                     ,"800"
                                     ,"690"
                                     ,"690"
                                     ,"690"
                                     ,"690"
                                     ,"733"
                                     ,"701"
                                     ,"800"
                                     ,"800"
                                     ,"800"
                                     ,"773"
                                     ,"785"]
    
    let kia_car: [String] = ["니로EV(HP, 프레스티지)",
                             "니로EV(HP, 노블레스)",
                             "니로EV(PTC, 프레스티지)",
                             "니로EV(PTC, 노블레스)",
                             "니로EV(경제형, 프레스티지)",
                             "니로EV(경제형, 노블레스)",
                             "쏘울(기본형, 프레스티지)",
                             "쏘울(기본형, 노블레스)",
                             "쏘울(도심형, 프레스티지)",
                             "쏘울(도심형, 노블레스)"]
    let kia_subsidy: [String] = ["800",
                                "800",
                                "780",
                                "780",
                                "717",
                                "717",
                                "750",
                                "750",
                                "688",
                                "688"]
    
    let samsung_car: [String] = ["ZOE ZEN","ZOE INTENS ECO","ZOE ITENS"]
    let samsung_subsidy: [String] = ["702","702","702"]
    
    
    let bmw_car: [String] = ["i3 120Ah Lux","i3 120Ah SoL+"]
    let bmw_subsidy: [String] = ["673","673"]
    
    let gm_car: [String] = ["BOLT EV LT","BOLT EV Primier"]
    let gm_subsidy: [String] = ["760","760"]
    
    let hbmotors_car: [String] = ["Peugeot e-208 Allure","Peugeot e-208 GT Line","DS3 E-tense So Chic","DS3 E-tense Grand Chic", "Peugeot e-2008 SUV Allure","Peugeot e-2008 SUV GT Line"]
    let hbmotors_subsidy: [String] = ["649","649","605","605","605","605"]
    
    let tesla_car: [String] = ["Model S(Long Range)","Model S(Performance)","Model 3(SRP RWD)" ,"Model 3(Long Range)","Model 3(Performance)","Model 3(SRP RWD HPL)","Model 3(Long Range HPC)","Model 3(Performance HPL)","Model Y(Long Range)","Model Y(Performance)","Model 3(Long Range HPL)","Model Y(Standard Range)"]
    let tesla_subsidy: [String] = ["-","-","684","682","329","730","750","375","375","372","750","742"]
    
    let jaguer_car: [String] = ["I-PACE EV400 SE","I-PACE EV400 HSE"]
    let jaguer_subsidy: [String] = ["-","-"]

    let benz_car: [String] = ["EQC 400 4M","EQC 400 4MATIC(1886)","EQC 400 4MATIC Premium","EQC 400 4MATIC","EQC 400 4MATIC AMG Line"]
    let benz_subsidy: [String] = ["-","-","-","-","-"]
    
    let semi_car: [String] = ["SMART EV Z"]
    let semi_subsidy: [String] = ["639"]
    
    let small_car: [String] = ["르노삼성\nTWIZY(K1J05)","대창모터스\nDANIGO","케이에스티일레트릭\n마이브 M1","캠시스\nCEVO-C","캠시스\nCEVO-C SE"]
    let small_subsidy: [String] = ["400","400","400","400","400"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbData.delegate = self
        self.tbData.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.hyundai_car.count
        case 1:
            return self.kia_car.count
        case 2:
            return self.samsung_car.count
        case 3:
            return self.bmw_car.count
        case 4:
            return self.gm_car.count
        case 5:
            return self.hbmotors_car.count
        case 6:
            return self.tesla_car.count
        case 7:
            return self.jaguer_car.count
        case 8:
            return self.benz_car.count
        case 9:
            return self.semi_car.count
        case 10:
            return self.small_car.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CarSubsidyCell", for: indexPath)
        cell.textLabel?.numberOfLines = 3
        if (indexPath.section == 0){
            cell.textLabel?.text = hyundai_car[indexPath.row]
            if (hyundai_subsidy[indexPath.row] == "-"){
                cell.detailTextLabel?.text = "미지원"
            }
            else {
            cell.detailTextLabel?.text = hyundai_subsidy[indexPath.row] + "만원"
            }
        }
        else if (indexPath.section == 1){
            cell.textLabel?.text = kia_car[indexPath.row]
            if (kia_subsidy[indexPath.row] == "-"){
                cell.detailTextLabel?.text = "미지원"
            }
            else {
            cell.detailTextLabel?.text = kia_subsidy[indexPath.row] + "만원"
            }
        }
        else if (indexPath.section == 2){
            cell.textLabel?.text = samsung_car[indexPath.row]
            if (samsung_subsidy[indexPath.row] == "-"){
                cell.detailTextLabel?.text = "미지원"
            }
            else {
            cell.detailTextLabel?.text = samsung_subsidy[indexPath.row] + "만원"
            }
        }
        else if (indexPath.section == 3){
            cell.textLabel?.text = bmw_car[indexPath.row]
            if (bmw_subsidy[indexPath.row] == "-"){
                cell.detailTextLabel?.text = "미지원"
            }
            else {
            cell.detailTextLabel?.text = bmw_subsidy[indexPath.row] + "만원"
            }
        }
        else if (indexPath.section == 4){
            cell.textLabel?.text = gm_car[indexPath.row]
            if (gm_subsidy[indexPath.row] == "-"){
                cell.detailTextLabel?.text = "미지원"
            }
            else {
            cell.detailTextLabel?.text = gm_subsidy[indexPath.row] + "만원"
            }
        }
        else if (indexPath.section == 5){
            cell.textLabel?.text = hbmotors_car[indexPath.row]
            if (hbmotors_subsidy[indexPath.row] == "-"){
                cell.detailTextLabel?.text = "미지원"
            }
            else {
            cell.detailTextLabel?.text = hbmotors_subsidy[indexPath.row] + "만원"
            }
        }
        else if (indexPath.section == 6){
            cell.textLabel?.text = tesla_car[indexPath.row]
            if (tesla_subsidy[indexPath.row] == "-"){
                cell.detailTextLabel?.text = "미지원"
            }
            else {
            cell.detailTextLabel?.text = tesla_subsidy[indexPath.row] + "만원"
            }
        }
        else if (indexPath.section == 7){
            cell.textLabel?.text = jaguer_car[indexPath.row]
            if (jaguer_subsidy[indexPath.row] == "-"){
                cell.detailTextLabel?.text = "미지원"
            }
            else {
            cell.detailTextLabel?.text = jaguer_subsidy[indexPath.row] + "만원"
            }
        }
        else if (indexPath.section == 8){
            cell.textLabel?.text = benz_car[indexPath.row]
            if (benz_subsidy[indexPath.row] == "-"){
                cell.detailTextLabel?.text = "미지원"
            }
            else {
            cell.detailTextLabel?.text = benz_subsidy[indexPath.row] + "만원"
            }
        }
        else if (indexPath.section == 9){
            cell.textLabel?.text = semi_car[indexPath.row]
            if (semi_subsidy[indexPath.row] == "-"){
                cell.detailTextLabel?.text = "미지원"
            }
            else {
            cell.detailTextLabel?.text = semi_subsidy[indexPath.row] + "만원"
            }
        }
        else if (indexPath.section == 10){
            cell.textLabel?.text = small_car[indexPath.row]
            if (small_subsidy[indexPath.row] == "-"){
                cell.detailTextLabel?.text = "미지원"
            }
            else {
            cell.detailTextLabel?.text = small_subsidy[indexPath.row] + "만원"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "현대"
        case 1:
            return "기아"
        case 2:
            return "르노삼성"
        case 3:
            return "BMW"
        case 4:
            return "한국GM"
        case 5:
            return "한불모터스"
        case 6:
            return "테슬라"
        case 7:
            return "재규어"
        case 8:
            return "벤츠"
        case 9:
            return "쎄미시스코"
        case 10:
            return "초소형"
        default:
            return ""
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

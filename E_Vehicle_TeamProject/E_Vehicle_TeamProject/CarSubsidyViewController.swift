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
    
    let hyundai_car: [String] = ["코나(기본형, PTC, 모던)","코나(기본형, PTC, 프리미엄)","코나(기본형, HP, 모던)","코나(기본형, HP, 프리미엄)","코나(경제형, PTC, 모던)","코나(경제형, PTC, 프리미엄)"," 코나(경제형, HP, 모던)"," 코나(경제형, HP, 프리미엄)","아이오닉(HP)"," 아이오닉(PTC)","아이오닉5(롱레인지 2WD, 프레스티지)","아이오닉5(롱레인지 2WD, 익스클루시브, 빌트인 캠 미적용)","아이오닉5(롱레인지 2WD, 익스클루시브)","아이오닉5(롱레인지 4WD, 프레스티지)","아이오닉5\n(롱레인지 4WD, 익스클루시브, 빌트인캠)"]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbData.delegate = self
        self.tbData.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.hyundai_car.count
        case 1:
            return self.kia_car.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CarSubsidyCell", for: indexPath)
        cell.textLabel?.numberOfLines = 2
        if (indexPath.section == 0){
            cell.textLabel?.text = hyundai_car[indexPath.row]
            cell.detailTextLabel?.text = hyundai_subsidy[indexPath.row]
        }
        else if (indexPath.section == 1){
            cell.textLabel?.text = kia_car[indexPath.row]
            cell.detailTextLabel?.text = kia_subsidy[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "현대"
        case 1:
            return "기아"
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

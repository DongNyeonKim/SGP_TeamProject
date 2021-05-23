//
//  SubsidyViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/24.
//

import UIKit

class SubsidyViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet var tbData: UITableView!
    
    var sido = ["서울","부산","대구","인천","광주","대전","울산","세종","경기","강원","충북","충남","전북","전남","경북","경남","제주"]
    var carsubsidy = ["1200만원", "1250만원","1250만원","1280만원","1300만원","1500만원","1350만원","1100만원","1300만원","1320만원","1600만원","1800만원","1700만원","1760만원","1400만원","1400만원","1250만원"]
    var scarsubsidy = ["680만원", "700만원","600만원","640만원","650만원","700만원","675만원","550만원","900만원","660만원","900만원","910만원","650만원","960만원","900만원","800만원","800만원"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbData.delegate = self
        tbData.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sido.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SidoSubsidyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SidoSubsidyCell", for: indexPath) as! SidoSubsidyTableViewCell
        // Cell Label의 내용 지정
        cell.sidoLabel.text = sido[indexPath.row]
        cell.carSubsidyLabel.text = carsubsidy[indexPath.row]
        cell.scarSubsidyLabel.text = scarsubsidy[indexPath.row]
        // 생성한 Cell 리턴
        return cell
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

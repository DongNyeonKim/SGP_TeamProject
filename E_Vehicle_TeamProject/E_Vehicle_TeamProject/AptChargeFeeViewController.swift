//
//  AptChargeFeeViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/23.
//

import UIKit

class AptChargeFeeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var tbData: UITableView!
    
    var time = ["경부하 시간대","중간부하 시간대","최대부하 시간대"]
    var detailtime = ["23~09시", "09~10시, 12~13시, 17~23시", "10~12시, 13~17시"]
    var fee = ["182.27 원","227.15 원","255.75 원"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbData.delegate = self
        tbData.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AptChargeFeeCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AptChargeFeeCell", for: indexPath) as! AptChargeFeeCellTableViewCell
        // Cell Label의 내용 지정
        cell.TimeLabel.text = time[indexPath.row]
        cell.DetailTimeLabel.text = detailtime[indexPath.row]
        cell.FeeLabel.text = fee[indexPath.row]
        // 생성한 Cell 리턴
        return cell
    }
    
    @IBAction func didchangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0
        {
            time = ["경부하 시간대","중간부하 시간대","최대부하 시간대"]
            detailtime = ["23~09시", "09~10시, 12~13시, 17~23시", "10~12시, 13~17시"]
            fee = ["167.31 원","175.45 원","178.86 원"]
            tbData.reloadData()
        } else if sender.selectedSegmentIndex == 1
        {
            time = ["경부하 시간대","중간부하 시간대","최대부하 시간대"]
            detailtime = ["23~09시", "09~10시, 12~13시, 17~23시", "10~12시, 13~17시"]
            fee = ["182.27 원","227.15 원","255.75 원"]
            tbData.reloadData()
        } else if sender.selectedSegmentIndex == 2
        {
            time = ["경부하 시간대","중간부하 시간대","최대부하 시간대"]
            detailtime = ["23~09시", "09~10시, 12~17시, 20~22시", "10~12시, 17~20시, 22~23시"]
            fee = ["194.15 원","213.29 원","255.75 원"]
            tbData.reloadData()
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

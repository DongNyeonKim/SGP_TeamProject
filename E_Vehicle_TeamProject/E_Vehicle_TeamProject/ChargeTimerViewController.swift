//
//  ChargeTimerViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by KPUGAME on 2021/05/22.
//

import UIKit

class ChargeTimerViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var predictingTime: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var activeTimer: Bool = false
    var timer = Timer()
    
    var hourPickerDataSource = [0...24]
    var minPickerDataSource = [0...60]
    var secPickerDataSource = [0...60]
    
    var hour:Int = 0
    var min:Int = 0
    var sec:Int = 0
    
    var saveHour: Int = 0
    var saveMin: Int = 0
    var saveSec: Int = 0
    
    @IBAction func StartButton() {
        if(!activeTimer){
            activeTimer = true
            pickerView.isHidden = true
            timerLabel.isHidden = false
            if(!timer.isValid) {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.subtrackTime), userInfo: nil, repeats: true)
            }
            button.setTitle("리셋", for: .normal)
            
//            var formatter = DateFormatter()
//            formatter.dateFormat = "HH:mm:ss"
//            var current_date_string = formatter.string(from: Date())
//            print(current_date_string)
            
            let date = Date()
            let date1 = Calendar.current.date(byAdding: .second, value: hour*3600+min*60+sec, to: date)
            var dateFormatter: DateFormatter = {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-dd\nHH:mm:ss"
                
                return dateFormatter
            }()

            predictingTime.text = "예상 충전 완료 시간\n\(dateFormatter.string(from: date1!))"
        }
        else {
            activeTimer = false
            setupTimer()
        }
    }
    
    func setupTimer() {
        hour = 0
        min = 0
        sec = 0
        
        var hstr = String(format: "%02d", hour)
        var mstr = String(format: "%02d", min)
        
        timerLabel.text = "남은시간\n\(hstr):\(mstr):\(sec)"
        timerLabel.isHidden = true
        pickerView.isHidden = false
        predictingTime.text = "             시간            분               초"
        button.setTitle("시작", for: .normal)
    }
    
    @objc func subtrackTime() {
        if(!(hour == 0 && min == 0 && sec == 0)){
            sec -= 1
            
            if(sec == -1){
                sec = 59
                min -= 1
            }
            
            if(min == -1){
                min = 59
                hour -= 1
            }
            
            var hstr = String(format: "%02d", hour)
            var mstr = String(format: "%02d", min)
            
            timerLabel.text = "남은시간\n\(hstr):\(mstr):\(sec)"
        }
        else {
            timer.invalidate()
            timerLabel.text = "충전완료\n00:00:0"
            
            let alertController = UIAlertController(title: "알림", message: "충전이 완료되었습니다!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(defaultAction)
                    
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        setupTimer()
        // Do any additional setup after loading the view.
    }
}

extension ChargeTimerViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 25
        case 1,2:
            return 60

        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3 - 25
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row)"
        case 1:
            return "\(row)"
        case 2:
            return "\(row)"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 1:
            min = row
        case 2:
            sec = row
        default:
            break;
        }
    }
}

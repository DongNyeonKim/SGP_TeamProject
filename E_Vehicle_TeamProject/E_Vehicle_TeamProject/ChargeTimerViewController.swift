//
//  ChargeTimerViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by KPUGAME on 2021/05/22.
//

import UIKit

class ChargeTimerViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!

    var hourPickerDataSource = [0...24]
    var minPickerDataSource = [0...60]
    var secPickerDataSource = [0...60]
    
    var hour:Int = 0
    var min:Int = 0
    var sec:Int = 0
    
    @IBAction func StartButton() {
        
    }
    @IBAction func StopButton() {
        
    }
    @IBAction func ResetButton() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
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

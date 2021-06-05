//
//  ViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/18.
//

import UIKit

class ViewController: UIViewController {
    var buttonDownScale : CGFloat = 0.8
    
    @IBOutlet weak var searchChargingStation: UIButton!
    @IBOutlet weak var timer: UIButton!
    @IBOutlet weak var price: UIButton!
    @IBOutlet weak var subsidy: UIButton!
    @IBOutlet weak var introduce: UIButton!
    @IBOutlet weak var news: UIButton!
    
    @IBAction func FirstButtonDown(_ sender: Any) {
        ButtonDown(button: searchChargingStation, buttonDown: true)
    }
    @IBAction func FirstButtonUp(_ sender: Any) {
        ButtonDown(button: searchChargingStation, buttonDown: false)
    }
    @IBAction func SecondButtonDown(_ sender: Any) {
        ButtonDown(button: timer, buttonDown: true)
    }
    @IBAction func SecondButtonUp(_ sender: Any) {
        ButtonDown(button: timer, buttonDown: false)
    }
    @IBAction func ThirdButtonDown(_ sender: Any) {
        ButtonDown(button: price, buttonDown: true)
    }
    @IBAction func ThirdButtonUp(_ sender: Any) {
        ButtonDown(button: price, buttonDown: false)
    }
    @IBAction func FourthButtonDown(_ sender: Any) {
        ButtonDown(button: subsidy, buttonDown: true)
    }
    @IBAction func FourthButtonUp(_ sender: Any) {
        ButtonDown(button: subsidy, buttonDown: false)
    }
    @IBAction func FifthButtonDown(_ sender: Any) {
        ButtonDown(button: introduce, buttonDown: true)
    }
    @IBAction func FifthButtonUp(_ sender: Any) {
        ButtonDown(button: introduce, buttonDown: false)
    }
    @IBAction func SixthButtonDown(_ sender: Any) {
        ButtonDown(button: news, buttonDown: true)
    }
    @IBAction func SixthButtonUp(_ sender: Any) {
        ButtonDown(button: news, buttonDown: false)
    }
    
    
    @IBAction func doneToPickerViewController(segue:UIStoryboardSegue){
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with Event: UIEvent?) {
        let touch = touches.first
        let loc = touch!.location(in: self.view)
        let startX: CGFloat = loc.x
        let startY: CGFloat = loc.y
        //let endY: CGFloat = ScreenHeight + 100
        
        let stars = StardustView(frame: CGRect(x: startX, y: startY, width: 10, height: 10))
        self.view.addSubview(stars)
        self.view.sendSubviewToBack(_: stars)
        
        UIView.animate(withDuration: 0.2,
                        delay: 0.0,
                        options: UIView.AnimationOptions.curveEaseOut,
                        animations: {
                        stars.center = CGPoint(x: startX, y: startY)
                        },
                        completion: {(value:Bool) in
                        stars.removeFromSuperview()
                        })
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with Event: UIEvent?) {
//        let touch = touches.first
//        let loc = touch!.location(in: self.view)
//        let startX: CGFloat = loc.x
//        let startY: CGFloat = loc.y
//        //let endY: CGFloat = ScreenHeight + 100
//        
//        let stars = StardustView(frame: CGRect(x: startX, y: startY, width: 10, height: 10))
//        self.view.addSubview(stars)
//        self.view.sendSubviewToBack(_: stars)
//        
//        UIView.animate(withDuration: 0.2,
//                        delay: 0.0,
//                        options: UIView.AnimationOptions.curveEaseOut,
//                        animations: {
//                        stars.center = CGPoint(x: startX, y: startY)
//                        },
//                        completion: {(value:Bool) in
//                        stars.removeFromSuperview()
//                        })
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func ButtonDown(button: UIButton, buttonDown: Bool) {
        if(buttonDown) {
            UIView.animate(withDuration: 0.25, animations: {
                button.transform = CGAffineTransform(scaleX: self.buttonDownScale, y: self.buttonDownScale)
            })
        }
        else {
            UIView.animate(withDuration: 0.25, animations: {
                button.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
}


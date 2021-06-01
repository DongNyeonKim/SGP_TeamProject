//
//  ECarSearchViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/31.
//

import UIKit
import SwiftSoup

class ECarSearchViewController: UIViewController {
    
    var sidoArray: [String] = []
    
    var carsArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        crawl()

        // Do any additional setup after loading the view.
    }
    
    func crawl(){
        let url = URL(string: "https://evc.kepco.co.kr:4445/service/service03.do")
      
        guard let myURL = url else {   return    }
        
        do {
            let html = try String(contentsOf: myURL, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            let headerTitle = try doc.title()
            print(headerTitle)
            
            let sidoTitles:Elements = try doc.select(".totalMap").select("dt") //.은 클래스
            
            let sidoCars:Elements = try doc.select(".totalMap").select("dd") //.은 클래스
            
            for i in sidoTitles {
                print("위치: ", try i.text())
                sidoArray.append(try i.text())
            }
            for i in sidoCars {
                print("가격: ", try i.text())
                carsArray.append(try i.text())
            }
            
            
        } catch Exception.Error(let type, let message) {
            print("Message: \(message)")
        } catch {
            print("error")
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

//
//  ECarNewsWebViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/06/02.
//

import UIKit
import WebKit

class ECarNewsWebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    var news_url : String = ""
    
    func goWeb() -> () {
        let url = URL(string: news_url)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goWeb()

        // Do any additional setup after loading the view.
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



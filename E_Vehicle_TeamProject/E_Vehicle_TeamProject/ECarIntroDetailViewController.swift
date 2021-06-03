//
//  ECarIntroDetailViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/06/03.
//

import UIKit

class ECarIntroDetailViewController: UIViewController {
    
    var index: Int!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var LabelOne: UILabel!
    
    @IBOutlet var LabelTwo: UILabel!
    @IBOutlet var LabelThree: UILabel!
    @IBOutlet var LabelFour: UILabel!
    @IBOutlet var LabelFive: UILabel!
    @IBOutlet var LabelSix: UILabel!
    @IBOutlet var LabelSeven: UILabel!
    @IBOutlet var LabelEight: UILabel!
    
    let nameList = ["쏘울 Booster", "니로 EV", "아이오닉 (IONIQ)","코나 EV", "SM3 ZE", "볼트 (BOLT EV)", "i3", "리프 (LEAF)", "모델S" ,"모델3"]
    let urlList = [
        "https://evc.kepco.co.kr:4445/publish/images/sub/car14.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car13.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car05.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car12.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car06.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car11.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car07.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car03.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car08.png" ,
        "https://evc.kepco.co.kr:4445/publish/images/sub/car15.png"]
    let oneList = ["콤보", "콤보", "콤보","콤보", "AC3상", "콤보", "콤보", "차데모", "AC3상" ,"차데모"]
    let twoList = ["391Km", "385Km", "271Km", "406Km", "213Km","383Km", "248Km", "172Km", "378Km", "446Km"]
    let threeList = ["64Kwh", "64Kwh","38.3Kwh","64Kwh","26.6Kwh","60Kwh","37.9Kwh","40Kwh","90Kwh","75Kwh",]
    let fourList = ["약 1시간", "약 1시간","약 30분","약 1시간","약 30분","약 1시간","약 30분","약 30분","약 30분","약 1시간"]
    let fiveList = ["약 9시간", "약 9시간","약 5시간","약 9시간","약 3시간 ~ 4시간","약 9시간","약 3시간 ~ 4시간","약 5시간","약 3시간","약 6시간"]
    let sixList = ["5인승", "5인승","준중형 5인승","5인승","중형 4인승","5인승","준중형 5인승","준중형 5인승","5인승","준중형 5인승"]
    let sevenList = ["155km/h","160km/h","165km/h","167km/h","135km/h","154km/h","150km/h","140km/h","250km/h","261km/h"]
    let eightList = ["2019.02","2018.08","2019.05","2018.04","2013.10","2017.03","2014.04","2014.12","2017","2019.08"]
    let homeURL = [
        "https://www.kia.com/kr/main.html",
        "https://www.kia.com/kr/vehicles/niro-ev/features.html",
        "https://www.hyundai.com/kr/ko/e/vehicles/ioniq5/intro",
        "https://www.hyundai.com/kr/ko/e/",
        "https://www.renaultsamsungm.com/new/main/main.jsp",
        "https://www.chevrolet.co.kr/ev/boltev-highlight.gm",
        "https://www.bmw.co.kr/ko/all-models/bmw-i/i3/2017/at-a-glance.html",
        "https://www.nissan.co.kr/",
        "https://www.tesla.com/ko_KR/models" ,
        "https://www.tesla.com/ko_KR/model3"]
    
    func setData(){
        nameLabel.text = nameList[index]
        
        let url = URL(string: urlList[index])
        let data = try? Data(contentsOf: url!)
        imgView.image = UIImage(data: data!)
        
        LabelOne.text = oneList[index]
        LabelTwo.text = twoList[index]
        LabelThree.text = threeList[index]
        LabelFour.text = fourList[index]
        LabelFive.text = fiveList[index]
        LabelSix.text = sixList[index]
        LabelSeven.text = sevenList[index]
        LabelEight.text = eightList[index]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToECarIntroWebView" {

                if let ecarIntroDetailWebViewController = segue.destination as?
                    ECarIntroDetailWebViewController {
                    ecarIntroDetailWebViewController.news_url = homeURL[index]
                }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
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


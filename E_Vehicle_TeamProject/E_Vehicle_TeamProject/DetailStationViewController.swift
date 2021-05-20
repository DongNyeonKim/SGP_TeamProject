//
//  DetailStationViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/21.
//

import UIKit

class DetailStationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate {

    @IBOutlet var detailTableView: UITableView!
    
    
    var url : String?
    
    var stationName : String?
    
    var parser = XMLParser()
    
    let postsname : [String] = ["충전소명", "충전소 ID", "충전기 ID", "충전기 타입", "주소", "이용가능 시간", "운영기관명", "관리업체 전화번호", "충전기 상태", "상태갱신 일시", "충전기 용량","주차무료 여부", "충전소 안내"]
    
    var posts: [String] = ["","","","","","","","","","","","",""]
    
    var targets: [String] = ["","","","","","","","","","","","",""]
    
    var element = NSString()
    
    var statNm = NSMutableString()
    var statId = NSMutableString()
    var chgerId = NSMutableString()
    var chgerType = NSMutableString()
    var addr = NSMutableString()
    var useTime = NSMutableString()
    var busiNm = NSMutableString()
    var busiCall = NSMutableString()
    var stat = NSMutableString()
    var statUpdDt = NSMutableString()
    var powerType = NSMutableString()
    var parkingFree = NSMutableString()
    var note = NSMutableString()
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string: url!))!)!
        parser.delegate = self
        parser.parse()
        detailTableView!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] )
    {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item")
        {
            posts = ["","","","","","","","","","","","",""]
            
            statNm = NSMutableString()
            statNm = ""
            
            statId = NSMutableString()
            statId = ""
            
            chgerId = NSMutableString()
            chgerId = ""
            
            chgerType = NSMutableString()
            chgerType = ""
            
            addr = NSMutableString()
            addr = ""
            
            useTime = NSMutableString()
            useTime = ""
            
            busiNm = NSMutableString()
            busiNm = ""
            
            busiCall = NSMutableString()
            busiCall = ""
            
            stat = NSMutableString()
            stat = ""
            
            statUpdDt = NSMutableString()
            statUpdDt = ""
            
            powerType = NSMutableString()
            powerType = ""
            
            parkingFree = NSMutableString()
            parkingFree = ""
            
            note = NSMutableString()
            note = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "statNm"){
            statNm.append(string)
        } else if element.isEqual(to: "statId"){
            statId.append(string)
        } else if element.isEqual(to: "chgerId"){
            chgerId.append(string)
        } else if element.isEqual(to: "chgerType"){
            chgerType.append(string)
        } else if element.isEqual(to: "addr"){
            addr.append(string)
        } else if element.isEqual(to: "useTime"){
            useTime.append(string)
        } else if element.isEqual(to: "busiNm"){
            busiNm.append(string)
        } else if element.isEqual(to: "busiCall"){
            busiCall.append(string)
        } else if element.isEqual(to: "stat"){
            stat.append(string)
        } else if element.isEqual(to: "statUpdDt"){
            statUpdDt.append(string)
        } else if element.isEqual(to: "powerType"){
            powerType.append(string)
        } else if element.isEqual(to: "parkingFree"){
            parkingFree.append(string)
        } else if element.isEqual(to: "note"){
            note.append(string)
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqual(to: "item") {

           if statNm.isEqual(stationName) {

                if !statNm.isEqual(nil) {
                    targets[0] = statNm as String
                }
                if !statId.isEqual(nil) {
                    targets[1] = statId as String
                }
                if !chgerId.isEqual(nil) {
                    targets[2] = chgerId as String
                }
                if !chgerType.isEqual(nil) {
                    targets[3] = chgerType as String
                }
                if !addr.isEqual(nil) {
                    targets[4] = addr as String
                }
                if !useTime.isEqual(nil) {
                    targets[5] = useTime as String
                }
                if !busiNm.isEqual(nil) {
                    targets[6] = busiNm as String
                }
                if !busiCall.isEqual(nil) {
                    targets[7] = busiCall as String
                }
                if !stat.isEqual(nil) {
                    targets[8] = stat as String
                }
                if !statUpdDt.isEqual(nil) {
                    targets[9] = statUpdDt as String
                }
                if !powerType.isEqual(nil) {
                    targets[10] = powerType as String
                }
                if !parkingFree.isEqual(nil) {
                    targets[11] = parkingFree as String
                }
                if !note.isEqual(nil) {
                    targets[12] = note as String
                }
                print(targets)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beginParsing()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath)
        cell.textLabel?.text = postsname[indexPath.row]
        cell.detailTextLabel?.text = targets[indexPath.row]
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

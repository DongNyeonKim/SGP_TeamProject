//
//  EcarNewsTableViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/06/01.
//

import UIKit
import SwiftSoup

class EcarNewsTableViewController: UITableViewController {
    
    
    let url = URL(string: "https://m.search.naver.com/search.naver?sm=mtb_hty.top&where=m_news&oquery=%EC%A0%84%EA%B8%B0%EC%9E%90%EB%8F%99%EC%B0%A8&tqi=h7RGTsp0JxGsscHQcv4ssssssll-056302&query=%EC%A0%84%EA%B8%B0%EC%B0%A8")
    
    
    var titlesArray: [String] = []
    
    var articleURLArray: [String] = []
    
    var articleCompanyArray: [String] = []
    
    var articleCompanyImageArray: [String] = []
    
    var articleTimeArray: [String] = []
    
    
    

    override func viewDidLoad() {
        crawl()
        print("done")
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func crawl(){

      
        guard let myURL = url else {   return    }
        
        do {
            let html = try String(contentsOf: myURL, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            let headerTitle = try doc.title()
            print(headerTitle)
            
            let Titles:Elements = try doc.select(".list_news").select(".bx").select(".news_wrap").select(".news_tit").select("div") //.은 클래스
            
            for i in Titles {
                print("제목: ", try i.text())
                titlesArray.append(try i.text())
            }
            
            let articleURLs:Elements = try doc.select(".list_news").select(".bx").select(".news_wrap").select(".news_tit").select("a") //.은 클래스
            
            for i in articleURLs {
                //print("기사 URL: ", try i.attr("href"))
                articleURLArray.append(try i.attr("href"))
            }
            
            let articleCompany:Elements = try doc.select(".list_news").select(".bx").select(".news_wrap").select(".news_info").select(".info_group").select("a")
            
            for i in articleCompany {
                //print("신문사 이름: ", try i.text())
                articleCompanyArray.append(try i.text().trimmingCharacters(in: ["정","선"," ","사","론","언"]))
            }
            
            let articleCompanyImage:Elements = try doc.select(".list_news").select(".bx").select(".news_wrap").select(".news_info").select(".info_group").select("a").select("span").select("img")
            
            for i in articleCompanyImage {
                //print("신문사 로고주소: ", try i.attr("src"))
                articleCompanyImageArray.append(try i.attr("src"))
            }
            
            let articleTime:Elements = try doc.select(".list_news").select(".bx").select(".news_wrap").select(".news_info").select(".info_group").select(".info").select("span:nth-child(2)")

            
            for i in articleTime {
                //print("신문 갱신시간: ", try i.text())
                articleTimeArray.append(try i.text())
            }

            
            
        } catch Exception.Error(let type, let message) {
            print("Message: \(message)")
        } catch {
            print("error")
        }
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 120
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  titlesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ECarNewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EcarNewsCell", for: indexPath) as! ECarNewsTableViewCell
        // Cell Label의 내용 지정
        let url = URL(string: articleCompanyImageArray[indexPath.row])
        let data = try? Data(contentsOf: url!)
        cell.companyImage.image = UIImage(data: data!)
        cell.company.text = articleCompanyArray[indexPath.row]
        cell.time.text = articleTimeArray[indexPath.row]
        //cell.title.adjustsFontSizeToFitWidth = true
        cell.title.text = titlesArray[indexPath.row]
        // 생성한 Cell 리턴
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToNewsWebView" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)

                let url = articleURLArray[indexPath!.row]
                
                if let ecarNewsWebViewController = segue.destination as?
                    ECarNewsWebViewController {
                    ecarNewsWebViewController.news_url = url
                }
                
            }
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ChargingStationWithAddrTableViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/22.
//

import UIKit

class ChargingStationWithAddrTableViewController: UITableViewController, XMLParserDelegate {

    
    @IBOutlet var tbData: UITableView!
    
    
    var url : String?

    
    var parser = XMLParser()
    
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var csNm = NSMutableString()
    var addr = NSMutableString()
    
    var lat = NSMutableString()
    var longi = NSMutableString()
    
    var stationname = ""
    var stationname_utf8 = ""
    
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string:url!))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            csNm = NSMutableString()
            csNm = ""
            addr = NSMutableString()
            addr = ""
            lat = NSMutableString()
            lat = ""
            longi = NSMutableString()
            longi = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "csNm") {
            csNm.append(string)
        } else if element.isEqual(to: "addr") {
            addr.append(string)
        }else if element.isEqual(to: "lat") {
            lat.append(string)
        } else if element.isEqual(to: "longi") {
            longi.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName as NSString).isEqual(to: "item") {
            if !csNm.isEqual(nil) {
                elements.setObject(csNm, forKey: "csNm" as NSCopying)
            }
            if !addr.isEqual(nil){
                elements.setObject(addr, forKey: "addr" as NSCopying)
            }
            if !lat.isEqual(nil) {
                elements.setObject(lat, forKey: "lat" as NSCopying)
            }
            if !longi.isEqual(nil){
                elements.setObject(longi, forKey: "longi" as NSCopying)
            }
            
            posts.add(elements)
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "csNm") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr") as! NSString as String
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToMapViewwithAddr" {
            if let mapViewController = segue.destination as? AllMapwithAddrViewController {
                mapViewController.posts = posts
            }
        }
        if segue.identifier == "segueToStationDetail" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)

                stationname = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "statNm") as! NSString as String

                if let detailstationTableViewController = segue.destination as?
                    DetailStationViewController {
                    detailstationTableViewController.url = url
                    detailstationTableViewController.stationName = stationname
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

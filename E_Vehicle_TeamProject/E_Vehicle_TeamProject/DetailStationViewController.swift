//
//  DetailStationViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/21.
//

import UIKit
import MapKit

class DetailStationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate, MKMapViewDelegate {

    @IBOutlet var detailTableView: UITableView!
    
    @IBOutlet var mapView: MKMapView!
    
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
    
    var lat = NSMutableString()
    var lng = NSMutableString()
    
    var my_lat : String = ""
    var my_lng : String = ""
    
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
            
            lat = NSMutableString()
            lat = ""
            
            lng = NSMutableString()
            lng = ""
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
        } else if element.isEqual(to: "lat"){
            lat.append(string)
        } else if element.isEqual(to: "lng"){
            lng.append(string)
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
                    if(!chgerType.isEqual("01"))
                    {
                        targets[3] = "DC차데모"
                    }
                    else if(!chgerType.isEqual("02"))
                    {
                        targets[3] = "AC완속"
                    }
                    else if(!chgerType.isEqual("03"))
                    {
                        targets[3] = "DC차데모+AC3상"
                    }
                    else if(!chgerType.isEqual("04"))
                    {
                        targets[3] = "DC콤보"
                    }
                    else if(!chgerType.isEqual("05"))
                    {
                        targets[3] = "DC차데모+DC콤보"
                    }
                    else if(!chgerType.isEqual("06"))
                    {
                        targets[3] = "DC차데모+AC상+DC콤보"
                    }
                    else if(!chgerType.isEqual("07"))
                    {
                        targets[3] = "AC3상"
                    }
                    else
                    {
                        targets[3] = "미확인"
                    }
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
                    if(!stat.isEqual("1"))
                    {
                        targets[8] = "통신이상"
                    }
                    else if(!stat.isEqual("2"))
                    {
                        targets[8] = "충전대기"
                    }
                    else if(!stat.isEqual("3"))
                    {
                        targets[8] = "충전중"
                    }
                    else if(!stat.isEqual("4"))
                    {
                        targets[8] = "충전중"
                    }
                    else if(!stat.isEqual("5"))
                    {
                        targets[8] = "충전중"
                    }
                    else
                    {
                        targets[8] = "상태미확인"
                    }
                }
                if !statUpdDt.isEqual(nil) {
                    targets[9] = statUpdDt as String
                }
                if !powerType.isEqual(nil) {
                    targets[10] = powerType as String
                }
                if !parkingFree.isEqual(nil) {
                    if(!parkingFree.isEqual("Y"))
                    {
                        targets[11] = "무료"
                    }
                    else if(!parkingFree.isEqual("N"))
                    {
                        targets[11] = "유료"
                    }
                    else
                    {
                        targets[11] = "현장 확인"
                    }
                }
                if !note.isEqual(nil) {
                    targets[12] = note as String
                }
                if !lat.isEqual(nil) {
                    my_lat = lat as String
                }
                if !lng.isEqual(nil) {
                    my_lng = lng as String
                }
            }
        }
    }
    
    
    let regionRadius: CLLocationDistance = 500
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    var stations : [Station] = []
    
    func loadInitialData() {

            let statNm = targets[0]
            let addr = targets[4]
            let lat = (my_lat as NSString).doubleValue
            let lon = (my_lng as NSString).doubleValue
            let station = Station(title: statNm, locationName: addr, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            stations.append(station)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Station
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Station else {return nil}
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -1, y: 1)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beginParsing()
        let lat = (my_lat as NSString).doubleValue
        let lon = (my_lng as NSString).doubleValue
        let initialLocation = CLLocation(latitude: lat, longitude: lon)
        
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        loadInitialData()
        mapView.addAnnotations(stations)
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

import UIKit
import MapKit

class DetailStationwithAddrViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate, MKMapViewDelegate {

    //@IBOutlet var detailTableView: UITableView!
    
    @IBOutlet var detailTableView: UITableView!
    //@IBOutlet var mapView: MKMapView!
    @IBOutlet var mapView: MKMapView!
    
    var url : String?
    
    var stationName : String?
    
    var parser = XMLParser()
    
    let postsname : [String] = ["충전소 명칭", "충전소 ID", "주소", "충전기 타입", "충전기 명칭", "충전기 ID", "충전기 상태", "충전 방식", "충전기 상태갱신 일시"]
    
    var posts: [String] = ["","","","","","","","",""]
    
    var targets: [String] = ["","","","","","","","",""]
    
    var element = NSString()
    
    var addr = NSMutableString()
    var chargeTp = NSMutableString()
    var cpId = NSMutableString()
    var cpNm = NSMutableString()
    var cpStat = NSMutableString()
    var cpTp = NSMutableString()
    var csId = NSMutableString()
    var csNm = NSMutableString()
    var lat = NSMutableString()
    var longi = NSMutableString()
    var statUpdateDatetime = NSMutableString()
    
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
            posts = ["","","","","","","","",""]
            
            csNm = NSMutableString()
            csNm = ""
            
            csId = NSMutableString()
            csId = ""
            
            addr = NSMutableString()
            addr = ""
            
            chargeTp = NSMutableString()
            chargeTp = ""
            
            cpNm = NSMutableString()
            cpNm = ""
            
            cpId = NSMutableString()
            cpId = ""
            
            cpStat = NSMutableString()
            cpStat = ""
            
            cpTp = NSMutableString()
            cpTp = ""
            
            statUpdateDatetime = NSMutableString()
            statUpdateDatetime = ""
            
            lat = NSMutableString()
            lat = ""
            
            longi = NSMutableString()
            longi = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "csNm"){
            csNm.append(string)
        } else if element.isEqual(to: "csId"){
            csId.append(string)
        } else if element.isEqual(to: "addr"){
            addr.append(string)
        } else if element.isEqual(to: "chargeTp"){
            chargeTp.append(string)
        } else if element.isEqual(to: "cpNm"){
            cpNm.append(string)
        } else if element.isEqual(to: "cpId"){
            cpId.append(string)
        } else if element.isEqual(to: "cpStat"){
            cpStat.append(string)
        } else if element.isEqual(to: "cpTp"){
            cpTp.append(string)
        } else if element.isEqual(to: "statUpdateDatetime"){
            statUpdateDatetime.append(string)
        } else if element.isEqual(to: "lat"){
            lat.append(string)
        } else if element.isEqual(to: "longi"){
            longi.append(string)
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqual(to: "item") {

           if csNm.isEqual(stationName) {

                if !csNm.isEqual(nil) {
                    targets[0] = csNm as String
                }
                if !csId.isEqual(nil) {
                    targets[1] = csId as String
                }
                if !addr.isEqual(nil) {
                    targets[2] = addr as String
                }
                if !chargeTp.isEqual(nil) {
                    if(chargeTp.isEqual("1"))
                    {
                        targets[3] = "완속"
                    }
                    else if(chargeTp.isEqual("2"))
                    {
                        targets[3] = "급속"
                    }
                    else
                    {
                        targets[3] = "미확인"
                    }
                }
                if !cpNm.isEqual(nil) {
                    targets[4] = cpNm as String
                }
                if !cpId.isEqual(nil) {
                    targets[5] = cpId as String
                }
                if !cpStat.isEqual(nil) {
                    if(cpStat.isEqual("1"))
                    {
                        targets[6] = "충전가능"
                    }
                    else if(cpStat.isEqual("2"))
                    {
                        targets[6] = "충전중"
                    }
                    else if(cpStat.isEqual("3"))
                    {
                        targets[6] = "고장/점검"
                    }
                    else if(cpStat.isEqual("4"))
                    {
                        targets[6] = "통신장애"
                    }
                    else if(cpStat.isEqual("5"))
                    {
                        targets[6] = "통신미연결"
                    }
                    else
                    {
                        targets[6] = "통신미연결"
                    }
                }
                if !cpTp.isEqual(nil) {
                    if(cpTp.isEqual("1"))
                    {
                        targets[7] = "B타입(5핀)"
                    }
                    else if(cpTp.isEqual("2"))
                    {
                        targets[7] = "C타입(5핀)"
                    }
                    else if(cpTp.isEqual("3"))
                    {
                        targets[7] = "BC타입(5핀)"
                    }
                    else if(cpTp.isEqual("4"))
                    {
                        targets[7] = "BC타입(7핀)"
                    }
                    else if(cpTp.isEqual("5"))
                    {
                        targets[7] = "DC차데모"
                    }
                    else if(cpTp.isEqual("6"))
                    {
                        targets[7] = "AC3상"
                    }
                    else if(cpTp.isEqual("7"))
                    {
                        targets[7] = "DC콤보"
                    }
                    else if(cpTp.isEqual("8"))
                    {
                        targets[7] = "DC차데모+DC콤보"
                    }
                    else if(cpTp.isEqual("9"))
                    {
                        targets[7] = "DC차데모+AC3상"
                    }
                    else if(cpTp.isEqual("10"))
                    {
                        targets[7] = "DC차데모+DC콤보+AC3상"
                    }
                    else
                    {
                        targets[7] = "미확인"
                    }
                }
                if !statUpdateDatetime.isEqual(nil) {
                    targets[8] = statUpdateDatetime as String
                }
                if !lat.isEqual(nil) {
                    my_lat = lat as String
                }
                if !longi.isEqual(nil) {
                    my_lng = longi as String
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
            let addr = targets[2]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell1", for: indexPath)
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

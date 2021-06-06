//
//  ViewController_2.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/21.
//
import UIKit
import Speech


class ViewController_2: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
 
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet var sidoVoiceStartBtn: UIButton!
    @IBOutlet var sidoVoiceEndBtn: UIButton!
    var sidoVoiceText: String!
    
    @IBOutlet var adrVoiceStartBtn: UIButton!
    @IBOutlet var adrVoiceEndBtn: UIButton!
    var adrVoiceText: String!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
    
    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    
    @IBAction func startTranscribing(_ sender: Any) {
        sidoVoiceStartBtn.isEnabled = false
        sidoVoiceEndBtn.isEnabled = true
        try! startSession()

    }
    @IBAction func stopTranscribing(_ sender: Any) {
            if audioEngine.isRunning {
                audioEngine.stop()
                speechRecognitionRequest?.endAudio()
                sidoVoiceStartBtn.isEnabled = true
                sidoVoiceEndBtn.isEnabled = false
            }
        print(self.sidoVoiceText)
            switch (self.sidoVoiceText) {
            case "서울특별시" : self.pickerView.selectRow(0, inComponent: 0, animated: true)
                zcode = "11"
                break
            case "부산광역시" : self.pickerView.selectRow(1, inComponent: 0, animated: true)
                zcode = "26"
                break
            case "대구광역시" : self.pickerView.selectRow(2, inComponent: 0, animated: true)
                zcode = "27"
                break
            case "인천시" : self.pickerView.selectRow(3, inComponent: 0, animated: true)
                zcode = "28"
                break
            case "광주시" : self.pickerView.selectRow(4, inComponent: 0, animated: true)
                zcode = "29"
                break
            case "대전시" : self.pickerView.selectRow(5, inComponent: 0, animated: true)
                zcode = "30"
                break
            case "울산시" : self.pickerView.selectRow(6, inComponent: 0, animated: true)
                zcode = "31"
                break
            case "경기도" : self.pickerView.selectRow(7, inComponent: 0, animated: true)
                zcode = "41"
                break
            case "강원도" : self.pickerView.selectRow(8, inComponent: 0, animated: true)
                zcode = "42"
                break
            case "충청북도" : self.pickerView.selectRow(9, inComponent: 0, animated: true)
                zcode = "43"
                break
            case "충청남도" : self.pickerView.selectRow(10, inComponent: 0, animated: true)
                zcode = "44"
                break
            case "전라북도" : self.pickerView.selectRow(11, inComponent: 0, animated: true)
                zcode = "45"
                break
            case "전라남도" : self.pickerView.selectRow(12, inComponent: 0, animated: true)
                zcode = "46"
                break
            case "경상북도" : self.pickerView.selectRow(13, inComponent: 0, animated: true)
                zcode = "47"
                break
            case "경상남도" : self.pickerView.selectRow(14, inComponent: 0, animated: true)
                zcode = "48"
                break
            case "제주도" : self.pickerView.selectRow(15, inComponent: 0, animated: true)
                zcode = "50"
                break
                
            default: break
            }
    }
    
    @IBAction func startAdrTranscribing(_ sender: Any) {
        adrVoiceStartBtn.isEnabled = false
        adrVoiceEndBtn.isEnabled = true
        try! startAdrSession()
    }
    
    @IBAction func endAdrTranscribing(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            adrVoiceStartBtn.isEnabled = true
            adrVoiceEndBtn.isEnabled = false
        }
    }
    
    @IBOutlet var textView: UITextField!
    
    var pickerDataSource = ["서울특별시", "부산광역시", "대구광역시", "인천시", "광주시", "대전시", "울산시", "경기도", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주도"]
    
    var url : String = "http://apis.data.go.kr/B552584/EvCharger/getChargerInfo?serviceKey=S8rzdkL5i25h2g%2Bk0QgRu%2B4GJ8ShKEiyJAR1xCDbaOj%2Ffh2BCT04Om0AKgQx4mSH1Cu%2BK3GOIB2GwivyW%2B1FSg%3D%3D&pageNo=1&numOfRows=200&zcode="
    var zcode : String = "11" // 서울시
    
    
    var url_withAddr : String = "http://openapi.kepco.co.kr/service/EvInfoServiceV2/getEvSearchList?serviceKey=S8rzdkL5i25h2g%2Bk0QgRu%2B4GJ8ShKEiyJAR1xCDbaOj%2Ffh2BCT04Om0AKgQx4mSH1Cu%2BK3GOIB2GwivyW%2B1FSg%3D%3D&pageNo=1&numOfRows=100&addr="
    var addr : String = "서울특별시"
    


    @IBAction func doneToPickerViewController(segue: UIStoryboardSegue){
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            zcode = "11" //서울특별시
        } else if row == 1{
            zcode = "26"  //부산광역시
        } else if row == 2 {
            zcode = "27"   //대구시
        } else if row == 3 {
            zcode = "28"   //인천시
        } else if row == 4{
            zcode = "29"  //광주시
        } else if row == 5 {
            zcode = "30"   //대전시
        } else if row == 6 {
            zcode = "31"   //울산시
        } else if row == 7{
            zcode = "41"  //경기도
        } else if row == 8 {
            zcode = "42"   //강원도
        } else if row == 9 {
            zcode = "43"   //충북도
        } else if row == 10{
            zcode = "44"  //충남도
        } else if row == 11 {
            zcode = "45"   //전북도
        } else if row == 12 {
            zcode = "46"   //전남도
        } else if row == 13{
            zcode = "47"  //경북도
        } else if row == 14 {
            zcode = "48"   //경남도
        } else if row == 15 {
            zcode = "50"   //제주도
        } else {
            zcode = "11"   //서울특별시
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTableView" {
            if let navController = segue.destination as? UINavigationController {
                if let chargingStationTableViewController = navController.topViewController as?
                    ChargingStationTableViewController {
                    chargingStationTableViewController.url = url + zcode
                }
            }
        }
        else if segue.identifier == "segueToTableView2" {
            let encode = textView.text!.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            if let navController = segue.destination as? UINavigationController {
                if let chargingStationWithAddrTableViewController = navController.topViewController as?
                    ChargingStationWithAddrTableViewController {
                    chargingStationWithAddrTableViewController.url = url_withAddr + encode!
                }
            }
        }
    }
    
    
    //음성인식
    func startSession() throws {
        if let recognitionTask = speechRecognitionTask {
            speechRecognitionTask?.cancel()
            self.speechRecognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)
        
        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = speechRecognitionRequest else
        { fatalError("SFSpeechAudioBufferRecognitionRequset object creation failed")}
        
        let inputNode = audioEngine.inputNode
        
        recognitionRequest.shouldReportPartialResults = true
        
        speechRecognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            
            var finished = false
            
            if let result = result {
                self.sidoVoiceText =
                    result.bestTranscription.formattedString
                finished = result.isFinal
            }
            
            if error != nil || finished {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                
                self.sidoVoiceStartBtn.isEnabled = true
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.speechRecognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        
    }
    
    func startAdrSession() throws {
        if let recognitionTask = speechRecognitionTask {
            speechRecognitionTask?.cancel()
            self.speechRecognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)
        
        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = speechRecognitionRequest else
        { fatalError("SFSpeechAudioBufferRecognitionRequset object creation failed")}
        
        let inputNode = audioEngine.inputNode
        
        recognitionRequest.shouldReportPartialResults = true
        
        speechRecognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            
            var finished = false
            
            if let result = result {
                self.textView.text =
                    result.bestTranscription.formattedString
                finished = result.isFinal
            }
            
            if error != nil || finished {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                
                self.adrVoiceStartBtn.isEnabled = true
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.speechRecognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        
    }
    
    
    func authorizeSR() {
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.sidoVoiceStartBtn.isEnabled = true
                    
                case .denied:
                    self.sidoVoiceStartBtn.isEnabled = false
                    self.sidoVoiceStartBtn.setTitle("Speech recognition access denied by user", for: .disabled)
                    
                case .restricted:
                    self.sidoVoiceStartBtn.isEnabled = false
                    self.sidoVoiceStartBtn.setTitle("Speech recognition restricted on device", for: .disabled)
                    
                case .notDetermined:
                    self.sidoVoiceStartBtn.isEnabled = false
                    self.sidoVoiceStartBtn.setTitle("Speech recognition not authorized", for: .disabled)

                }
            }
        }
    }
    
    
override func viewDidLoad() {
    super.viewDidLoad()
    authorizeSR()
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}


}

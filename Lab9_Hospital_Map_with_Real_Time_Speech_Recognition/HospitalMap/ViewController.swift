//
//  ViewController.swift
//  HospitalMap
//
//  Created by kpugame on 2021/04/13.
//

import UIKit
import Speech


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var transcribeButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
    
    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    
    @IBAction func startTranscribing(_ sender: Any) {
        transcribeButton.isEnabled = false
        stopButton.isEnabled = true
        try! startSession()
    }
    
    @IBAction func stopTranscribing(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            transcribeButton.isEnabled = true
            stopButton.isEnabled = false
        }
        
        switch (self.myTextView.text) {
        case "광진구" : self.pickerView.selectRow(0, inComponent: 0, animated: true)
            sgguCd = "110023"
            break
        case "구로구" : self.pickerView.selectRow(1, inComponent: 0, animated: true)
            sgguCd = "110005"
            break
        case "동대문구" : self.pickerView.selectRow(2, inComponent: 0, animated: true)
            sgguCd = "110007"
            break
        case "종로구" : self.pickerView.selectRow(3, inComponent: 0, animated: true)
            sgguCd = "110016"
            break
        default: break
        }
    }
    
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
                self.myTextView.text =
                    result.bestTranscription.formattedString
                finished = result.isFinal
            }
            
            if error != nil || finished {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                
                self.transcribeButton.isEnabled = true
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
                    self.transcribeButton.isEnabled = true
                    
                case .denied:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition access denied by user", for: .disabled)
                    
                case .restricted:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition restricted on device", for: .disabled)
                    
                case .notDetermined:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition not authorized", for: .disabled)

                }
            }
        }
    }
    
    @IBAction func doneToPickerViewController(segue: UIStoryboardSegue){
        
    }
    
    var pickerDataSource = ["광진구", "구로구", "동대문구", "종로구"]
    
    //보훈병원정보 OpenAPI 및 인증키

    //디폴트 시도코드 = 서울 (sideCd=110000)

    //ServiceKey = "sea100UMmw23Xycs33F1EQnumONR%2F9ElxBLzkilU9Yr1oT4TrCot8Y2p0jyuJP72x9rG9D8CN5yuEs6AS2sAiw%3D%3D"
    var url : String = "http://apis.data.go.kr/B551182/hospInfoService/getHospBasisList?pageNo=1&numOfRows=10&serviceKey=S8rzdkL5i25h2g%2Bk0QgRu%2B4GJ8ShKEiyJAR1xCDbaOj%2Ffh2BCT04Om0AKgQx4mSH1Cu%2BK3GOIB2GwivyW%2B1FSg%3D%3D&sidoCd=110000&sgguCd="
    var sgguCd : String = "110023" //디폴트 시구코드 = 광진구
    
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
            sgguCd = "110023" //광진구
        } else if row == 1{
            sgguCd = "110005"  //구로구
        } else if row == 2 {
            sgguCd = "110007"   // 동대문구
        } else {
            sgguCd = "110016"   //종로구
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTableView" {
            if let navController = segue.destination as? UINavigationController {
                if let hospitalTableViewController = navController.topViewController as?
                    HospitalTableViewController {
                    hospitalTableViewController.url = url + sgguCd
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        authorizeSR()
    }


}


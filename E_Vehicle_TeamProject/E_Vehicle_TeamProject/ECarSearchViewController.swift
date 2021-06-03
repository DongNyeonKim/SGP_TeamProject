//
//  ECarSearchViewController.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/31.
//

import UIKit
import SwiftSoup
import AVFoundation
import Charts

class ECarSearchViewController: UIViewController {
    
    var sidoArray: [String] = ["서울","인천","경기","강원","충북","세종","충남","대전","전북","전남","광주","경북","대구","경남","울산","부산","제주"]
    var carsArray: [Double] = []
    
    var yearArray: [String] = ["2015", "2016", "2017", "2018", "2019", "2020"]

    let yearCarsArray = [5803.0, 15389.0, 25593.0, 55756.0, 89918.0, 134962.0]
    let yearChargeArray = [1532.0, 2480.0, 3427.0, 15389.0, 33415.0, 66759.0]

    //barChart
    @IBOutlet var barChartView: BarChartView!
    
    //combinedChart
    
    @IBOutlet var combinedChartView: CombinedChartView!
    
    
    //AV
    @IBOutlet var avView: UIView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var volumeSlider: UISlider!
    
    enum Rate: Int {
      case slowForward, normal, fastForward
    }

    let playerLayer = AVPlayerLayer()
    var player: AVPlayer? {
      return playerLayer.player
    }
    var rate: Float {
        return 1.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        crawl()

        //AV
        setUpPlayerLayer()
        avView.layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(ECarSearchViewController.playerDidReachEndNotificationHandler(_:)),
          name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"),
          object: player?.currentItem)
        playButton.setTitle("Pause", for: .normal)
        
        //barchart
        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .systemFont(ofSize: 20)
        barChartView.noDataTextColor = .lightGray
        
        setChart(dataPoints: sidoArray, values: carsArray)
        
        setCombinedChart(dataPoints: yearArray, barValues: yearCarsArray, lineValues: yearChargeArray)
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
            
//            for i in sidoTitles {
//                //print("위치: ", try i.text())
//                sidoArray.append(try i.text())
//            }
            for i in sidoCars {
                //print("가격: ", try i.text())
                print(try i.text())
                let stringtemp = try i.text()
                let changestringtemp = stringtemp.replacingOccurrences(of: ",", with: "")
                let temp = (changestringtemp as NSString).doubleValue

                carsArray.append(temp)
            }
            
//            for i in sidoArray{
//                print(i)
//            }
            
//            for i in carsArray{
//                print(i)
//            }
            
            
        } catch Exception.Error(let type, let message) {
            print("Message: \(message)")
        } catch {
            print("error")
        }
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
            
            // 데이터 생성
            var dataEntries: [BarChartDataEntry] = []
            for i in 0..<dataPoints.count {
                let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
                dataEntries.append(dataEntry)
            }
            
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: "보급대수")
            
            // 차트 컬러
            chartDataSet.colors = [.systemBlue]
            
            // 데이터 삽입
            let chartData = BarChartData(dataSet: chartDataSet)
            barChartView.data = chartData
            
            
            // 선택 안되게
            chartDataSet.highlightEnabled = false
            // 줌 안되게
            barChartView.doubleTapToZoomEnabled = false


            // X축 레이블 위치 조정
            barChartView.xAxis.labelPosition = .bottom
            // X축 레이블 포맷 지정
            barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: sidoArray)

            
            // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
            barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
            
            // 오른쪽 레이블 제거
            barChartView.rightAxis.enabled = false
            
            // 기본 애니메이션
            barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
            // 옵션 애니메이션
            barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 10.0, easingOption: .easeInBounce)


//            // 리미트라인
//            let ll = ChartLimitLine(limit: 10.0, label: "타겟")
//            barChartView.leftAxis.addLimitLine(ll)


//            // 맥시멈
//            barChartView.leftAxis.axisMaximum = 30
//            // 미니멈
//            barChartView.leftAxis.axisMinimum = -10

            
            // 백그라운드컬러
            barChartView.backgroundColor = .white
            
        }
    func setCombinedChart(dataPoints: [String], barValues: [Double], lineValues: [Double]) {
        
        // bar, line 엔트리 생성
        var barDataEntries: [BarChartDataEntry] = []
        var lineDataEntries: [ChartDataEntry] = []
        
        // bar, line 엔트리 삽입
        for i in 0..<dataPoints.count {
            let barDataEntry = BarChartDataEntry(x: Double(i), y: barValues[i])
            let lineDataEntry = ChartDataEntry(x: Double(i), y: lineValues[i])
            barDataEntries.append(barDataEntry)
            lineDataEntries.append(lineDataEntry)
        }

        // 데이터셋 생성
        let barChartDataSet = BarChartDataSet(entries: barDataEntries, label: "자동차 수")
        let lineChartDataSet = LineChartDataSet(entries: lineDataEntries, label: "충전기 수")
 
        // 라인 원 색깔 변경
        lineChartDataSet.colors = [.red ]
        lineChartDataSet.circleColors = [.red ]
        
        
        // 데이터 생성
        let data: CombinedChartData = CombinedChartData()
        
        // bar 데이터 지정
        data.barData = BarChartData(dataSet: barChartDataSet)
        // line 데이터 지정
        data.lineData = LineChartData(dataSet: lineChartDataSet)
        
        // 콤비 데이터 지정
        combinedChartView.data = data
        
        // X축 레이블 포맷 ( index -> 실제데이터 )
        combinedChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: yearArray)


        // 라인 굵기
        lineChartDataSet.lineWidth = 5.0
        
        // 원 구멍 반경
        lineChartDataSet.circleHoleRadius = 5.0

        // 원 반경 (꽉채우려면 홀 반경이랑 똑같게)
        lineChartDataSet.circleRadius = 5.0

        lineChartDataSet.mode = .cubicBezier

        // 기본 애니메이션
        combinedChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        // 옵션 애니메이션
        combinedChartView.animate(xAxisDuration: 2.0, yAxisDuration: 20.0, easingOption: .easeInOutBounce)
        
        
        // 바 컬러
        barChartDataSet.colors = [.systemGreen ]
        // 백그라운드 컬러
        combinedChartView.backgroundColor = .white
        
        // X축 레이블 전체 보이도록 설정 ( 09시, 10시, 11시 ... )
        combinedChartView.xAxis.setLabelCount(yearArray.count, force: true)
        // X축 레이블 위치 조정
        combinedChartView.xAxis.labelPosition = .bottom
        

        
        
//        // 맥시멈
//        combinedChartView.leftAxis.axisMaximum = 25
//        // 미니멈
//        combinedChartView.leftAxis.axisMinimum = -5
        
        
//        // 리미트 라인 생성
//        combinedChartView.leftAxis.addLimitLine(ChartLimitLine(limit: 10, label: "평균"))
        // 우측 레이블 제거
        combinedChartView.rightAxis.enabled = false

        
        // 차트 선택 안되게
        lineChartDataSet.highlightEnabled = false
        barChartDataSet.highlightEnabled = false
        
        // 줌 안되게
        combinedChartView.doubleTapToZoomEnabled = false
    }
    
    @IBAction func touchPlayBut(_ sender: Any) {
        if player?.rate == 0 {
          player?.rate = rate
          updatePlayButtonTitle(isPlaying: true)
        } else {
          player?.pause()
          updatePlayButtonTitle(isPlaying: false)
        }
    }
    
    @IBAction func volumeChange(_ sender: Any) {
        player?.volume = (sender as AnyObject).value
    }


}


extension ECarSearchViewController {
  func setUpPlayerLayer() {
    // 1
    playerLayer.frame = avView.bounds

    // 2
    let url = Bundle.main.url(forResource: "chargeintro", withExtension: "m4v")!
    let item = AVPlayerItem(asset: AVAsset(url: url))
    let player = AVPlayer(playerItem: item)

    // 3
    player.actionAtItemEnd = .none

    // 4
    player.volume = 1.0
    player.rate = 1.0


    playerLayer.player = player

  }
}


// MARK: - Triggered actions
extension ECarSearchViewController {
  @objc func playerDidReachEndNotificationHandler(_ notification: Notification) {
    // 1
    guard let playerItem = notification.object as? AVPlayerItem else { return }

    // 2
    playerItem.seek(to: .zero, completionHandler: nil)
        
    // 3
    if player?.actionAtItemEnd == .pause {
      player?.pause()
      updatePlayButtonTitle(isPlaying: false)
    }

  }
}

// MARK: - Helpers
extension ECarSearchViewController {
  func updatePlayButtonTitle(isPlaying: Bool) {
    if isPlaying {
      playButton.setTitle("정지", for: .normal)
    } else {
      playButton.setTitle("재생", for: .normal)
    }
  }
}


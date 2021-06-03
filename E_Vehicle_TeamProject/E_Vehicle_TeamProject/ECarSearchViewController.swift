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
    
    var sidoArray: [String] = []
    var carsArray: [String] = []

    
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
            
            for i in sidoTitles {
                //print("위치: ", try i.text())
                sidoArray.append(try i.text())
            }
            for i in sidoCars {
                //print("가격: ", try i.text())
                carsArray.append(try i.text())
            }
            
            for i in sidoArray{
                print(i)
            }
            
            for i in carsArray{
                print(i)
            }
            
            
        } catch Exception.Error(let type, let message) {
            print("Message: \(message)")
        } catch {
            print("error")
        }
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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


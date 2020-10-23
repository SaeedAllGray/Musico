//
//  NowPlayingViewController.swift
//  Music
//
//  Created by saeed on 3/22/20.
//  Copyright © 2020 saeed. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class NowPlayingViewController: UIViewController {
    

    @IBOutlet var artworkOutlet: UIImageView!
    
    @IBOutlet var durationSlider: UISlider!
    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var musicLabel: UILabel!
 
    
    @IBOutlet var timePassedLabel: UILabel!
    
    @IBOutlet var timeRemainedLabel: UILabel!
    
    
    @IBOutlet var controllersOutlet: [UIButton]!
    
    @IBOutlet var playPauseButton: UIButton!
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        updateUI()
        
        _ = Timer.scheduledTimer(timeInterval: 0.000001, target: self, selector: #selector(updateDurationSliderValue), userInfo: nil, repeats: true )
        
        volumeSlider.minimumValueImage = UIImage(systemName: "speaker.fill")!
        volumeSlider.maximumValueImage = UIImage(systemName: "speaker.3.fill")!
        
        setupRemoteTransportControls()
        setupNowPlaying()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if  SaveMedia.musicCount() == 0 {
            print("ekekllk")
            for button in controllersOutlet {
                button.isEnabled = false
                musicLabel.text = "Not Playing"
            }
            durationSlider.isEnabled = false
            volumeSlider.isEnabled = false
        } else {
            for button in controllersOutlet {
                button.isEnabled = true
            }
            durationSlider.isEnabled = true
            volumeSlider.isEnabled = false
            
        }
        if Music.audioPlayer.currentTime == Music.audioPlayer.duration && SavePreferences.playNext {
        //            Music.next()
//            print(Music.audioPlayer.duration)
        
            
        }
    }
    
    
    @IBAction func previous(_ sender: Any) {
        Music.previous()
        updateUI()
    }
    @IBAction func play(_ sender: UIButton) {
        
        if Music.audioPlayer.isPlaying {
            Music.pause()
        } else {
            Music.play()
        }
        updateUI()
    }
    
    @IBAction func next(_ sender: Any) {
        Music.next()
        updateUI()
    }
    
    @IBAction func volume(_ sender: UISlider) {
        Music.audioPlayer.volume = sender.value
    }
    
    @IBAction func audioTime(_ sender: AnyObject) {
        Music.audioPlayer.stop()
        Music.audioPlayer.currentTime = TimeInterval (durationSlider.value)
        Music.audioPlayer.prepareToPlay()
        Music.audioPlayer.play()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func updateDurationSliderValue() {
        durationSlider.value = Float(Music.audioPlayer.currentTime)
        updateTimeLabels()
       
        if(Int(Music.audioPlayer.duration) == Int(Music.audioPlayer.currentTime)){
            print(CGFloat(Music.audioPlayer.currentTime))
            print(CGFloat(Music.audioPlayer.duration))
             if SavePreferences.countinuousPlayback{
//                Music.audioPlayer.stop()
                Music.playback()
              Music.audioPlayer.prepareToPlay()
    //            print("dljrfrhfiurhfrhfuyfg")
                Music.audioPlayer.play()
                updateUI()
            } else if SavePreferences.playNext {
                Music.audioPlayer.stop()
                Music.next()
                Music.audioPlayer.prepareToPlay()
                Music.audioPlayer.play()
                updateUI()
            }
        }

    }
    func updateTimeLabels() {
        let duration = Int((Music.audioPlayer.duration - (Music.audioPlayer.currentTime)))
        let minutes2 = duration/60
        let seconds2 = duration - minutes2 * 60
        timeRemainedLabel.text = NSString(format: "%02d:%02d", minutes2,seconds2) as String

        //This is to show and compute current time
        let currentTime1 = Int((Music.audioPlayer.currentTime))
        let minutes = currentTime1/60
        let seconds = currentTime1 - minutes * 60
        timePassedLabel.text = NSString(format: "%02d:%02d", minutes,seconds) as String
    }
    
    func updateUI(){
        if  SaveMedia.musicCount() == 0 {
            print("ekekllk")
            for button in controllersOutlet {
                button.isEnabled = false
                musicLabel.text = "Not Playing"
            }
            durationSlider.isEnabled = false
            volumeSlider.isEnabled = false
        } else {
            durationSlider.maximumValue = Float(Music.audioPlayer.duration)
            updateTimeLabels()
            if let now = Music.currentName(){
                musicLabel.text = now
            }
            if !Music.audioPlayer.isPlaying {
                playPauseButton.setImage(UIImage(systemName: "play.fill")!, for: .normal)
                UIView.animate(withDuration: 0.5) {
                self.artworkOutlet.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }
            } else {
               Music.play()
               playPauseButton.setImage(UIImage(systemName: "pause.fill")!, for: .normal)
               UIView.animate(withDuration: 0.5, animations: {
                self.artworkOutlet.transform = CGAffineTransform.identity
                })
           }
        }
    }
     
    
}


extension UIViewController {
    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()

        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
//            if Music.audioPlayer.rate == 0.0 {
                Music.audioPlayer.play()
                return .success
//            }
//            return .commandFailed
        }

        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
//            if Music.audioPlayer.rate == 1.0 {
                Music.audioPlayer.pause()
                return .success
//            }
//            return .commandFailed
        }
        
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
            Music.next()
            return .success
        }
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
            Music.previous()
            return .success
        }
    }
    
    func setupNowPlaying() {
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        
        if let now = Music.currentName(){
            nowPlayingInfo[MPMediaItemPropertyTitle] = now
        }
         

        if let image = UIImage(named: "lockscreen") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] =
                MPMediaItemArtwork(boundsSize: image.size) { size in
                    return image
            }
        }
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = Music.audioPlayer.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = Music.audioPlayer.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = Music.audioPlayer.rate

        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
}

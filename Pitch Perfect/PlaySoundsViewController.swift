//

//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Marcel Salathé on 5/8/15.
//  Copyright (c) 2015 Marcel Salathé. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL:receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  func playSoundWithVariableSpeed(myRate: float_t) {
    stopAndResetPlayerAndEngine()
    audioPlayer.rate = myRate
    audioPlayer.currentTime = 0.0
    audioPlayer.play()
  }
  
  func stopAndResetPlayerAndEngine() {
    audioPlayer.stop()
    audioEngine.stop()
    audioEngine.reset()
  }
  
  @IBAction func playSlowSound(sender: UIButton) {
    playSoundWithVariableSpeed(0.5)
  }
    
  @IBAction func playFastSound(sender: UIButton) {
    playSoundWithVariableSpeed(1.5)
  }
  
  @IBAction func stopPlaying(sender: UIButton) {
    stopAndResetPlayerAndEngine()
  }
  
  @IBAction func playChipmunkSound(sender: UIButton) {
    playAudioWithVariablePitch(1000)
  }
  
  @IBAction func playDarthVaderSound(sender: UIButton) {
    playAudioWithVariablePitch(-1000)
  }
  
  func playAudioWithVariablePitch(pitch: Float){
    stopAndResetPlayerAndEngine()
    
    var audioPlayerNode = AVAudioPlayerNode()
    audioEngine.attachNode(audioPlayerNode)
    
    var changePitchEffect = AVAudioUnitTimePitch()
    changePitchEffect.pitch = pitch
    audioEngine.attachNode(changePitchEffect)
    
    audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
    audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
    
    audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
    audioEngine.startAndReturnError(nil)
    
    audioPlayerNode.play()
  }
  
  
}

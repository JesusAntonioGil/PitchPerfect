//
//  PlayManager.swift
//  Pitch Perfect
//
//  Created by Jesus Antonio Gil on 31/1/16.
//  Copyright © 2016 Jesus Antonio Gil. All rights reserved.
//

import UIKit
import AVFoundation


enum PlayType: Int
{
    case Slow = 0
    case Fast
    case Chipmunk
    case Vader
}


protocol PlayManagerDelegate
{
    func playManagerAudioFinish()
}


class PlayManager: NSObject, AVAudioPlayerDelegate {
    
    var delegate: PlayManagerDelegate!
    
    private var playType: PlayType
    private var audioPlayer = AVAudioPlayer()
    private var audioEngine = AVAudioEngine()
    private var pitchPlayer = AVAudioPlayerNode()
    private var audioPlayerState: Bool = false
    private var audioEngineState: Bool = false
    
    
    override init()
    {
        playType = .Slow
    }
    
    //MARK: PUBLIC
    
    func playAudioWithURL(url: NSURL, type: PlayType)
    {
        stopAudio()
        playType = type
        
        switch (type)
        {
            case .Slow:
                playSound(url, rate: 0.5)
            case .Fast:
                playSound(url, rate: 2.0)
            case .Chipmunk:
                audioEngine(url, pitch: 1000.0)
            case .Vader:
                audioEngine(url, pitch: -1000.0)
        }
    }
    
    func stopAudio()
    {
        switch (playType)
        {
            case .Slow, .Fast:
                if(audioPlayerState == true) {
                    audioPlayer.stop()
                    audioEngineState = false
                }
            case .Chipmunk, .Vader:
                if(audioEngineState == true) {
                    audioEngine.stop()
                    pitchPlayer.stop()
                    audioEngineState = false
                }
        }
        
        delegate.playManagerAudioFinish()
    }
    
    //MARK: PRIVATE
    
    private func playSound(url: NSURL, rate: Float)
    {
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
            audioPlayer.delegate = self
            audioPlayer.enableRate = true
            audioPlayer.rate = rate
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            audioPlayerState = true
        }
        catch
        {
            print("PLAY AUDIO ERROR")
        }

    }
    
    private func audioEngine(url: NSURL, pitch: Float)
    {
        let timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        
        audioEngine = AVAudioEngine()
        pitchPlayer = AVAudioPlayerNode()
        
        audioEngine.attachNode(pitchPlayer)
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(pitchPlayer, to: timePitch, format: .None)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: .None)
        
        do
        {
            try pitchPlayer.scheduleFile(AVAudioFile(forReading: url), atTime: nil, completionHandler: nil)
            try audioEngine.start()
            pitchPlayer.play()
            audioEngineState = true
        }
        catch
        {
            print("PLAY AUDIO ERROR")
        }
    }
    
    
    //MARK: PROTOCOLS & DELEGATES
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool)
    {
        audioPlayerState = false
        delegate.playManagerAudioFinish()
    }

}

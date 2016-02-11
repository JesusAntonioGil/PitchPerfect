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
        self.playType = .Slow
    }
    
    //MARK: PUBLIC
    
    func playAudioWithURL(url: NSURL, type: PlayType)
    {
        self.stopAudio()
        self.playType = type
        
        switch (type)
        {
            case .Slow:
                self.playSound(url, rate: 0.5)
            case .Fast:
                self.playSound(url, rate: 2.0)
            case .Chipmunk:
                self.audioEngine(url, pitch: 1000.0)
            case .Vader:
                self.audioEngine(url, pitch: -1000.0)
        }
    }
    
    func stopAudio()
    {
        switch (self.playType)
        {
            case .Slow, .Fast:
                if(self.audioPlayerState == true) {
                    self.audioPlayer.stop()
                    self.audioEngineState = false
                }
            case .Chipmunk, .Vader:
                if(self.audioEngineState == true) {
                    self.audioEngine.stop()
                    self.pitchPlayer.stop()
                    self.audioEngineState = false
                }
        }
        
        self.delegate.playManagerAudioFinish()
    }
    
    //MARK: PRIVATE
    
    private func playSound(url: NSURL, rate: Float)
    {
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.audioPlayer = try AVAudioPlayer(contentsOfURL: url)
            self.audioPlayer.delegate = self
            self.audioPlayer.enableRate = true
            self.audioPlayer.rate = rate
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
            self.audioPlayerState = true
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
        
        self.audioEngine = AVAudioEngine()
        self.pitchPlayer = AVAudioPlayerNode()
        
        self.audioEngine.attachNode(self.pitchPlayer)
        self.audioEngine.attachNode(timePitch)
        
        self.audioEngine.connect(self.pitchPlayer, to: timePitch, format: .None)
        self.audioEngine.connect(timePitch, to: self.audioEngine.outputNode, format: .None)
        
        do
        {
            try self.pitchPlayer.scheduleFile(AVAudioFile(forReading: url), atTime: nil, completionHandler: nil)
            try self.audioEngine.start()
            self.pitchPlayer.play()
            self.audioEngineState = true
        }
        catch
        {
            print("PLAY AUDIO ERROR")
        }
    }
    
    
    //MARK: PROTOCOLS & DELEGATES
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool)
    {
        self.audioPlayerState = false
        self.delegate.playManagerAudioFinish()
    }

}

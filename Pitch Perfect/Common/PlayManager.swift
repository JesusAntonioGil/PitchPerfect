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


class PlayManager: NSObject {
    
    private var audioPlayer = AVAudioPlayer()
    
    
    //MARK: PUBLIC
    
    func playAudioWithURL(url: NSURL, type: PlayType)
    {
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try self.audioPlayer = AVAudioPlayer(contentsOfURL: url)
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
        }
        catch
        {
            print("PLAY AUDIO ERROR")
        }
        
    }

}

//
//  PlayPresenter.swift
//  Pitch Perfect
//
//  Created by Jesus Antonio Gil on 24/1/16.
//  Copyright © 2016 Jesus Antonio Gil. All rights reserved.
//

import UIKit


@objc protocol PlayPresenterDelegate
{
    func presenterAudioFinish()
}


class PlayPresenter: NSObject, PlayManagerDelegate {

    //Injected
    var delegate: PlayPresenterDelegate!
    var playManager: PlayManager!
    
    
    //MARK: PUBLIC
    
    func playAudio(url: NSURL, type: PlayType)
    {
        self.playManager.delegate = self
        self.playManager.playAudioWithURL(url, type: type)
    }
    
    func stopAudio()
    {
        self.playManager.stopAudio()
    }
    
    //MARK: PROTOCOLS & DELEGATES
    
    func playManagerAudioFinish()
    {
        self.delegate.presenterAudioFinish()
    }
}

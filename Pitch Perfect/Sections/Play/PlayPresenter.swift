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
    
}


class PlayPresenter: NSObject {

    //Injected
    var viewController: PlayPresenterDelegate!
    var playManager: PlayManager!
    
    
    //MARK: PUBLIC
    
    func playAudio(url: NSURL, type: PlayType)
    {
        self.playManager.playAudioWithURL(url, type: type)
    }
}

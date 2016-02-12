//
//  RecordPresenter.swift
//  Pitch Perfect
//
//  Created by Jesus Antonio Gil on 24/1/16.
//  Copyright © 2016 Jesus Antonio Gil. All rights reserved.
//

import UIKit


@objc protocol RecordPresenterDelegate
{
    func recordPresenterDidFinishRecording(success: Bool, recorderAudio: RecorderAudio!)
}


class RecordPresenter: NSObject, RecordManagerDelegate {

    //Injected
    var delegate: RecordPresenterDelegate!
    var recordManager: RecordManager!
    var controllerAssembly: ControllerAssembly!
    
    
    //MARK: PUBLIC
    
    func recordSound()
    {
        recordManager.delegate = self
        recordManager.recordAudio()
    }
    
    func stopSound()
    {
        recordManager.stopAudio()
    }
    
    //MARK: PROTOCOLS & DELEGATES
    //MARK: RecordManager Delegate
    
    func recordManagerDidFinishRecording(success: Bool, recorderAudio: RecorderAudio!)
    {
        delegate.recordPresenterDidFinishRecording(success, recorderAudio: recorderAudio)
    }
}

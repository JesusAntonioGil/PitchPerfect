//
//  RecordManager.swift
//  Pitch Perfect
//
//  Created by Jesus Antonio Gil on 24/1/16.
//  Copyright © 2016 Jesus Antonio Gil. All rights reserved.
//

import UIKit
import AVFoundation


class RecordManager: NSObject {
    
    var audioRecorder: AVAudioRecorder!
    var audioSession = AVAudioSession.sharedInstance()
 
    
    //MARK: PUBLIC
    
    func recordAudio()
    {
        do
        {
            try self.audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            self.audioRecorder = try AVAudioRecorder(URL: self.getURLFilePathAudioRecord(), settings: [:])
        }
        catch
        {
            print("AVAudioSession set category error.")
        }
        
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.prepareToRecord()
        self.audioRecorder.record()
    }
    
    func stopAudio()
    {
        self.audioRecorder.stop()
        do
        {
            try self.audioSession.setActive(false)
        }
        catch
        {
            print("AVAudioSession set activer error.")
        }
    }
    
    //MARK: PRIVATE
    
    private func getURLFilePathAudioRecord() -> NSURL
    {
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFromString("ddMMyyyy-HHmmss")
        let recordingName = formatter.stringFromDate(currentDateTime) + ".wav"
        let pathArray = [dirPath, recordingName]
        return NSURL.fileURLWithPathComponents(pathArray)!
    }
}

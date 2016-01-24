//
//  RecordManager.swift
//  Pitch Perfect
//
//  Created by Jesus Antonio Gil on 24/1/16.
//  Copyright © 2016 Jesus Antonio Gil. All rights reserved.
//

import UIKit
import AVFoundation


protocol RecordManagerDelegate
{
    func recordManagerDidFinishRecording(success: Bool, recorderAudio: RecorderAudio!)
}


class RecordManager: NSObject, AVAudioRecorderDelegate {
    
    var delegate: RecordManagerDelegate!
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
        
        self.audioRecorder.delegate = self
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
        let pathArray = [dirPath, "my_audio.wav"]
        return NSURL.fileURLWithPathComponents(pathArray)!
    }
    
    //MARK: PROTOCOLS & DELEGATES
    //MARK: AVAudioRecorder Delegate
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool)
    {
        self.delegate.recordManagerDidFinishRecording(flag, recorderAudio: RecorderAudio(filePathURL: self.audioRecorder.url, title: self.audioRecorder.url.lastPathComponent))
    }
}

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
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            audioRecorder = try AVAudioRecorder(URL: getURLFilePathAudioRecord(), settings: [:])
        }
        catch
        {
            print("AVAudioSession set category error.")
        }
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func stopAudio()
    {
        audioRecorder.stop()
        do
        {
            try audioSession.setActive(false)
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
        delegate.recordManagerDidFinishRecording(flag, recorderAudio: RecorderAudio(filePathURL: audioRecorder.url, title: audioRecorder.url.lastPathComponent))
    }
}

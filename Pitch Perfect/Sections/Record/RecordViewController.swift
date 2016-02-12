//
//  RecordViewController.swift
//  Pitch Perfect
//
//  Created by Jesus Antonio Gil on 24/1/16.
//  Copyright © 2016 Jesus Antonio Gil. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController, RecordPresenterDelegate {

    @IBOutlet weak var recordStateLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    //Injected
    var controllerAssembly: ControllerAssembly!
    
    private var presenter: RecordPresenter!
    private var recorderAudio: RecorderAudio!
    
    
    //MARK: LIVE CYCLE
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        presenter = controllerAssembly.recordPresenter(self) as! RecordPresenter
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "playSegue")
        {
            let playViewController: PlayViewController = segue.destinationViewController as! PlayViewController
            playViewController.recorderAudio = recorderAudio
        }
    }

    //MARK: ACTIONS
    
    @IBAction func onRecordButtonTap(sender: AnyObject)
    {
        recordButton.enabled = false
        stopButton.hidden = false
        recordStateLabel.text = "Recording!"
        
        presenter.recordSound()
    }
    
    @IBAction func onStopButtonTap(sender: AnyObject)
    {
        presenter.stopSound()
    }
    
    //MARK: PRIVATE
    
    private func pushToPlayViewController(recorderAudio: RecorderAudio)
    {
        self.recorderAudio = recorderAudio
        performSegueWithIdentifier("playSegue", sender: self)
    }

    //MARK: PROTOCOLS & DELEGATES
    //MARK: RecordPresenter Delegate
    
    func recordPresenterDidFinishRecording(success: Bool, recorderAudio: RecorderAudio!)
    {
        if(success)
        {
            recordButton.enabled = true
            stopButton.hidden = true
            recordStateLabel.text = "Record!"
            
            pushToPlayViewController(recorderAudio)
        }
    }
}

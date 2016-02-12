//
//  PlayViewController.swift
//  Pitch Perfect
//
//  Created by Jesus Antonio Gil on 24/1/16.
//  Copyright © 2016 Jesus Antonio Gil. All rights reserved.
//

import UIKit


class PlayViewController: UIViewController, PlayPresenterDelegate {

    @IBOutlet weak var stopButton: UIButton!
    
    var recorderAudio: RecorderAudio!
    private var controllerAssembly = ControllerAssembly()
    private var presenter: PlayPresenter!
    
    
    //MARK: LIVE CYCLE
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        presenter = controllerAssembly.playPresenter(self) as! PlayPresenter
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        presenter.stopAudio()
        
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: ACTIONS
    
    @IBAction func onPlayButtonTap(sender: AnyObject)
    {
        presenter.playAudio(self.recorderAudio.filePathURL, type: PlayType(rawValue: sender.tag)!)
        stopButton.hidden = false
    }
    
    @IBAction func onStopButtonTap(sender: AnyObject)
    {
        presenter.stopAudio()
        stopButton.hidden = true
    }
    
    
    //MARK: PROTOCOLS & DELEGATES
    
    func presenterAudioFinish()
    {
        stopButton.hidden = true
    }
}

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
    
    //Injected
    var controllerAssembly: ControllerAssembly!
    var recorderAudio: RecorderAudio!
    
    private var presenter: PlayPresenter!
    
    
    //MARK: LIVE CYCLE
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.presenter = self.controllerAssembly.playPresenter(self) as! PlayPresenter
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        self.presenter.stopAudio()
        
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: ACTIONS
    
    @IBAction func onPlayButtonTap(sender: AnyObject)
    {
        self.presenter.playAudio(self.recorderAudio.filePathURL, type: PlayType(rawValue: sender.tag)!)
        self.stopButton.hidden = false
    }
    
    @IBAction func onStopButtonTap(sender: AnyObject)
    {
        self.presenter.stopAudio()
        self.stopButton.hidden = true
    }
    
    
    //MARK: PROTOCOLS & DELEGATES
    
    func presenterAudioFinish()
    {
        self.stopButton.hidden = true
    }
}

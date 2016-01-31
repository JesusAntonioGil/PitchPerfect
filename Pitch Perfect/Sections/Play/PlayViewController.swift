//
//  PlayViewController.swift
//  Pitch Perfect
//
//  Created by Jesus Antonio Gil on 24/1/16.
//  Copyright © 2016 Jesus Antonio Gil. All rights reserved.
//

import UIKit


class PlayViewController: UIViewController, PlayPresenterDelegate {

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

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: ACTIONS
    
    @IBAction func onPlayButtonTap(sender: AnyObject)
    {
        self.presenter.playAudio(self.recorderAudio.filePathURL, type: PlayType(rawValue: sender.tag)!)
    }

}

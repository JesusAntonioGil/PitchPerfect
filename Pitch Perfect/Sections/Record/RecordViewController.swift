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
    
    
    //MARK: LIVE CYCLE
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.presenter = self.controllerAssembly.recordPresenter(self) as! RecordPresenter
        self.presenter.viewIsReady()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    //MARK: ACTIONS
    
    @IBAction func onRecordButtonTap(sender: AnyObject)
    {
        self.stopButton.hidden = false
        
        self.presenter.recordSound()
    }
    
    @IBAction func onStopButtonTap(sender: AnyObject)
    {
        self.presenter.stopSound()
    }
    
    //MARK: PRIVATE
    
    private func pushToPlayViewController(recorderAudio: RecorderAudio)
    {
        let playViewController: PlayViewController = self.controllerAssembly.playViewController(recorderAudio) as! PlayViewController
        self.navigationController?.pushViewController(playViewController, animated: true)
    }

    //MARK: PROTOCOLS & DELEGATES
    //MARK: RecordPresenter Delegate
    
    func recordPresenterDidFinishRecording(success: Bool, recorderAudio: RecorderAudio!)
    {
        if(success)
        {
            self.pushToPlayViewController(recorderAudio)
        }
    }
}

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
        
    }
    
    @IBAction func onStopButtonTap(sender: AnyObject)
    {
        
    }

}

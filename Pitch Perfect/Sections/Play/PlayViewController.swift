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
    
    private var presenter: PlayPresenter!
    
    
    //MARK: LIVE CYCLE
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.presenter = self.controllerAssembly.playPresenter(self) as! PlayPresenter
        self.presenter.viewIsReady()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    


}

//
//  PlayPresenter.swift
//  Pitch Perfect
//
//  Created by Jesus Antonio Gil on 24/1/16.
//  Copyright © 2016 Jesus Antonio Gil. All rights reserved.
//

import UIKit


@objc protocol PlayPresenterDelegate
{
    
}


class PlayPresenter: NSObject {

    //Injected
    var viewController: PlayPresenterDelegate!
    
    
    //MARK: PUBLIC
    
    func viewIsReady()
    {
        
    }
}

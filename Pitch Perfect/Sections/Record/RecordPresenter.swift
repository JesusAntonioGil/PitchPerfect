//
//  RecordPresenter.swift
//  Pitch Perfect
//
//  Created by Jesus Antonio Gil on 24/1/16.
//  Copyright © 2016 Jesus Antonio Gil. All rights reserved.
//

import UIKit


@objc protocol RecordPresenterDelegate
{
    
}


class RecordPresenter: NSObject {

    //Injected
    var viewController: RecordViewController!
    var recordManager: RecordManager!
    
    
    //MARK: PUBLIC
    
    func viewIsReady()
    {
        
    }
    
    
}

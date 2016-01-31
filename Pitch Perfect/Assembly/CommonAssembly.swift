//
//  CommonAssembly.swift
//  Pitch Perfect
//
//  Created by Jesus Antonio Gil on 24/1/16.
//  Copyright © 2016 Jesus Antonio Gil. All rights reserved.
//

import UIKit
import Typhoon


class CommonAssembly: TyphoonAssembly {

    //MARK: PUBLIC
    
    internal dynamic func recordManager() -> AnyObject
    {
        return TyphoonDefinition.withClass(RecordManager.self)
        {
            (definition) in
                definition.scope = .Singleton
        }
    }
    
    internal dynamic func playManager() -> AnyObject
    {
        return TyphoonDefinition.withClass(PlayManager.self)
        {
            (definition) in
                definition.scope = .Singleton
        }
    }
    
}

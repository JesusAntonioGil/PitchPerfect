//
//  ControllerAssembly.swift
//  Pitch Perfect
//
//  Created by Jesus Antonio Gil on 24/1/16.
//  Copyright © 2016 Jesus Antonio Gil. All rights reserved.
//

import UIKit
import Typhoon


//Constants
let instantiateControllerSelector: Selector = "instantiateViewControllerWithIdentifier:"


class ControllerAssembly: TyphoonAssembly {
    
    //Injected
    var commonAssembly: CommonAssembly!
    
    
    //MARK: PUBLIC
    //MARK: RecordViewController
    
    internal dynamic func recordViewController() -> AnyObject
    {
        return TyphoonDefinition.withClass(RecordViewController.self)
        {
            (definition) in
                definition.injectProperty("controllerAssembly", with: self)
                definition.scope = .Singleton
        }
    }
    
    internal dynamic func recordPresenter(delegate: RecordPresenterDelegate) -> AnyObject
    {
        let definitionBlock: TyphoonDefinitionBlock = { (definition: TyphoonDefinition!) in
            definition.injectProperty("delegate", with: delegate)
            definition.injectProperty("recordManager", with: self.commonAssembly.recordManager())
            definition.injectProperty("controllerAssembly", with: self)
        }
        
        return TyphoonDefinition.withClass(RecordPresenter.self, configuration: definitionBlock)
    }
    
    //MARK: PlayViewController
    
    internal dynamic func playViewController(recorderAudio: RecorderAudio) -> AnyObject
    {
        return TyphoonDefinition.withFactory(self.storyboard(), selector: instantiateControllerSelector, parameters: { (typhoonMethod) -> Void in
                typhoonMethod.injectParameterWith("PlayViewController")
            }, configuration: { (definition) -> Void in
                definition.injectProperty("controllerAssembly", with: self)
                definition.injectProperty("recorderAudio", with: recorderAudio)
        })
    }
    
    internal dynamic func playPresenter(delegate: PlayPresenterDelegate) -> AnyObject
    {
        let definitionBlock: TyphoonDefinitionBlock = { (definition: TyphoonDefinition!) in
            definition.injectProperty("delegate", with: delegate)
            definition.injectProperty("playManager", with: self.commonAssembly.playManager())
        }
        
        return TyphoonDefinition.withClass(PlayPresenter.self, configuration: definitionBlock)
    }
    
    
    //MARK: PRIVATE
    //MARK: Storyboard
    
    internal dynamic func storyboard() -> AnyObject
    {
        return TyphoonDefinition.withClass(TyphoonStoryboard.self)
            {
                (definition) in
                definition.useInitializer("storyboardWithName:factory:bundle:")
                {
                    (initializer) in
                        initializer.injectParameterWith("Main")
                        initializer.injectParameterWith(self)
                        initializer.injectParameterWith(NSBundle.mainBundle())
                }
        }
    }
    
}

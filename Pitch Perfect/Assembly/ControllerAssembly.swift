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
    
    internal dynamic func recordViewController() -> AnyObject
    {
        return TyphoonDefinition.withClass(RecordViewController.self)
        {
            (definition) in
                definition.injectProperty("controllerAssembly", with: self)
                definition.scope = .Singleton
        }
    }
    
    internal dynamic func recordPresenter(viewController: RecordPresenterDelegate) -> AnyObject
    {
        let definitionBlock: TyphoonDefinitionBlock = { (definition: TyphoonDefinition!) in
            definition.injectProperty("viewController", with: viewController)
            definition.injectProperty("recordManager", with: self.commonAssembly.recordManager())
        }
        
        return TyphoonDefinition.withClass(RecordPresenter.self, configuration: definitionBlock)
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

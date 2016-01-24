//
//  RecorderAudio.swift
//  Pitch Perfect
//
//  Created by Jesus Antonio Gil on 24/1/16.
//  Copyright © 2016 Jesus Antonio Gil. All rights reserved.
//

import UIKit


class RecorderAudio: NSObject {
    
    var filePathURL: NSURL!
    var title: String!

    
    init(filePathURL: NSURL!, title: String!)
    {
        self.filePathURL = filePathURL
        self.title = title
    }
}

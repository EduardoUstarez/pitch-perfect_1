//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Carlos Eduardo Angulo Ustarez on 4/11/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    init(vurl: NSURL!,vtitle:String!) {
       filePathUrl = vurl
       title = vtitle
        
    }
    var filePathUrl: NSURL!
    var title: String!
}
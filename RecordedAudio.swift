//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Marcel Salathé on 5/9/15.
//  Copyright (c) 2015 Marcel Salathé. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
  var filePathUrl: NSURL!
  var title: String!
  
  init(filePathUrl: NSURL, title: String) {
    self.filePathUrl = filePathUrl
    self.title = title
  }
}

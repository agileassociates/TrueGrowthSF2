//
//  Post.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 1/8/19.
//  Copyright © 2019 Agile Associates. All rights reserved.
//

import Foundation
class Post {
    var caption: String
    var photoUrl: String
    
    init(captionString: String, photoUrlString: String) {
        caption = captionString
        photoUrl = photoUrlString
    }
}

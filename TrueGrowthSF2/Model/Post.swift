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
    var email: String
    
    init(captionString: String, photoUrlString: String, emailString: String) {
        caption = captionString
        photoUrl = photoUrlString
        email = emailString
    }
}

//
//  Like.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 5/17/19.
//  Copyright © 2019 Agile Associates. All rights reserved.
//

import Foundation
import Firebase

class Like : ReflectedStringConvertible{
    var photoUrl: String
    var uid: String
    var uuid: String
    
    init(photoId: String, userId: String, userUid: String) {
        photoUrl = photoId
        uid = userId
        uuid = userUid
        
    }
    
}

//
//  Profile.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 6/6/20.
//  Copyright © 2020 Agile Associates. All rights reserved.
//

import Foundation
import Firebase

class Profile : ReflectedStringConvertible{
    var email: String
    var photoUrl: String
    
    init(emailName: String, photoName: String) {
        email = emailName
        photoUrl = photoName
        
    }
    
}

//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Sy Lee on 2023/03/29.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import Foundation

struct Constants {
    static let appName = "⚡️FlashChat"
    static let cellId = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    static let registerSeagueId = "GoToRegisterView"
    static let loginSeagueId = "GoToLoginView"
    static let registerToChatSeagueId = "GoToChatViewOne"
    static let loginToChatSeagueId = "GoToChatViewTwo"
    
    
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
}

/*
 struct K {
     static let cellIdentifier = "ReusableCell"
     static let cellNibName = "MessageCell"
     static let registerSegue = "RegisterToChat"
     static let loginSegue = "LoginToChat"
     
     struct BrandColors {
         static let purple = "BrandPurple"
         static let lightPurple = "BrandLightPurple"
         static let blue = "BrandBlue"
         static let lighBlue = "BrandLightBlue"
     }
     
     struct FStore {
         static let collectionName = "messages"
         static let senderField = "sender"
         static let bodyField = "body"
         static let dateField = "date"
     }
 }

 */

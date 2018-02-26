//
//  Post.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class Post {
    let postID: String
    let userID: String
    let caption: String
    let postImageStr: String?
    
    init(dict: [String : Any]) {
        self.postID = dict["postID"] as? String ?? ""
        self.userID = dict["userID"] as? String ?? ""
        self.caption = dict["caption"] as? String ?? ""
        self.postImageStr = dict["postImageStr"] as? String ?? ""
     
    }
}


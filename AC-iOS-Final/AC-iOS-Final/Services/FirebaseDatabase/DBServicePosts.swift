//
//  DBServicePosts.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension DBService {
    
    public func addPosts(caption: String, postImageStr: String, image: UIImage) {
        let childByAutoId = DBService.manager.getPosts().childByAutoId()
        childByAutoId.setValue(["postID"        : childByAutoId.key,
                                "userID"        : AuthUserService.getCurrentUser()!.uid,
                                "caption"       : caption,
                                "date"          : formatDate(with: Date()),
                                "postImageStr"  : postImageStr]) { (error, dbRef) in
                                    if let error = error {
                                        print("addPosts error: \(error)")
                                    } else {
                                        print("posts added @ database reference: \(dbRef)")
                                        // add an image to storage
                                        StorageService.manager.storePostImage(image: image, postId: childByAutoId.key)
                                        // TODO: add image to database
                                    }
        }
    }
    
    public func loadAllPosts(completionHandler: @escaping ([Post]?) -> Void) {
        let ref = DBService.manager.getPosts()
        ref.observe(.value) { (snapshot) in
            var allPosts = [Post]()
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String: Any] {
                    let post = Post.init(dict: dict)
                    allPosts.append(post)
                }
            }
            completionHandler(allPosts)
        }
    }
    
    public func loadUserPosts(userID: String, completionHandler: @escaping ([Post]?) -> Void) {
        let ref = DBService.manager.getPosts()
        ref.observe(.value) { (snapshot) in
            var userPosts = [Post]()
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String: Any] {
                    let post = Post.init(dict: dict)
                    if userID == post.userID {
                        userPosts.append(post)
                    }
                }
            }
            completionHandler(userPosts)
        }
    }

}


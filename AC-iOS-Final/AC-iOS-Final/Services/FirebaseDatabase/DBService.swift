//
//  DBService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBService {
    
    //MARK: Properties
    private var dbRef: DatabaseReference!
    private var postsRef: DatabaseReference!
    private var imagesRef: DatabaseReference!
    
    
    private init(){
        // reference to the root of the Firebase database
        dbRef = Database.database().reference()
        
        // children of root database node
        postsRef = dbRef.child("posts")
        imagesRef = dbRef.child("images")
    }
    static let manager = DBService()
    
    func formatDate(with date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY h:mm a"
        return dateFormatter.string(from: date)
    }
    
    public func getDB()-> DatabaseReference { return dbRef }
    public func getPosts()-> DatabaseReference { return postsRef }
    public func getImages()-> DatabaseReference { return imagesRef }
}

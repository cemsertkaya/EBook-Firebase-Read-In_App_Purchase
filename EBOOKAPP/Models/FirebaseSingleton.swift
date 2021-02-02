//
//  FirebaseSingleton.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 2.02.2021.
//

import Foundation
import Firebase

class singleton
{
    
    private static var  uniqueInstance:singleton? = nil
    private var db = Firestore.firestore()
    private var usersDatabase:CollectionReference?
    
    private init()
    {
        self.db = Firestore.firestore()
        self.usersDatabase = self.db.collection("Users")
    }
    
    public static func instance() -> singleton
    {
        if uniqueInstance == nil
        {
            uniqueInstance = singleton()
        }
        return uniqueInstance!
    }
    
    func getDb() -> Firestore
    {
        return singleton.uniqueInstance!.db
    }
    
    func getUsersDatabase() -> CollectionReference
    {
        return singleton.uniqueInstance!.usersDatabase!
    }
    
    
    
    
    
}

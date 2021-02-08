//
//  CoreDataUtil.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 2.02.2021.
//

import Foundation
import CoreData
import UIKit

class CoreDataUtil
{
    
    
    
    ///Creates IsActiveEntity with isActive bool when registering operation
    static func createEntityCoreData(isActive: Bool)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context =  appDelegate.persistentContainer.viewContext
        let newEntity = NSEntityDescription.insertNewObject(forEntityName:"IsActiveElement", into: context)
        newEntity.setValue(isActive, forKey: "isActive")
        do{try context.save()}
        catch{print("error")}
    }
    
    ///Creates user object for keeping user's data
    static func createUserCoreData(user: CurrentUser)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        newUser.setValue(user.getUserId(), forKey: "userId")
        newUser.setValue(user.getLanguage(), forKey: "language")
        newUser.setValue(user.getGender(), forKey: "gender")
        newUser.setValue(user.getEmail(), forKey: "email")
        newUser.setValue(user.getCountry(), forKey: "country")
        newUser.setValue(user.getAge(), forKey: "age")
        do{
            try context.save()
            print("saved")
            
        }
        catch{print("error")}
    }
    
    
    static func getCurrentUser() -> CurrentUser
    {
        var currentUser = CurrentUser()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(fetchRequest)
            if results.count > 0
            {
                
                for result in results as! [NSManagedObject]
                {
                    if let userId = result.value(forKey: "userId") as? String
                    {
                        currentUser.setUserId(userId: userId)
                    }
                    if let language = result.value(forKey: "language") as? String
                    {
                        currentUser.setLanguage(language: language)
                    }
                    if let gender = result.value(forKey: "gender") as? String
                    {
                        currentUser.setGender(gender: gender)
                    }
                    if let email = result.value(forKey: "email") as? String
                    {
                        currentUser.setEmail(email: email)
                    }
                    if let country = result.value(forKey: "country") as? String
                    {
                        currentUser.setCountry(country: country)
                    }
                    if let age = result.value(forKey: "age") as? String
                    {
                        currentUser.setAge(age: age)
                    }
                }
            }
        }
        catch
        {
            print("There is a error")
        }
        return currentUser
    }
    
    
    static func removeUserFromCoreData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do
        {
            try context.execute(deleteRequest)
        }
        catch let error as NSError {
            // TODO: handle the error
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    
    ///Sets true or false to isActive bool
    static func updateCurrentUser(user: CurrentUser){
        var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let result = try? managedObjectContext.fetch(fetchRequest)
        let resultData = result as! [NSManagedObject]
        for object in resultData {
            object.setValue(user.getAge(), forKey: "age")
            object.setValue(user.getCountry(), forKey: "country")
            object.setValue(user.getLanguage(), forKey: "language")
            object.setValue(user.getGender(), forKey: "gender")
        }
        do
        {
            try managedObjectContext.save()
            print(user.toString())
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    static func numberOfCoreUser() -> Int
    {
        var currentUserNumber = Int()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(fetchRequest)
            currentUserNumber = results.count
        }
        catch
        {
            print("There is a error")
        }
        return currentUserNumber
    }
    
    
}

//
//  AppDelegate.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 28.01.2021.
//

import UIKit
import Firebase
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var isActiveArray = [Bool]()
    var window: UIWindow?
    
    lazy var persistentContainer: NSPersistentContainer = { //Implemantation of core data

        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        isActiveArray = getCoreData()//Gets value from core data
        let currentUser = Auth.auth().currentUser
        if isActiveArray[0] == false
        {
            if currentUser != nil//if isActive false logout
            {
                do
                {
                    try Auth.auth().signOut()
                    CoreDataUtil.removeUserFromCoreData()
                }
                catch{print("error")}
            }
        }
        else
        {
            if currentUser != nil//if user isActive go to main page
            {
                let board = UIStoryboard(name: "Main", bundle: nil)
                var openViewController: UIViewController = board.instantiateViewController(withIdentifier: "first") as! UIViewController
                self.window?.rootViewController = openViewController
            }
        }
            return true
    }
    
    

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    ///Gets isActive bool from CoreData
    func getCoreData() -> [Bool]
    {
        self.isActiveArray.removeAll(keepingCapacity: false)
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "IsActiveElement")
        fetchRequest.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(fetchRequest)
            print("Results of isActive")
            print(results.count)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    if let isActive = result.value(forKey: "isActive") as? Bool
                    {
                        self.isActiveArray.append(isActive)
                    }
                }
            }
            else{self.isActiveArray.append(false)}
        }
        catch
        {
            print("There is a error")
        }
        return isActiveArray
    }
    
   
    
    


}


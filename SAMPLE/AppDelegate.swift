//
//  AppDelegate.swift
//  SAMPLE
//
//  Created by Craig Rhodes on 3/26/16.
//  Copyright © 2016 Spectator Publishing Company. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Create a realm (from the RealmSwift framework)
        // The Realm framework allows us to store variables between app relaunches
        // The ability to do this is known as data "persistence".
        let realm = try! Realm()
        
        // Uncomment to delete the realm object if it is currently stored 
        //  so that another request will be made
        /*
         if let storedRealmObj = realm.objects(TestRealmObject).first {
            try! realm.write {
                realm.delete(realm.objects(TestRealmObject).first!)
            }
         }
        */
        
        // If our object has not been stored previously, we need to request it
        if realm.objects(TestRealmObject).count == 0 {
            
            print("Our object has NOT been stored previously.")
            print("Sending request for object data.")
            
            // Request data asynchronously using the Alamofire framework...
            //  asynchronous means that this request will launch in a separate thread/dispatch queue
            //  as we continue past it...
            // Basically, we're not waiting for the response before continuing on
            Alamofire.request(.GET, "http://www.mocky.io/v2/56f6fbb7100000950f880256").validate().responseJSON { response in
                
                // This part only runs once a response is received
                
                // Make sure the requested data was retrieved successfully
                guard response.result.isSuccess else {
                    print("Request failed.")
                    return
                }
                
                // Get data from response using the SwiftyJSON framework
                let json = JSON(data: response.data!)
                let id  = json["user"]["id"].intValue
                let name = json["user"]["name"].stringValue
                
                // Create an object to store the data we just got
                let realmObject = TestRealmObject()
                realmObject.id = id
                realmObject.name = name
                
                // Use realm to store object
                let realm = try! Realm()
                try! realm.write {
                    realm.add(realmObject)
                }
                
                print("Our realm object (id = \(realmObject.id), name = \(realmObject.name)) has been stored.")
                print("If you relaunch the app, this request will not be made again.")
                
            }
            
        } else {
            
            // Our object is apparently already stored
            print("Realm object was previously stored.")
            
            
            let realmObject = realm.objects(TestRealmObject).first!
            print("Our realm object has id = \(realmObject.id) and name = \(realmObject.name)")
            
        }
        
        print("Reached the end of application(_:didFinishLaunchingWithOptions:)")
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
    }


}


//
//  AppDelegate.swift
//  MovieQuotes
//
//  Created by Justin Hohl on 3/27/18.
//  Copyright © 2018 hohljm. All rights reserved.
//

import UIKit

import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //        TODO: Pass managed object context in to the view controller once we do core data
        
        FirebaseApp.configure()
//        controller.managedObjectContext = self.persistentContainer.viewContext
        return true
    }



}


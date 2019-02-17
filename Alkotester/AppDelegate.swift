//
//  AppDelegate.swift
//  Alkotester
//
//  Created by Ekaterina Kozlova on 06.02.2019.
//  Copyright © 2019 Ekaterina Kozlova. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if let tabBarController = self.window?.rootViewController as? UITabBarController
        {
            if launchedBefore
            {
                tabBarController.selectedIndex = 0
                if let _ = UserDefaults.standard.stringArray(forKey: "settingsDrinkNameArray")
                {
                    drinkNameArray = UserDefaults.standard.stringArray(forKey: "settingsDrinkNameArray") ?? [String]()
                }
                if let _ = UserDefaults.standard.array(forKey: "settingsDrinkVolumeArray")
                {
                    drinkVolumeArray = UserDefaults.standard.array(forKey: "settingsDrinkVolumeArray") as? [Int] ?? [Int]()
                }
                if let _ = UserDefaults.standard.array(forKey: "settingsDrinkQuantityArray")
                {
                    drinkQuantityArray = UserDefaults.standard.array(forKey: "settingsDrinkQuantityArray") as? [Int] ?? [Int]()
                }
                if let _ = UserDefaults.standard.array(forKey: "settingsDrinkHungerArray")
                {
                    drinkHungerArray = UserDefaults.standard.array(forKey: "settingsDrinkHungerArray") as? [Float] ?? [Float]()
                }
                if let _ = UserDefaults.standard.array(forKey: "settingsDrinkDateArray")
                {
                    drinkDateArray = UserDefaults.standard.array(forKey: "settingsDrinkDateArray") as? [Date] ?? [Date]()
                }
            }
            else
            {
                tabBarController.selectedIndex = 2
                UserDefaults.standard.set(true, forKey: "launchedBefore")

            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        UserDefaults.standard.synchronize()
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.synchronize()
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


//
//  AppDelegate.swift
//  Homework_POS_Drink
//
//  Created by S10414 on 2019/1/24.
//  Copyright © 2019年 S10414. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //品項
    var arrayItemTea: NSMutableArray = NSMutableArray()
    var arrayItemMilkTea:NSMutableArray = NSMutableArray()
    //單價
    //var arrayPriceTea: NSMutableArray = NSMutableArray()
    //var arrayPriceMilkTea:NSMutableArray = NSMutableArray()
    var arrayPriceTea: [Int] = [Int]()
    var arrayPriceMilkTea:[Int] = [Int]()
    //圖片
    var arrayImageTea: NSMutableArray = NSMutableArray()
    var arrayImageMilkTea:NSMutableArray = NSMutableArray()
    //選購
    var arrayItemToCart: [Dictionary<String,Any>] = [Dictionary<String,Any>]()
    //甜度
    var arraySugar: [String] = [String]()
    //冰塊
    var arrayIce: [String] = [String]()
    //配料
    var arrayIngredients: [String] = [String]()
    //Key
    let Key_drinkName: String = "Key_drinkName"
    let Key_drinkPrice: String = "Key_drinkPrice"
    let Key_drinkImage: String = "Key_drinkImage"
    let Key_drinkQuantity: String = "Key_drinkQuantity"
    let Key_drinkSugar: String = "Key_drinkSugar"
    let Key_drinkIce: String = "Key_drinkIce"
    let Key_drinkIngredients: String = "Key_drinkIngredients"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
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
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


//
//  MyAppDelegate.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 06/12/21.
//

import UIKit
//import RealmSwift

class MyAppDelegate: NSObject, UIApplicationDelegate {

//  var realm: Realm!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    print("hi from app delegate")

//    realm = try! Realm()

    return true
  }

  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {

    let config = UISceneConfiguration(name: "My Scene Delegate", sessionRole: connectingSceneSession.role)
    config.delegateClass = MySceneDelegate.self
    return config
  }

  func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {

  }
}

//
//  AppDelegate.swift
//  TrafficAlert
//
//  Created by csuftitan on 3/18/24.
//

import Foundation
import GooglePlaces

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSPlacesClient.provideAPIKey(API_KEY)
        print("APPDELEGATE executed")
        return true
    }
}

//
//  TrafficAlertApp.swift
//  TrafficAlert
//
//  Created by csuftitan on 3/17/24.
//

import SwiftUI

@main
struct TrafficAlertApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TestView()
        }
    }
}

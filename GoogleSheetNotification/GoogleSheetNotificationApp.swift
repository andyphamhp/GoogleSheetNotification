//
//  GoogleSheetNotificationApp.swift
//  GoogleSheetNotification
//
//  Created by Andy Pham on 21/02/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseMessaging
import UserNotifications

@main
struct GoogleSheetNotificationApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    private var demoString = "abc"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Receive silent notification
        if let body = userInfo["body"] as? String {
            print(body)
        }
        completionHandler(.newData)
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Received fcm Token: \(String(describing: fcmToken))")
        Messaging.messaging().subscribe(toTopic: "all")
    }
}

/*
 Copyright 2021 Adobe. All rights reserved.
 This file is licensed to you under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License. You may obtain a copy
 of the License at http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software distributed under
 the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
 OF ANY KIND, either express or implied. See the License for the specific language
 governing permissions and limitations under the License.
 */

import UIKit
import AEPCore
import AEPPlaces
import AEPAssurance
import AEPSignal
import AEPAnalytics
import AEPIdentity
import AEPLifecycle

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MobileCore.setLogLevel(.trace)
        
        // steve-places in Adobe Benedick Corp: launch-EN459260fc579a4dcbb2d1743947e65f09-development
        MobileCore.configureWith(appId: "launch-EN459260fc579a4dcbb2d1743947e65f09-development")
        
        let appState = application.applicationState
        MobileCore.registerExtensions([Places.self, Signal.self, Analytics.self, Identity.self, Lifecycle.self, AEPAssurance.self]) {
            // Griffon Session - AEPPlaces in Adobe Benedick Corp
            AEPAssurance.startSession(URL(string: "aepplaces://?adb_validation_sessionid=ecc9abb0-9028-4312-bc1d-a16920353e79")!)
            
            if appState != .background {
                MobileCore.lifecycleStart(additionalContextData: nil)
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


# DI

- SwiftInject: this require a more complex config of each dependency
- [Factory](https://github.com/hmlongco/Factory): this is a simplified version and easy to model it.

#  Background long running tasks

- It is not possible to have multi processes in an iOS app.

- [Reference 1](https://janviarora.medium.com/what-long-running-tasks-can-ios-support-in-the-background-9089d1c0112f#:~:text=regular%20phone%20calls.-,Background%20fetch%3A,the%20app%20is%20not%20running.) - long running background and notifications
- [Guidelines](https://developer.apple.com/documentation/xcode/configuring-background-execution-modes) - Apple’s PLATFORMS support these background execution modes

# Background tasks (short)
```sh
    let job: Task<Void, Error> = Task(success: {}, error: {}) or 
    let job: Task<Void, Error> = Task { try await asyncFunction(....) }
    combined with func asyncFunction(....) [throws] async -> [return] {
        // dos ome background work here
    }
```
## Timer scheduler

```sh
    Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(splashTimeOut(sender:)), userInfo: nil, repeats: false)
```

# UI Thread
```sh
    DispatchQueue.main.async {..some code here for UI..}
```

#  Notifications

- Request authorization to show notifications:

```sh
UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
    // Handle any errors
}
```
- [Reference 1](@https://janviarora.medium.com/what-long-running-tasks-can-ios-support-in-the-background-9089d1c0112f#:~:text=regular%20phone%20calls.-,Background%20fetch%3A,the%20app%20is%20not%20running.) - Notifications handler
- [Notifications UI](https://developer.apple.com/documentation/uikit/uilocalnotification)

# HTTP REQUESTS

- URLSession.shared.dataTask ... (The URLSession API provides a powerful and flexible way to download data in the background, even when the app is in the background or not running)
- [Alamofire](https://codewithchris.com/alamofire/) - http client library to handle at full options the http requests: pod “Alamofire”
- [Encodable[object->json]/Decodable[json->object]](https://www.linkedin.com/pulse/encodable-decodable-codable-swift-omkar-raut-ata7f/)

# COMBINE

- handle async states like states flows in kotlinL @published or by implementing Protocol: ObservableObject (no need to import combined then)

# Recover the app state

- NSUserActivity, UIUserActivityRestoring - in case the app crashed or closed by force we can restore the initial state of the app
    by reoppening same screen based on some simplified arguments. Similar with Android for "onSaveInstanceState"

# Data Base

- [CoreData](https://developer.apple.com/documentation/coredata/) - for the local database
- [Core data to access and view the DB with a client DB](
https://stackoverflow.com/questions/10239634/how-can-i-check-what-is-stored-in-my-core-data-database)
- https://medium.com/mobile-app-development-publication/a-guide-to-persistence-storage-in-ios-a8b4f7355486

## Secure Data Storage of some chunks of data

Keychain(Recomanded for encryption) - Keychain is safe & encrypted way to save small storage data like username, password etc. Beware keychain data can accessible from jailbroken devices. 

Keychain Sharing- Enabling keychain sharing allows your app to share passwords in the keychain with other apps developed by your team. Suppose we created two apps where users can log into the same account. It would be nice to have ability to share the login information between these apps. This way the user will only need to log in once in one of the apps.

UserDefaults(Not safe only some key/value data) - An interface to the user's defaults database, where you store key-value pairs persistently across invocations of your app on a given device. UserDefaults are not secure way to save private data. UserDefaults are stored as plist locally, Anyone can track in ./Library/Preferences/com.mycompany.MyAppName.plist


# Swift Animations

- Using the concepts of scene and scene nodes. Ex: SKScene, SKSpriteNode (project 14)
- Bounds(dim. of the picture), Layer(surface of animation, style), frame (the picture on the wall)

# SPLASH SCREEN

- There is no fix idea how to implement this. However there are two ways: through .plist setting or through the *LaunchScreen.storyboard.

# Swift UI

- [View Inspector](https://github.com/nalexn/ViewInspector) - for SwiftUI instrudmentation test

# Live Activities (Widgets)

- https://medium.com/kinandcartacreated/how-to-build-ios-live-activity-d1b2f238819e - usualy working with push notification system.

# Scenes and SceneDelegate

- The Scene Delegate is responsible for managing the life cycle of scenes in an iOS application. A scene represents a window (like an Android activity) and its associated content, such as viewcontrollers, user interfaces, and interactions. The Scene Delegate is responsible for creating new scenes when the application launches and destroying them when the application terminates.


```sh
// We can have now another root controler navigation which will be bound to this new scene.
func createNewScene() {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
    }
}
```

# SECURITY

## Options we need to take in consideration when we talk about security in an IOS app

- check against: Screen Recording and Screen Capturing
- Jail Break Detection
- keychain
- certificate pinning
- file save encripted
- [More additional info and guidelines](https://pratap89singh.medium.com/ios-mobile-app-security-best-practices-for-ios-mobile-developers-a7e9375d40be)

# COCOAPODS (reopen the project from workspace not from the project)

Note: Need to close the XCODE when altering the pod configuration file.

- [How to install](https://stackoverflow.com/questions/20755044/how-do-i-install-cocoapods)
- https://stackoverflow.com/questions/76590131/error-while-build-ios-app-in-xcode-sandbox-rsync-samba-13105-deny1-file-w
- How to cleanup and reinstall the repo for pod libraries in case of any issue

```sh
pod repo remove master 
pod setup 
pod install --> will install the libraries from the pod file

Or: 

sudo rm -fr ~/.cocoapods/repos/master 
pod setup 
pod install

OTHER

pod repo update

```

# Generate the .ipa (iOS package App Store) and developer account (require 100$ per year)

- Product -> Destination -> Any iOs device; Product -> Archive -> Distribute App (err: enrolled in the Apple Developer Program)
    - [Team account](https://developer.apple.com/account)
    - [How To](https://developer-docs.citrix.com/en-us/mobile-application-integration/mam-sdk-for-ios-and-ipads/generating-an-ipa.html)
- If the code will get obfuscate or not easy to be read then error on app submition into the play store: We discovered that your app contains obfuscated code, selector mangling, or features meant to subvert the App Review process by changing this app's concept after approval to the App Store.

# ERROR POD

- https://stackoverflow.com/questions/76590131/error-while-build-ios-app-in-xcode-sandbox-rsync-samba-13105-deny1-file-w

# Check version of the Swift

- xcrun swift -version

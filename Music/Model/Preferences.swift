import UIKit

class SavePreferences {
    
    static let userPreferences = UserDefaults.standard
    
    static var playNext = userPreferences.bool(forKey: "playNext")
    static var countinuousPlayback = userPreferences.bool(forKey: "countinuousPlayback")
    
    static func savePreferences() {
        userPreferences.set(playNext, forKey: "playNext")
        userPreferences.set(countinuousPlayback, forKey: "countinuousPlayback")
    }
    static func loadPreferences() {
//        playNext =
//        countinuousPlayback =
    }
    
    
}

import Foundation

class SaveMedia {
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!
    static var archiveURL = documentsDirectory.appendingPathComponent("music").appendingPathExtension("plist")
    
    static let propertyListEncoder = PropertyListEncoder()
    static let propertyListDecoder = PropertyListDecoder()
    
    
//    static func writeUrl(url: URL) {
//        let urlString = url.absoluteString
//        let mp3Path = urlString.components(separatedBy: "/")
//        let mp3Name = mp3Path[mp3Path.count-1]
//
//        let archiveURL = documentsDirectory.appendingPathComponent(mp3Name)
//
//        let propertyListEncoder = PropertyListEncoder()
//        let encodedUrls = try? propertyListEncoder.encode(url)
//
//        try? encodedUrls?.write(to: archiveURL, options: .noFileProtection)
//    }
    static func readUrls() -> [URL] {
        var urlUpdate:[URL] = []
        if let retrievedUrlsData = try? Data(contentsOf: archiveURL),
            let decodedUrls = try? propertyListDecoder.decode(Array<URL>.self, from: retrievedUrlsData) {
                urlUpdate = decodedUrls
        }
       
//        urlUpdate.removeAll { (url) -> Bool in
//            url == nil
//        }
//        print(urlUpdate[0])
        return urlUpdate;
    }
    static func updateUrls(url: URL) {
        var urls: [URL] = readUrls();
        urls.append(url)
        let encodedUrls = try? propertyListEncoder.encode(urls)
        try? encodedUrls?.write(to: archiveURL, options: .noFileProtection)
    }
    static func deleteMP3(row: Int) {
        var urls: [URL] = readUrls();
        urls.remove(at: row)
        let encodedUrls = try? propertyListEncoder.encode(urls)
        try? encodedUrls?.write(to: archiveURL, options: .noFileProtection)
    }
    static func clearAll() {
        let urls: [URL] = [URL]()
        let encodedUrls = try? propertyListEncoder.encode(urls)
        try? encodedUrls?.write(to: archiveURL, options: .noFileProtection)
    }
   static func extractMP3Name(url: URL) -> String {
       let urlString = url.absoluteString
       let mp3Path = urlString.components(separatedBy: "/")
       var mp3Name = mp3Path[mp3Path.count-1]
       mp3Name = mp3Name.replacingOccurrences(of: "%20", with: " ")
       mp3Name = mp3Name.replacingOccurrences(of: ".mp3", with: "")
       return mp3Name
   }
    static func musicCount() -> Int {
        return SaveMedia.readUrls().count
    }
    
}


import AVFoundation

class Music {
    static var audioPlayer = AVAudioPlayer()
    static var current = 0;
    static var audioState = false
    
    static func play(){
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
        
    }
    static func pause() {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        }
    }
    static func next() {
        if current <  SaveMedia.musicCount()-1 {
            playURL(url: SaveMedia.readUrls()[current+1])
            current += 1
        }
    }
    static func previous() {
        if current > 0 {
            playURL(url: SaveMedia.readUrls()[current-1])
            current -= 1
        }
    }
    static func playURL(url: URL) {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch  {
            print(url)
            print(error)
        }
    }
    static func playLibraryAt(row: Int) {
        do {
            
            try audioPlayer = AVAudioPlayer(contentsOf: SaveMedia.readUrls()[row])
            audioPlayer.play()
            current = row
            
        } catch  {
            SaveMedia.deleteMP3(row: row)
            print("dmlkrflrr")
            print(error)
            
        }
    }
    static func currentName() -> String? {
        if current >= SaveMedia.readUrls().count{
            return "Not Playing"
        }
        else{
            return SaveMedia.extractMP3Name(url: SaveMedia.readUrls()[current])
        }
    }
    static func playNextAutomaticaly() {
        if(Music.audioPlayer.duration == Music.audioPlayer.currentTime) {
            Music.next();
        }
    }
    static func playback() {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: SaveMedia.readUrls()[current])
            audioPlayer.play()
            
        } catch  {
            print(error)
        }
    }
}
    


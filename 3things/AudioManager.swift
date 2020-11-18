//
//  AudioManager.swift
//  3things
//
//  Created by Sean Mc Mains on 2/1/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation
import AVFoundation

enum Sound: String {
    case checkOn = "CheckOn"
    case checkOff = "CheckOff"
    
    static let array = [checkOn, checkOff]
}

class AudioManager {
    
    let audioPlayers: [Sound: AVAudioPlayer]
    
    init() {
        AudioManager.configureAudioSession()
        self.audioPlayers = AudioManager.getAudioPlayers()
    }
    
    static private func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(
                AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.ambient)
                ))
        } catch {
            print("Error: unable to set audio session category")
        }
    }
    
    func play(sound: Sound) {
        guard let player = audioPlayers[ sound ]
            else {
                print( "Error: no audio player available for \(sound)" )
                return
        }
        
        if player.isPlaying {
            player.pause()
            player.currentTime = 0
        }
        player.play()
    }
    
    private class func getAudioPlayers() -> [Sound: AVAudioPlayer] {
        var players: [Sound: AVAudioPlayer] = [:]
        for sound in Sound.array {
            if let filePath = Bundle.main.path(forResource: sound.rawValue, ofType: "aif") {
                let url = URL.init(fileURLWithPath: filePath)
                if let player = try? AVAudioPlayer.init(contentsOf: url) {
                    player.prepareToPlay()
                    player.volume = 0.7
                    players[ sound ] = player
                }
            }
        }
        return players
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
private func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}

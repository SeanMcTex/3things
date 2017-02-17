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
    case on = "CheckOn"
    case off = "CheckOff"
    
    static let array = [on, off]
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
            try audioSession.setCategory( AVAudioSessionCategoryAmbient )
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
    
    fileprivate class func getAudioPlayers() -> [Sound: AVAudioPlayer] {
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

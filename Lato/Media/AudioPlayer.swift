//
//  AudioPlayer.swift
//  Lato
//
//  Created by juandahurt on 5/02/21.
//

import Foundation
import AVFoundation

struct AudioPlayer {
    var audioPlayer: AVAudioPlayer!
    
    mutating func play(_ soundFileName : String) {
        guard let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: nil) else {
            fatalError("Unable to find \(soundFileName) in bundle")
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer.numberOfLoops = .max
        } catch {
            print(error.localizedDescription)
        }
        audioPlayer.play()
    }
    
    mutating func play() {
        audioPlayer.play()
    }
    
    mutating func pause() {
        audioPlayer.pause()
    }
}

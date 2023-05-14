//
//  DefaultAudioPlayer.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/14.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
    func playSound()
}

final class DefaultAudioPlayer: AudioPlayerService {

    private var player: AVAudioPlayer?

    func playSound() {
        if let path = Bundle.main.path(forResource: "click", ofType: "m4a") {
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch(let error) {
                print(error.localizedDescription)
            }
        } else {
            print("Error: Audio file is nil")
        }
    }
}


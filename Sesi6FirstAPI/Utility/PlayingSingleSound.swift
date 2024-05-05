//
//  PlayingSingleSound.swift
//  Sesi6FirstAPI
//
//  Created by Hidayat Abisena on 28/01/24.
//

import Foundation
import AVFoundation
import UIKit

var audioPlayer: AVAudioPlayer?

func playSingleSound(sound: String, type: String) {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      audioPlayer?.play()
    } catch {
      print("Could not find and play the sound file.")
    }
  }
}

func playSound(soundName: String) {
    guard let soundFile = NSDataAsset(name: soundName) else {
        print("ERROR: Could not read file named \(soundName)")
        return
    }
    
    do{
        audioPlayer = try AVAudioPlayer(data: soundFile.data)
        audioPlayer?.play()
    } catch {
        print("ERROR: \(error.localizedDescription) creating audioPlayer")
    }
    
    
}

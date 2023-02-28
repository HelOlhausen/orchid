//
//  ViewController.swift
//  orquidea
//
//  Created by Manuela Vilanova on 22/2/22.
//

import UIKit
import AVFoundation

private enum Sounds: String, CaseIterable {
    case jupiter // 1
    case venus // 2
    case marte // 3
    case mercurio // 4
    case saturno // 5
    case urano // 6
    case neptuno // 7
    case pluton // 8
    case luna // 9
    case sol // 10
}

class ViewController: UIViewController {
    
    private var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
    }
    
    @IBAction func tapOnConsultar(_ sender: Any) {
        let oracleResult = oracleRequest()
        
        startPlaying(selectedName: oracleResult)
    }
    
    private func oracleRequest() -> String {
        let value = Int.random(in: 0..<Sounds.allCases.count)
        let soundName = Sounds.allCases[value].rawValue
        print(soundName, value+1)
        return soundName
    }
    
    private func startPlaying(selectedName: String) {
        guard let soundPath = Bundle.main.path(forResource: selectedName, ofType: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath))
        } catch {
            print(error)
        }
        
        audioPlayer.play()
    }
}


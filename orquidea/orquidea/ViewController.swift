//
//  ViewController.swift
//  orquidea
//
//  Created by Helen Olhausen on 22/2/22.
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
        askTheOracleButton.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 0.3, animations: { [weak self] in
            self?.askTheOracleButton.alpha = 1.0
        })
    }
    
    @IBOutlet weak var askTheOracleButton: UIButton!
    
    @IBAction func tapOnConsultar(_ sender: Any) {
        UIView.animate(withDuration: 0.8, delay: 0.0, animations: { [weak self] in
            self?.askTheOracleButton.alpha = 0.0
        })
        
        let oracleResult = oracleRequest()
        
        startPlaying(selectedName: oracleResult)
        
        askTheOracleButton.setTitle(oracleResult, for: .normal)
        askTheOracleButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        
        UIView.animate(withDuration: 0.5, delay: 0.8, animations: { [weak self] in
            self?.askTheOracleButton.alpha = 1.0
        })
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


//
//  AudioPlayerService.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 17/12/23.
//

import AVKit
import Foundation

final class AudioPlayerService: NSObject {
    private var service: AVAudioPlayer?
    
    func playChant(for team: Team) -> Void {
        if team.isPlayingChant {
            service?.stop()
        } else {
            guard let path = Bundle.main.path(
                forResource: "\(team.teamType.chantFile)",
                ofType: "mp3") else { return }
            
            let url: URL
            if #available(iOS 16.0, *) {
                url = URL(filePath: path)
            } else {
                url = URL(fileURLWithPath: path)
            }
            
            service = try? AVAudioPlayer(contentsOf: url)
            service?.numberOfLoops = -1
            service?.play()
        }
    }
    
    func resetChant() -> Void {
        self.service?.stop()
    }
}

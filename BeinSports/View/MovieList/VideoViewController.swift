//
//  VideoViewController.swift
//  BeinSports
//
//  Created by Akın Aksoy on 29.03.2023.
//

import UIKit
import AVKit
class VideoViewController: AVPlayerViewController {

    
    var playerLayer : AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(mediaURL : String){
        guard let mediaUrl = URL(string: mediaURL) else {return}
        player = AVPlayer(url: mediaUrl)
        self.playerLayer = AVPlayerLayer(player: player)
        guard let playerLayer = playerLayer else {
            return
        }

        self.view.layer.addSublayer(playerLayer)
        
        playerLayer.frame = view.bounds
        guard let player = player else {return}
        player.play()
        
    }
}

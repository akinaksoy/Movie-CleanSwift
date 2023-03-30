//
//  VideoViewController.swift
//  BeinSports
//
//  Created by Akın Aksoy on 29.03.2023.
//

import UIKit
import AVKit
class VideoViewController: AVPlayerViewController {

    var playerLayer: AVPlayerLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configure(mediaURL: String, titleVideo: String) {

        playVideo(mediaURL: mediaURL)
        setTextVideo(titleText: titleVideo)

    }

    private func playVideo(mediaURL: String) {
        guard let mediaUrl = URL(string: mediaURL) else {return}
        player = AVPlayer(url: mediaUrl)
        self.playerLayer = AVPlayerLayer(player: player)
        guard let playerLayer = playerLayer else {
            return
        }

        playerLayer.frame = view.bounds
        self.view.layer.addSublayer(playerLayer)
        guard let player = player else {return}
        player.play()
    }

    private func setTextVideo(titleText: String) {

        let textlayer = CATextLayer()

        textlayer.frame = CGRect(x: 0, y: (UIScreen.main.bounds.minY+40), width: UIScreen.main.bounds.width, height: 24)
        textlayer.zPosition = 1
        textlayer.fontSize = 20
        textlayer.alignmentMode = .center
        textlayer.string = titleText
        textlayer.isWrapped = true
        textlayer.truncationMode = .end
        textlayer.foregroundColor = UIColor.white.cgColor
        textlayer.backgroundColor = UIColor.gray.withAlphaComponent(0.3).cgColor

        self.view.layer.addSublayer(textlayer)
    }

}

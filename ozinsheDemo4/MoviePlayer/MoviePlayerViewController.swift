//
//  MoviePlayerViewController.swift
//  ozinsheDemo4
//
//  Created by Ернат on 26.09.2023.
//

import UIKit
import YouTubePlayer

class MoviePlayerViewController: UIViewController {
    @IBOutlet weak var player: YouTubePlayerView!
    
    var video_link = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        player.loadVideoID(video_link)
    }

}

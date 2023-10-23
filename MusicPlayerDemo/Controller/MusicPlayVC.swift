//
//  MusicPlayVC.swift
//  MusicPlayerDemo
//
//  Created by Mehedi Hasan on 27/9/23.
//

import UIKit
import MediaPlayer
import AVFoundation

class MusicPlayVC: UIViewController {
    
    
    @IBOutlet weak var currentMusicImageView: UIImageView!
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var lblMusicName: UILabel!
    
    var image: UIImage?
    var index: IndexPath?
    var label: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let lbl = label else { return }
        lblMusicName.text = lbl
        
        guard let img = image else { return }
        currentMusicImageView.image = img
        
        guard let idx = index else { return }
        MusicControl.shared.audio = MusicControl.shared.initMusicPlayer(indexPath: idx)

    }
    
    @IBAction func btnPlayPauseMusicAction(_ sender: UIButton) {
        
            if MusicControl.shared.isPlaying == false {
                MusicControl.shared.audio?.play()
                btnPlayPause.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                MusicControl.shared.isPlaying = true
            }
            else{
                MusicControl.shared.audio?.pause()
                btnPlayPause.setImage(UIImage(systemName: "play.fill"), for: .normal)
                MusicControl.shared.isPlaying = false
            }
    }
    
    @IBAction func btnStopMusicAction(_ sender: UIButton) {
        
        if let indexMusic = index {
            if MusicControl.shared.isPlaying == true {
                
                MusicControl.shared.stopMusic(indexPath: indexMusic)
                
                btnStop.setImage(UIImage(systemName: "stop.fill"), for: .normal)
                btnPlayPause.setImage(UIImage(systemName: "play.fill"), for: .normal)
                MusicControl.shared.isPlaying = false
            }
        }
    }
        
    @IBAction func btnNextTrackAction(_ sender: UIButton) {
        
    }
    
    @IBAction func btnPreviousTrackAction(_ sender: UIButton) {
        
    }
    
}

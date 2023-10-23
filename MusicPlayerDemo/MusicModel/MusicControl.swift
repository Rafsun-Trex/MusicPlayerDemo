//
//  File.swift
//  MusicPlayerDemo
//
//  Created by Mehedi Hasan on 27/9/23.
//

import UIKit
import MediaPlayer
import AVFoundation

class MusicControl{
    
    static let shared = MusicControl()
    
    var albums: [AlbumInfo] = []
    var songQuery: SongQuery = SongQuery()
    var audio: AVAudioPlayer?
    var isPlaying = false
    var myIndex: IndexPath?
    
    
    func initMusicPlayer(indexPath: IndexPath) -> AVAudioPlayer {
        
        let songId: NSNumber = albums[indexPath.section].songs[indexPath.row].songId
        
        let item: MPMediaItem = songQuery.getItem( songId: songId )
        let url: NSURL = item.value( forProperty: MPMediaItemPropertyAssetURL ) as! NSURL
        do {
            audio = try AVAudioPlayer(contentsOf: url as URL)
            if let player = audio {
                player.prepareToPlay()
                return player
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        return audio!
    }
    
    
    func playMusic(indexPath: IndexPath) {
        let songId: NSNumber = albums[indexPath.section].songs[indexPath.row].songId
        let item: MPMediaItem = songQuery.getItem( songId: songId )
        let url: NSURL = item.value( forProperty: MPMediaItemPropertyAssetURL ) as! NSURL
        do {
            audio = try AVAudioPlayer(contentsOf: url as URL)
            guard let player = audio else { return }
                player.prepareToPlay()
                player.play()
                isPlaying = true
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func pauseMusic(indexPath: IndexPath) {
        let songId: NSNumber = albums[indexPath.section].songs[indexPath.row].songId
        let item: MPMediaItem = songQuery.getItem( songId: songId )
        let url: NSURL = item.value( forProperty: MPMediaItemPropertyAssetURL ) as! NSURL
        do {
            audio = try AVAudioPlayer(contentsOf: url as URL)
            guard let player = audio else { return }
            player.pause()
            isPlaying = false
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopMusic(indexPath: IndexPath) {
        let songId: NSNumber = albums[indexPath.section].songs[indexPath.row].songId
        let item: MPMediaItem = songQuery.getItem( songId: songId )
        let url: NSURL = item.value( forProperty: MPMediaItemPropertyAssetURL ) as! NSURL
        do {
            audio = try AVAudioPlayer(contentsOf: url as URL)
            guard let player = audio else { return }
            player.prepareToPlay()
            player.stop()
            isPlaying = false
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
}


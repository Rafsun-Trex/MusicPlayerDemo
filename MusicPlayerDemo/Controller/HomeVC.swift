//
//  ViewController.swift
//  MusicPlayerDemo
//
//  Created by Mehedi Hasan on 25/9/23.
//

import UIKit
import MediaPlayer
import AVFoundation

class HomeVC: UIViewController {

    @IBOutlet weak var musicTableView: UITableView!{
        didSet{
            musicTableView.register(MusicTVCell.nib(), forCellReuseIdentifier: MusicTVCell.identifier)
        }
    }
    
    var albums: [AlbumInfo] = []
    var songQuery: SongQuery = SongQuery()

    
    var audio: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                self.albums = self.songQuery.get(songCategory: "")
                
                MusicControl.shared.albums = self.albums
                
                DispatchQueue.main.async {
                    self.musicTableView.rowHeight = UITableView.automaticDimension;
                    self.musicTableView.reloadData()
                }
            } else {
                self.displayMediaLibraryError()
            }
        }
        
    }
    

}


extension HomeVC {
    
    func displayMediaLibraryError() {
            var error: String
            switch MPMediaLibrary.authorizationStatus() {
            case .restricted:
                error = "Media library access restricted by corporate or parental settings"
            case .denied:
                error = "Media library access denied by user"
            default:
                error = "Error"
            }

            let controller = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            controller.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { (action) in
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }))
            present(controller, animated: true, completion: nil)
        }
}

extension HomeVC: UITableViewDataSource{
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return albums.count
        }

        func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int  {
            return albums[section].songs.count
        }

        func tableView( _ tableView: UITableView, cellForRowAt indexPath:IndexPath ) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "musicTVCell",for: indexPath) as! MusicTVCell
            cell.lblMusicTitle.text = albums[indexPath.section].songs[indexPath.row].songTitle
            cell.lblMusicArtistName.text = albums[indexPath.section].songs[indexPath.row].artistName
            cell.musicThumbImageView.image = albums[indexPath.section].songs[indexPath.row].songImage.image(at: CGSize(width: 48, height: 48))
            return cell
            
        }

        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

            return albums[section].albumTitle
        }
    
}

extension HomeVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(albums[indexPath.section].songs[indexPath.row].songTitle)")
        
        let musicPlayVC = storyboard?.instantiateViewController(withIdentifier: "MusicPlayVC") as! MusicPlayVC
        
        musicPlayVC.label = albums[indexPath.section].songs[indexPath.row].songTitle
        musicPlayVC.image = albums[indexPath.section].songs[indexPath.row].songImage.image(at: CGSize(width: 400, height: 400))
        musicPlayVC.index = indexPath
        
        present(musicPlayVC, animated: true)
   }
}



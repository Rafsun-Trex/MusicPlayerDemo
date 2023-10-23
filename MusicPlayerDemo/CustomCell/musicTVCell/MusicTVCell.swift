//
//  musicTVCell.swift
//  MusicPlayerDemo
//
//  Created by Mehedi Hasan on 26/9/23.
//

import UIKit

class MusicTVCell: UITableViewCell {
    
    @IBOutlet weak var musicThumbImageView: UIImageView!
    @IBOutlet weak var lblMusicTitle: UILabel!
    @IBOutlet weak var lblMusicArtistName: UILabel!
    
    static let identifier = "musicTVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "musicTVCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

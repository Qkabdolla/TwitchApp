//
//  MainCell.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/3/20.
//

import UIKit
import Kingfisher

final class MainCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewerLabel: UILabel!
    @IBOutlet weak var chanel: UILabel!
    
    func bind(item: GameListItem) {
        chanel.text = "Channels - \(item.games.channelsCount)"
        viewerLabel.text = "Viewers - \(item.games.viewersCount)"
        titleLabel.text = item.games.gameDetail?.name
        logoImageView.kf.setImage(with: URL(string: item.games.gameDetail?.image?.medium ?? ""))
    }
    
    override func prepareForReuse() {
        logoImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

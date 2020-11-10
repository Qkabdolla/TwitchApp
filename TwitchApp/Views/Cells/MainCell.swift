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
        guard let itema: GameListItem = item as? GameListItem else {
            fatalError("Incorrect item")
        }
        
        chanel.text = "Channels - \(itema.games.channelsCount ?? 0)"
        viewerLabel.text = "Viewers - \(itema.games.viewersCount ?? 0)"
        titleLabel.text = itema.games.gameDetail?.name
        logoImageView.kf.setImage(with: URL(string: itema.games.gameDetail?.image?.medium ?? ""))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

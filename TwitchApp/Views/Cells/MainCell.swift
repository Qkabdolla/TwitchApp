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
    
    func bind(item: Game) {
        chanel.text = "Channels - \(item.channelsCount ?? 0)"
        viewerLabel.text = "Viewers - \(item.viewersCount ?? 0)"
        titleLabel.text = item.gameDetail?.name
        logoImageView.kf.setImage(with: URL(string: item.gameDetail?.image?.medium ?? ""))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

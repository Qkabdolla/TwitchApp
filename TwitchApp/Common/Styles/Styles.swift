//
//  Styles.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/13/20.
//

import UIKit

func initStyles() {
    StylesManager.shared.register(LabelStyle("cellTextTitleStyle",
                                             textColor: .black,
                                             textSize: 17,
                                             font: UIFont.boldSystemFont(ofSize: 17)),
                                  LabelStyle("cellTextStyle",
                                             textColor: .black,
                                             textSize: 15),
                                  ButtonStyle("sendButtonStyle",
                                              textColor: .black,
                                              backgroundColor: .systemYellow,
                                              cornerRadius: .roundedByHeight)
    )
}

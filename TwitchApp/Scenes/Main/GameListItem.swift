//
//  MainListItem.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/9/20.
//

import Foundation

public protocol ListItem { }

struct GameListItem : ListItem {
    
    let games: Game
    
    init (from games: Game) {
        self.games = games
    }
}

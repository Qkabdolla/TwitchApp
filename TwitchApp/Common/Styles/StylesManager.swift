//
//  StylesManager.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/13/20.
//

import Foundation

final class StylesManager {
    static let shared = StylesManager()

    private var styles = [Style]()

    private init() {}

    func register(style: Style) {
        if styles.contains(where: { $0.name == style.name }) {
            fatalError("Styles already contains style with name: \(style.name)")
        }

        styles += [style]
    }

    func unregister(style: Style) {
        styles = styles.filter { $0.name != style.name }
    }

    func register(_ styles: Style...) {
        styles.forEach { register(style: $0) }
    }

    func unregister(_ styles: Style...) {
        styles.forEach { unregister(style: $0) }
    }

    func style(forName name: String) -> Style? {
        styles.first { $0.name == name }
    }
}

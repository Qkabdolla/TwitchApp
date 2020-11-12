//
//  RateViewModel.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/10/20.
//

import UIKit

class RateViewModel: ViewModel {
    
    private let thxText: String = R.string.localizable.thanksTitle()
    private var messageText: String {
        let convertedValue = Int(value)
        switch convertedValue {
        case 1:
            return R.string.localizable.youPutTitle() + " \(convertedValue) " + R.string.localizable.pointV1Title()
        case 5:
            return R.string.localizable.youPutTitle() + " \(convertedValue) " + R.string.localizable.pointV3Title()
        default:
            return R.string.localizable.youPutTitle() + " \(convertedValue) " + R.string.localizable.pointV2Title()
        }
    }
    
    var value: CGFloat = 1
    let dissmisScreenCommand = Command()

    func showAlert() {
        self.showConfirmAlert(title: thxText, message: messageText) { [weak self] in
            self?.dissmisScreenCommand.call()
        }
    }
}
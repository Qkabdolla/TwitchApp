//
//  ViewModel.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/4/20.
//

import UIKit
import RxSwift

class ViewModel {
    
    let bag: DisposeBag = DisposeBag()
    
    let showConfirmAlertControllerCommand = TCommand<(
            title: String,
            message: String,
            okButtonTitle: String,
            customButtonTitle: String?,
            okAction: () -> Void,
            customAction: () -> Void
    )>()
    
    func showConfirmAlert(
            title: String,
            message: String,
            okButtonTitle: String = R.string.localizable.okTitle(),
            customButtonTitle: String? = nil,
            okAction: @escaping () -> Void,
            customAction: @escaping () -> Void = {}
    ) {
        showConfirmAlertControllerCommand.call((title,
                message,
                okButtonTitle,
                customButtonTitle,
                okAction,
                customAction)
        )
    }
}

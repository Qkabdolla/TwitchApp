//
//  MvvmViewController.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/4/20.
//

import UIKit
import RxSwift

protocol MvvmController {
    associatedtype ViewModel
    associatedtype UIViewController
    var bag: DisposeBag { get }
    var viewModel: ViewModel! { get }
}

class MvvmViewController<TViewModel> : UIViewController, MvvmController where TViewModel: ViewModel {
    
    var bag: DisposeBag = DisposeBag()
    
    private var _viewModel: TViewModel?
    
    var viewModelProvider: () -> TViewModel = {
        (UIApplication.shared.delegate as! AppDelegate).diContainer.resolve(TViewModel.self)!
    }
    var viewModel: TViewModel! { _viewModel }
    
    typealias ViewModel = TViewModel
    typealias UIViewController = MvvmViewController<TViewModel>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _viewModel = viewModelProvider()
    }
    
    func bindViewModel() {
        bind(viewModel.showConfirmAlertControllerCommand) { [weak self] args in
            let alert = UIAlertController(title: args.title, message: args.message, preferredStyle: .alert)
            let OKAlertAction = UIAlertAction(
                    title: args.okButtonTitle,
                    style: .default
            ) { _ in
                args.okAction()
            }

            if let custom =  args.customButtonTitle {
                let customAlertAction = UIAlertAction(title: custom, style: .default) { _ in
                    args.customAction()
                }
                alert.addAction(customAlertAction)
            }
            
            alert.addAction(OKAlertAction)

            self?.present(alert, animated: true, completion: nil)
        }
    }
}

//
//  RateViewController.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/9/20.
//

import UIKit
import SwiftyStarRatingView
import RxSwift
import RxCocoa

class RateViewController: MvvmViewController<RateViewModel> {
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var rateStarView: SwiftyStarRatingView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateOut(false)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        sendButton.rx.tap.bind { [unowned self] in
            self.viewModel.value = self.rateStarView.value
            self.viewModel.showAlert()
        }.disposed(by: bag)
        
        bind(viewModel.dissmisScreenCommand) { [weak self] in
            self?.animateOut(true)
        }
    }
    
    private func initViews() {
        popUpView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        view.alpha = 0
        addGestures()
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        animateOut(true)
    }
    
    @objc private func animateOut(_ bool: Bool) {
        let outPosition = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn) { [weak self] in
            self?.popUpView.transform = bool ? outPosition : .identity
            self?.view.alpha = bool ? 0 : 1
        } completion: { [weak self] complete in
            if complete, bool {
                self?.dismiss(animated: false)
            }
        }
    }
}

extension RateViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == view
    }
}

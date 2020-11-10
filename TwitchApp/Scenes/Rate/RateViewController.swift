//
//  RateViewController.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/9/20.
//

import UIKit
import SwiftyStarRatingView

class RateViewController: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var rateStarView: SwiftyStarRatingView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configueUI()
        addGesturs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIn()
    }
    
    private func configueUI() {
        popUpView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        view.alpha = 0
    }
    
    private func addGesturs() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(animateOut))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc private func animateOut() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn) {
            self.popUpView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            self.view.alpha = 0
        } completion: { complete in
            if complete {
                self.dismiss(animated: false)
            }
        }
    }
    
    private func animateIn() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn) {
            self.popUpView.transform = .identity
            self.view.alpha = 1
        }
    }
    
    @IBAction func sendTapped(_ sender: UIButton) {
        print(rateStarView.value)
        animateOut()
    }
}

extension RateViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view != view {
            return false
        } else {
            return true
        }
    }
}

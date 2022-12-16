//
//  PresentationController.swift
//  Utils
//
//  Created by Maksim Sashcheka on 30.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit.UIPresentationController

public class PresentationController: UIPresentationController {
    private var dismissAction: Closure.Void?
    
    var cancellables: [AnyCancellable] = []
    
    public let blurEffectView: UIVisualEffectView
    
    public override var frameOfPresentedViewInContainerView: CGRect {
        guard let frame = containerView?.frame else { return .zero }
        return CGRect(origin: CGPoint(x: 0, y: frame.height * 0.72),
                      size: CGSize(width: frame.width, height: frame.height * 0.28))
    }
    
    public override init(presentedViewController: UIViewController,
                         presenting presentingViewController: UIViewController?) {
        self.blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
                
        bindData()
    }
    
    public convenience init(presentedViewController: UIViewController,
                            presentingViewController: UIViewController?,
                            dismissAction: @escaping Closure.Void) {
        self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.dismissAction = dismissAction
    }
    
    public override func presentationTransitionWillBegin() {
        blurEffectView.alpha = .zero
        containerView?.addSubview(blurEffectView)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.blurEffectView.alpha = 0.85
        }, completion: { _ in })
    }
  
    public override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.blurEffectView.alpha = .zero
        }, completion: { _ in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    public override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView?.bounds ?? .zero
    }
}

extension PresentationController {
    private func bindData() {
        blurEffectView.tapPublisher()
            .sink { [weak self] _ in
                self?.dismissAction?()
            }
            .store(in: &cancellables)
    }
}

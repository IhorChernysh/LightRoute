//
//  CustomTransitionViewController.swift
//  iOS Example
//
//  Created by v.a.prusakov on 21/04/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import UIKit

final class CustomTransitionViewController: UIViewController {
    
    enum Const {
        static let transitioningIdentifier = "card_detail"
    }
    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var moreView: UIView!
    private weak var frontCardView: FrontCardView!
    
    private var item: CardModel = .mock
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCard()
        self.setupGestures()
    }
    
    // MARK: - Setups
    private func setupCard() {
        self.cardView.applyShadow(color: Style.Colors.gray_93, radius: 10, opacity: 0.2, offset: CGSize(width: 0, height: 5))
        let frontCardView = FrontCardView.fromNib()
        frontCardView.configure(with: self.item)
        self.cardView.addSubview(frontCardView)
        frontCardView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.cardView = frontCardView
    }
    
    private func setupGestures() {
        let tapForCard = UITapGestureRecognizer(target: self, action: #selector(tapOnCard))
        self.cardView.addGestureRecognizer(tapForCard)
        
        let tapForMoreView = UITapGestureRecognizer(target: self, action: #selector(tapOnMore))
        self.moreView.addGestureRecognizer(tapForMoreView)
    }
    
    // MARK: - Actions
    @IBAction private func close() {
        self.dismiss(animated: true)
    }
    
    @objc private func tapOnCard() {
        try! self.forSegue(identifier: Const.transitioningIdentifier, to: CardDetailViewController.self).add(transitioningDelegate: CustomTransitioningDelegate()).then { $0.configure(with: self.item) }
    }
    
    @objc private func tapOnMore() {
        
    }
    
}

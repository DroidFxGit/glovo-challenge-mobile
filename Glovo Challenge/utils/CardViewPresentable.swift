//
//  CardViewPresentable.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/21/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import UIKit

protocol CardViewPresentable {
    var cardViewController: CardViewController { get }
}

extension CardViewPresentable where Self: UIViewController {
    func setupCardView() {
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - 100, width: self.view.bounds.width, height: 540)
        cardViewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 15
    }
}

//
//  AboutVC.swift
//  DeckOCardsGym
//
//  Created by Keith Taffs on 20/02/2021.
//

import UIKit

class AboutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.systemTeal.cgColor, UIColor.systemGreen.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.layer.insertSublayer(gradient, at: 0)
    }

    @IBAction func dismissAboutVC(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}

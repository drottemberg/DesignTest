//
//  ViewController.swift
//  DesignTest
//
//  Created by Sargis on 3/18/19.
//  Copyright © 2019 Sargis. All rights reserved.
//

import UIKit

class DesignViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: - Overriden Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highlight(text: "Charlotte Perriand’s “La maison au bord de l’eau", label: textLabel)
    }

    // MARK: - Private Methods
    
    private func highlight(text: String, label: UILabel) {
        let font = UIFont.boldSystemFont(ofSize: 32)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                          NSAttributedString.Key.backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                          NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let str = NSAttributedString(string: text.uppercased(), attributes: attributes)
        label.attributedText = str
    }

}

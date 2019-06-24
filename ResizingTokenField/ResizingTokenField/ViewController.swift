//
//  ViewController.swift
//  ResizingTokenField
//
//  Created by Tadej Razborsek on 19/06/2019.
//  Copyright © 2019 Tadej Razborsek. All rights reserved.
//

import UIKit

class Token: ResizingTokenFieldToken, Equatable {
    
    static func == (lhs: Token, rhs: Token) -> Bool {
        return lhs.title == rhs.title
    }
    
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tokenField: ResizingTokenField!
    @IBOutlet weak var animationSwitch: UISwitch!
    
    private lazy var titles: [String] = {
        "Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit".components(separatedBy: " ")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tokens: [Token] = [
            Token(title: "Lorem"),
            Token(title: "Ipsum"),
            Token(title: "Dolor")
        ]
        
        tokenField.append(tokens: tokens)
    }
    
    // MARK: - IB actions
    
    @IBAction func didTapAddTokenButton(_ sender: UIButton) {
        tokenField.append(tokens: [Token(title: getRandomTitle())], animated: animationSwitch.isOn, completion: nil)
    }
    
    @IBAction func didTapAddMultipleTokensButton(_ sender: UIButton) {
        var tokens: [Token] = []
        for _ in 0...(Int(arc4random_uniform(5))) {
            tokens.append(Token(title: getRandomTitle()))
        }

        tokenField.append(tokens: tokens, animated: animationSwitch.isOn, completion: nil)
    }
    
    // MARK: - Rotation
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tokenField.handleOrientationChange()
    }
    
    // MARK: - Helpers
    
    private func getRandomTitle() -> String {
        return titles[Int(arc4random_uniform(UInt32(titles.count)))]
    }
    
}


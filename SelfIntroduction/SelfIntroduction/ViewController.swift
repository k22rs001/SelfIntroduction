//
//  ViewController.swift
//  SelfIntroduction
//
//  Created by Takayuki Aoyagi   on 2024/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        helloLabel.text = "こんにちは"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        
    }
    
}


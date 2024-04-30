//
//  ViewController.swift
//  SelfIntroduction
//
//  Created by Takayuki Aoyagi   on 2024/04/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        helloLabel.text = "こんにちは"
    }
    
    @IBAction func weatherButtonTapped(_ sender: UIButton) {
        let view = UIHostingController(rootView: WeatherView())
        self.navigationController?.pushViewController(view, animated: true)
//        view.modalPresentationStyle = .fullScreen
//        self.present(view, animated: true)
    }

}


//
//  CounterViewController.swift
//  SelfIntroduction
//
//  Created by Takayuki Aoyagi   on 2024/04/25.
//

import UIKit

class CounterViewController: UIViewController {
    
   
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel! {
        didSet {
            correctLabel.isHidden = true
        }
    }
    var counterNumber = 0
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        counterNumber += 1
        countLabel.text = "\(counterNumber)"
        if counterNumber == 20 {
            correctLabel.isHidden = false
        } else {
            correctLabel.isHidden = true
        }
    }
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        counterNumber -= 1
        countLabel.text = "\(counterNumber)"
        if counterNumber == 20 {
            correctLabel.isHidden = false
        } else {
            correctLabel.isHidden = true
        }
    }
}

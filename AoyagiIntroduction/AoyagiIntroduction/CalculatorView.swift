//
//  CalculatorView.swift
//  AoyagiIntroduction
//
//  Created by Takayuki Aoyagi   on 2024/05/05.
//

import UIKit

class CalculatorView: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    private var numberOnScreen: Int = 0
    private var previousNumber: Int = 0
    private var performingMath = false
    private var operation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        label.text = ""
    }
    
    //各ボタンが押された時の処理
    @IBAction func showNumber(_ sender: UIButton) {
        if performingMath == true {
            label.text = String(sender.tag - 1)
            numberOnScreen = Int(label.text!)!
            performingMath = false
        }else {
            label.text = label.text! + String(sender.tag - 1)
            numberOnScreen = Int(label.text!)!
        }
        
    }
    
    //各計算ボタンが押された時の処理
    @IBAction func calcAction(_ sender: UIButton) {
        if label.text != "" && sender.tag != 11 && sender.tag != 16 {
            previousNumber = Int(label.text!)!
            //labelに表示する文字を決める
            switch(sender.tag) {
            case 12:
                label.text = "÷"
            case 13:
                label.text = "×"
            case 14:
                label.text = "ー"
            case 15:
                label.text = "＋"
            default:
                break
            }
            operation = sender.tag
            performingMath = true
        }else if sender.tag == 16 {
            //計算ボタン(=)が押された時の処理
            switch(operation) {
            case 12:
                label.text = String(previousNumber / numberOnScreen)
            case 13:
                label.text = String(previousNumber * numberOnScreen)
            case 14:
                label.text = String(previousNumber - numberOnScreen)
            case 15:
                label.text = String(previousNumber + numberOnScreen)
            default:
                break
            }
        }else if sender.tag == 11 {
            //(C)が押されたら全てを初期値に戻す
            label.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
    }
    
}

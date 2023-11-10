//
//  ViewController.swift
//  Kalculator
//
//  Created by JOGENDRA on 18/05/17.
//  Copyright © 2017 Jogendra Singh. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var c: UIButton!
    private var calculator:Calculator?
    @IBOutlet weak var resultScreen: UILabel!
    
    @IBAction func inputDigit(_ sender: Any) {
        if let button = sender as? UIButton{
            do{
                if let output = try calculator?.inputDigit(button.currentTitle!){
                    display(result: output)
                }
            }catch{
                display(result: "Err")
            }
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        calculator?.clear()
        display(result: "0")
    }
    
    private func display(result:String){
        resultScreen.text = result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculator = Calculator()
    }
    
}

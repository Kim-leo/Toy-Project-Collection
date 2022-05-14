//
//  ViewController.swift
//  toyProject_lectureTime
//
//  Created by 김승현 on 2022/05/12.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var totalTime: UITextField!
    @IBOutlet weak var howFast: UITextField!
    @IBOutlet weak var savedTotalTime: UILabel!
    @IBOutlet weak var howMuchSaved: UILabel!
    @IBOutlet weak var btnCaculation: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBtnAttributes()
        print("hello test")
    }
    
    func setBtnAttributes() {
        btnCaculation.clipsToBounds = true
        btnCaculation.layer.cornerRadius = 10
        btnCaculation.backgroundColor = .systemGray5
        btnCaculation.setTitleColor(.blue, for: .normal)
    }

    @IBAction func btnCalculation(_ sender: UIButton) {
        
        if totalTime.text!.isEmpty || howFast.text!.isEmpty {
            
            let ac = UIAlertController(title: "Opps!", message: "강의시간과 배속을 입력하세요!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "확인~", style: .default)
            
            ac.addAction(alertAction)
            self.present(ac, animated: false)
            
        } else if totalTime.text!.allSatisfy({ $0.isNumber }) && howFast.text!.allSatisfy({ $0.isNumber }) {
            
            let totalTime = Double(totalTime.text!)
            let howFast = Double(howFast.text!)
            
            let savedTimeValue = String(format: "%.1f", (totalTime! / howFast!))
            savedTotalTime.text = "단축된 강의시간은 \(savedTimeValue)분 입니다."
            
            let howMuchSavedValue = String(format: "%.1f", (totalTime! - Double(savedTimeValue)!))
            howMuchSaved.text = "절약한 시간은 \(howMuchSavedValue)분 입니다."
            
        } else {
            
            let ac = UIAlertController(title: "Opps!", message: "숫자만 입력하세요!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "확인~", style: .default)
            
            ac.addAction(alertAction)
            self.present(ac, animated: false)
            
        }
    }
}


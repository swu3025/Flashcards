//
//  ViewController.swift
//  Flashcards
//
//  Created by Samuel Wu on 2/20/21.
//  Copyright © 2021 Samuel Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
        btnOptionOne.layer.cornerRadius = 20.0
        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionThree.layer.cornerRadius = 20.0
        resetBtn.layer.cornerRadius = 20.0
        
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.1901910007, green: 0.8295448422, blue: 0.7747421861, alpha: 1)
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.1901910007, green: 0.8295448422, blue: 0.7747421861, alpha: 1)
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.1901910007, green: 0.8295448422, blue: 0.7747421861, alpha: 1)
        resetBtn.layer.borderWidth = 3.0
        resetBtn.layer.borderColor = #colorLiteral(red: 0.1901910007, green: 0.8295448422, blue: 0.7747421861, alpha: 1)
        
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = !frontLabel.isHidden
    }

    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        btnOptionTwo.setTitleColor(UIColor.white, for: .normal)
        btnOptionTwo.backgroundColor = #colorLiteral(red: 0.1901910007, green: 0.8295448422, blue: 0.7747421861, alpha: 1)
        frontLabel.isHidden = true
        btnOptionThree.isHidden = true
        btnOptionOne.isHidden = true
        resetBtn.isHidden = false
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String, extraAnswerTwo: String){
        frontLabel.text = question
        backLabel.text = answer
        
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(extraAnswerTwo, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue"{
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
            creationController.initialExtraAnswerOne = btnOptionOne.currentTitle
            creationController.initialExtraAnswerTwo = btnOptionThree.currentTitle
        }
    }
    
    @IBAction func didClickOnReset(_ sender: Any) {
        btnOptionTwo.backgroundColor = UIColor.white
        btnOptionTwo.setTitleColor(#colorLiteral(red: 0.1901910007, green: 0.8295448422, blue: 0.7747421861, alpha: 1), for: .normal)
        btnOptionTwo.backgroundColor = UIColor.white
        frontLabel.isHidden = false
        btnOptionThree.isHidden = false
        btnOptionOne.isHidden = false
        resetBtn.isHidden = true
    }
    
}


//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Samuel Wu on 3/6/21.
//  Copyright © 2021 Samuel Wu. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!

    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var extraAnswerOneTextField: UITextField!
    @IBOutlet weak var extraAnswerTwoTextField: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    var initialExtraAnswerOne: String?
    var initialExtraAnswerTwo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        extraAnswerOneTextField.text = initialExtraAnswerOne
        extraAnswerTwoTextField.text = initialExtraAnswerTwo
    }

    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        var extraAnswerOneText = extraAnswerOneTextField.text
        var extraAnswerTwoText = extraAnswerTwoTextField.text
        
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty {
            let alert = UIAlertController(title: "Missing text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
        }
        else{
            
            if extraAnswerOneText == nil || extraAnswerOneText!.isEmpty {
                extraAnswerOneText = "Empty"
            }
            
            if extraAnswerTwoText == nil ||
                extraAnswerTwoText!.isEmpty {
                extraAnswerTwoText = "Empty"
            }
        
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: extraAnswerOneText!, extraAnswerTwo: extraAnswerTwoText!)
            
            dismiss(animated: true)
        }
    }
}

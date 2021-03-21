//
//  ViewController.swift
//  Flashcards
//
//  Created by Samuel Wu on 2/20/21.
//  Copyright © 2021 Samuel Wu. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var extraOne: String
    var extraTwo: String
}

class ViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
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
        
        readSavedFlashcard()
        
        if flashcards.count == 0{
            updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia", extraAnswerOne: "Rio de Janeiro", extraAnswerTwo: "Sao Paulo", isExisting: false )
        } else{
            updateLabels()
            updateNextPrevButtons()
        }
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
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String, extraAnswerTwo: String, isExisting: Bool){
        if flashcards.count == 0 {
            backLabel.backgroundColor = #colorLiteral(red: 0.1901910007, green: 0.8295448422, blue: 0.7747421861, alpha: 1)
            backLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            backLabel.font = backLabel.font.withSize(30)
            xButton.isHidden = false
            editButton.isHidden = false
            btnOptionOne.isHidden = false
            btnOptionTwo.isHidden = false
            btnOptionThree.isHidden = false
        }
        let flashcard = Flashcard(question: question, answer: answer, extraOne: extraAnswerOne, extraTwo: extraAnswerTwo)
        
        if isExisting {
            flashcards[currentIndex] = flashcard
        }else{
            flashcards.append(flashcard)
            currentIndex = flashcards.count - 1
        }
        updateNextPrevButtons()
        updateLabels()
        
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(extraAnswerTwo, for: .normal)
        
        saveAllFlashcardsToDisk()
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
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    func updateNextPrevButtons(){
        if currentIndex == flashcards.count-1 {
            nextButton.isEnabled = false
        } else{
            nextButton.isEnabled = true
        }
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else{
            prevButton.isEnabled = true
        }
        
        if currentIndex < 0 {
            nextButton.isEnabled = false
            prevButton.isEnabled = false
        }
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
        btnOptionOne.setTitle(currentFlashcard.extraOne, for: .normal)
        btnOptionTwo.setTitle(currentFlashcard.answer, for: .normal)
        btnOptionThree.setTitle(currentFlashcard.extraTwo, for: .normal)
    }
    
    func saveAllFlashcardsToDisk() {
        let dictionaryArray = flashcards.map { (card) -> [String:String] in return ["question" : card.question, "answer": card.answer, "extraOne": card.extraOne, "extraTwo": card.extraTwo]

        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
    }
    
    func readSavedFlashcard(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]]{
            let savedCards = dictionaryArray.compactMap{ dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraOne: dictionary["extraOne"] ?? "", extraTwo: dictionary["extraTwo"] ?? "")}
            flashcards.append(contentsOf: savedCards)
        }
        
    }
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){ action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        updateNextPrevButtons()
        if !resetBtn.isHidden {
            didClickOnReset(Any.self)
        }
        if currentIndex == -1 {
            emptyFlashCard()
        } else{
            updateLabels()
        }
        saveAllFlashcardsToDisk()
    }
    
    func emptyFlashCard(){
        frontLabel.text = "Press + to create a new Flashcard"
        backLabel.text = "Press + to create a new Flashcard"
        backLabel.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        backLabel.font = backLabel.font.withSize(22)
        xButton.isHidden = true
        editButton.isHidden = true
        btnOptionOne.isHidden = true
        btnOptionTwo.isHidden = true
        btnOptionThree.isHidden = true
    }
}


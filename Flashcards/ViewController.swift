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
    
    var correctAnswerButton: UIButton!
    var flashcards = [Flashcard]()
    var currentIndex = -1 //change back to 0
    
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
//            updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia", extraAnswerOne: "Rio de Janeiro", extraAnswerTwo: "Sao Paulo", isExisting: false )
            emptyFlashCard()
        } else{
            currentIndex = flashcards.count - 1
            updateLabels() // add updateNext below this
        }
        updateNextPrevButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //First start with the flashcard invisible and slightly smaller in size
        btnOptionOne.alpha=0
        btnOptionTwo.alpha=0
        btnOptionThree.alpha=0
        resetBtn.alpha = 0
        btnOptionOne.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        btnOptionTwo.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        btnOptionThree.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        resetBtn.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        card.alpha = 0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        //Animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: []) {
            self.card.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
            self.btnOptionOne.alpha = 1.0
            self.btnOptionOne.transform = CGAffineTransform.identity
            self.btnOptionTwo.alpha = 1.0
            self.btnOptionTwo.transform = CGAffineTransform.identity
            self.btnOptionThree.alpha = 1.0
            self.btnOptionThree.transform = CGAffineTransform.identity
            self.resetBtn.alpha = 1.0
            self.resetBtn.transform = CGAffineTransform.identity
        }

    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.frontLabel.isHidden = !self.frontLabel.isHidden
        })
    }

    @IBAction func didTapOptionOne(_ sender: Any) {
        if btnOptionOne == correctAnswerButton {
            flipFlashcard()
            btnOptionOne.setTitleColor(UIColor.white, for: .normal)
            btnOptionOne.backgroundColor = #colorLiteral(red: 0.1901910007, green: 0.8295448422, blue: 0.7747421861, alpha: 1)
            frontLabel.isHidden = true
            btnOptionThree.isHidden = true
            btnOptionTwo.isHidden = true
            resetBtn.isHidden = false
        } else {
            btnOptionOne.isHidden = true
        }
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        if btnOptionTwo == correctAnswerButton {
            flipFlashcard()
            btnOptionTwo.setTitleColor(UIColor.white, for: .normal)
            btnOptionTwo.backgroundColor = #colorLiteral(red: 0.1901910007, green: 0.8295448422, blue: 0.7747421861, alpha: 1)
            frontLabel.isHidden = true
            btnOptionThree.isHidden = true
            btnOptionOne.isHidden = true
            resetBtn.isHidden = false
        } else {
            btnOptionTwo.isHidden = true
        }
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        if btnOptionThree == correctAnswerButton {
            flipFlashcard()
            btnOptionThree.setTitleColor(UIColor.white, for: .normal)
            btnOptionThree.backgroundColor = #colorLiteral(red: 0.1901910007, green: 0.8295448422, blue: 0.7747421861, alpha: 1)
            frontLabel.isHidden = true
            btnOptionTwo.isHidden = true
            btnOptionOne.isHidden = true
            resetBtn.isHidden = false
        } else {
            btnOptionThree.isHidden = true
        }
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
        correctAnswerButton.backgroundColor = UIColor.white
        correctAnswerButton.setTitleColor(#colorLiteral(red: 0.1901910007, green: 0.8295448422, blue: 0.7747421861, alpha: 1), for: .normal)
        correctAnswerButton.backgroundColor = UIColor.white
        flipFlashcard()
        btnOptionThree.isHidden = false
        btnOptionOne.isHidden = false
        btnOptionTwo.isHidden = false
        resetBtn.isHidden = true
    }
    
    func animateCardOutNext(){
        UIView.animate(withDuration: 0.2) {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        } completion: { finished in
            self.updateLabels()
            self.animateCardInNext()
        }
    }
    
    func animateCardInNext(){
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration: 0.2) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func animateCardOutPrev(){
        UIView.animate(withDuration: 0.2) {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        } completion: { finished in
            self.updateLabels()
            self.animateCardInPrev()
        }
    }
    
    func animateCardInPrev(){
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        UIView.animate(withDuration: 0.2) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
        animateCardOutNext()
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
        animateCardOutPrev()
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
        
        let buttons = [btnOptionOne, btnOptionTwo, btnOptionThree].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.extraOne, currentFlashcard.extraTwo].shuffled()
        
        for(button, answer) in zip(buttons, answers){
            //set the title of this random button, with a random answer
            button?.setTitle(answer, for: .normal)
            
            //if this is the correct answer save the button
            if answer == currentFlashcard.answer{
                correctAnswerButton = button
            }
        }
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


//
//  ViewController.swift
//  Flashcards
//
//  Created by Samuel Wu on 2/20/21.
//  Copyright © 2021 Samuel Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        backLabel.isHidden = true
    }
    
}


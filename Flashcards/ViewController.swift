//
//  ViewController.swift
//  Flashcards
//
//  Created by Stanley Araki on 2/20/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!

    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        //Rounded corners
        card.layer.cornerRadius = 20.0 //how round we want them
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
        //Button Styling
        btnOptionOne.layer.cornerRadius = 20.0
        btnOptionOne.clipsToBounds = true
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.7014790177, green: 0.8573616147, blue: 1, alpha: 1)
        
        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionTwo.clipsToBounds = true
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.7014790177, green: 0.8573616147, blue: 1, alpha: 1)
        
        btnOptionThree.layer.cornerRadius = 20.0
        btnOptionThree.clipsToBounds = true
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.7014790177, green: 0.8573616147, blue: 1, alpha: 1)
        
    }
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    @IBAction func didTapOptionTwo(_ sender: Any) {
        //for now option two is always true
        if (frontLabel.isHidden){
            frontLabel.isHidden = false;
            return
        }
        frontLabel.isHidden = true
    }
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden){
            frontLabel.isHidden = false;
            return
        }
        frontLabel.isHidden = true
    }
    func updateFlashcard(question: String, answer: String, extra1: String, extra2: String, extra3: String){
        frontLabel.text = question
        backLabel.text = answer
        
        btnOptionOne.setTitle(extra1, for: .normal)
        btnOptionTwo.setTitle(extra2, for: .normal)
        btnOptionThree.setTitle(extra3, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // We knkow the dstination fo the segue is the Navigation COntroller
        let navigationController = segue.destination as! UINavigationController
        // We know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // We set the flashcardsController property to self
        creationController.flashcardsController = self
        
        if (segue.identifier == "EditSegue"){
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
    }
    
    

}


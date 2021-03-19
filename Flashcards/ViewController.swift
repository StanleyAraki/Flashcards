//
//  ViewController.swift
//  Flashcards
//
//  Created by Stanley Araki on 2/20/21.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
    var extraAnswer1: String
    var extraAnswer2: String
    var extraAnswer3: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
 
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Read saved flashcards
        readSavedFlashcards()
        
        //Load in initial if needed
        if (flashcards.count == 0){
            updateFlashcard(question: "What's the capital of Japan?", answer: "Tokyo", extra1: "", extra2: "", extra3: "", isExisting: false)
        } else {
            updateLabels()
            updateNextPrevButtons()
        }

        
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
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
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
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }

    func deleteCurrentFlashcard(){
        // Delete current
        flashcards.remove(at: currentIndex)
        //edge case: card removed was only card left
        if (currentIndex == 0){
            currentIndex = flashcards.count
        }
        // edge case: last card was deleted
        else if (currentIndex > flashcards.count-1){
            currentIndex = flashcards.count-1
        }
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        // Decrement Index
        currentIndex = currentIndex - 1
        // Update Labels
        updateLabels()
        // Update Buttons
        updateNextPrevButtons()
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        //Increment index
        currentIndex = currentIndex + 1
        
        // Update Labels
        updateLabels()
        
        // Update butons
        updateNextPrevButtons()
    }
    func updateFlashcard(question: String, answer: String, extra1: String, extra2: String, extra3: String, isExisting: Bool){
        
        let flashcard = Flashcard(question: question, answer: answer, extraAnswer1: extra1, extraAnswer2: extra2, extraAnswer3: extra3)
        
        if isExisting{
            // Replace existing flashcard
            flashcards[currentIndex] = flashcard
        } else {

            // Adding flashcard in the flashcards array
            flashcards.append(flashcard)
            
            // Logging to the console
            print("Added new flashcard")
            print("we now have \(flashcards.count) flashcards")
            
            // Update current index
            currentIndex = flashcards.count-1 //b/c length-1
            print("Current index is \(currentIndex)")
            
            // Update buttons
            updateNextPrevButtons()
            
            btnOptionOne.setTitle(extra1, for: .normal)
            btnOptionTwo.setTitle(extra2, for: .normal)
            btnOptionThree.setTitle(extra3, for: .normal)
            
            // Update labels
            updateLabels()
            
            // Save flashcards to disk
            saveAllFlashcardsToDisk()
        }
    }
    
    func updateNextPrevButtons(){
        // Disable next button if at end
        if currentIndex == flashcards.count-1{
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        // Disable prev button if at first
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func saveAllFlashcardsToDisk(){
        // From flashcards array to dictionary array
        let dictionaryArray = flashcards.map{(card) -> [String: String] in return ["question": card.question, "answer": card.answer, "extraAnswer1": card.extraAnswer1, "extraAnswer2": card.extraAnswer2, "extraAnswer3": card.extraAnswer3];
        }
        
        // Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // Log
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        // Read dictionary array from disk, if any
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            // Here we know dictionary array exists
            let savedCards = dictionaryArray.map{ dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswer1: dictionary["extraAnswer1"] ?? "No Answer", extraAnswer2: dictionary["extraAnswer2"] ?? "No Answer", extraAnswer3: dictionary["extraAnswer3"] ?? "No Answer")
            }
            //Put all cards in Flashcard array
            flashcards.append(contentsOf: savedCards)
        }
        
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


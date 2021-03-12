//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Stanley Araki on 3/6/21.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var extraAnswer1: UITextField!
    @IBOutlet weak var extraAnswer2: UITextField!
    @IBOutlet weak var extraAnswer3: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    

    @IBAction func didtapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        // Get the text in the question text field
        let questionText = questionTextField.text
        // Get the text in the answer text field
        let answerText = answerTextField.text
        
        let extraOne = extraAnswer1.text ?? "No answer"
        let extraTwo = extraAnswer2.text ?? "No answer"
        let extraThree = extraAnswer3.text ?? "No answer"
        
        // Check if empty
        if (questionText == nil || answerText == nil ||
                questionText!.isEmpty || answerText!.isEmpty){
            // Show error
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer", preferredStyle: UIAlertController.Style .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
        
        // Call the function to update the flashcard
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extra1: extraOne, extra2: extraTwo, extra3: extraThree)
        // Dismiss
        dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

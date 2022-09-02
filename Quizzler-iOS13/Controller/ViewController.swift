//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var resultText: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    var quizBrain = QuizBrain()
    
    var results = [0, 0]
    
    
    override func viewDidLoad() {
        resetButton.isHidden = true
        progressBar.progress = Float(quizBrain.questionNumber) / Float(quizBrain.quiz.count)
        super.viewDidLoad()
        resultText.text = ""
        updateUI()
    }
    
    func updateUI() {
        progressBar.progress = quizBrain.getProgress()

        if quizBrain.questionNumber == quizBrain.quiz.count {
            trueButton.isEnabled = false
            falseButton.isEnabled = false
            resetButton.isHidden = false
            questionLabel.text = "Quiz completed"
            resultText.text = "You got \(results[0]) correct and \(results[1]) wrong."
            if results[0] >= results[1] {
                resultText.textColor = UIColor.green
            } else {
                resultText.textColor = UIColor.red
            }
        } else {
            questionLabel.text = quizBrain.getQuestionText()
        }
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {

        let userAnswer = sender.currentTitle!
        let checker = quizBrain.checkAnswer(userAnswer)
        
        if checker {
            resultText.textColor = UIColor.green
            results[0] += 1
            resultText.text = "Correct"
        } else {
            resultText.textColor = UIColor.red
            results[1] += 1
            resultText.text = "Wrong"
        }
        
        quizBrain.nextQuestion()
        updateUI()
    }
    
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        results[0] = 0
        results[1] = 0
        resultText.text = ""
        trueButton.isEnabled = true
        falseButton.isEnabled = true
        quizBrain.questionNumber = 0
        resetButton.isHidden = true
        progressBar.progress = Float(quizBrain.questionNumber) / Float(quizBrain.quiz.count)
        updateUI()
    }
}

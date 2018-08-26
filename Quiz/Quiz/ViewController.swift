//
//  ViewController.swift
//  Quiz
//
//  Created by Shawn Aten on 8/11/18.
//  Copyright © 2018 Shawn Aten. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = [
        "What is 7+7?",
        "What is the capital of Vermont?",
        "What is cognac made from?"
    ]
    let answers: [String] = [
        "14",
        "Montpelier",
        "Grapes"
    ]
    var currentQuestionIndex: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nextQuestionLabel.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
        nextQuestionLabelCenterXConstraint.isActive = false
        
        let questionLayoutGuide = UILayoutGuide()
        view.addLayoutGuide(questionLayoutGuide)
        questionLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nextQuestionLabel.centerXAnchor.constraint(equalTo: questionLayoutGuide.leadingAnchor).isActive = true
        currentQuestionLabel.centerXAnchor.constraint(equalTo: questionLayoutGuide.trailingAnchor).isActive = true
    }
    
    @IBAction func showNextQuestion(_ sender: UIButton) {
        
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    func animateLabelTransitions() {
        
        view.layoutIfNeeded()
        
        let screenWidth = view.frame.width
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.75,
            initialSpringVelocity: 0,
            options: [.curveLinear],
            animations: {
                self.currentQuestionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                self.currentQuestionLabel.text = self.nextQuestionLabel.text
                self.currentQuestionLabelCenterXConstraint.constant = 0
                self.currentQuestionLabel.alpha = 1
                self.nextQuestionLabel.alpha = 0
                self.view.layoutIfNeeded()
            }
        )
    }
}

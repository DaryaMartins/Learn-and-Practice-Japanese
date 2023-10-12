//
//  KanaTestingViewController.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 03.08.2023.
//

import UIKit
import SnapKit

class KanaTestingViewController: UIViewController {
    private var viewModel = KanaTestingViewModel()
    private var correctAnswer = ""
    private var lastAnswer = ""
    
    private var characterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "KleeOne-SemiBold", size: 70)
        label.textColor = .black
        return label
    }()
    
    private var firstAnswerButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    private var secondAnswerButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    private var answersButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        stack.contentMode = .scaleToFill
        return stack
    }()
    
    private var firstAnswerBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 60)
        button.backgroundColor = UIColor.accentColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    private var secondAnswerBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 60)
        button.backgroundColor = UIColor.accentColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    private var thirdAnswerBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 60)
        button.backgroundColor = UIColor.accentColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    private var forthAnswerBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 60)
        button.backgroundColor = UIColor.accentColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    private var lastAnswerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "KleeOne-SemiBold", size: 35)
        label.textColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        viewModel.fetchKana()
        setupViews()
        setupLayout()
        updateViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(characterLabel)
        view.addSubview(answersButtonStack)
        view.addSubview(lastAnswerLabel)
        
        firstAnswerButtonStack.addArrangedSubview(firstAnswerBtn)
        firstAnswerButtonStack.addArrangedSubview(secondAnswerBtn)
        secondAnswerButtonStack.addArrangedSubview(thirdAnswerBtn)
        secondAnswerButtonStack.addArrangedSubview(forthAnswerBtn)
        answersButtonStack.addArrangedSubview(firstAnswerButtonStack)
        answersButtonStack.addArrangedSubview(secondAnswerButtonStack)
    }
    
    private func setupLayout() {
        characterLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().inset(50)
            $0.centerX.equalToSuperview()
        }
        
        firstAnswerButtonStack.snp.makeConstraints {
            $0.height.equalTo(200)
        }

        secondAnswerButtonStack.snp.makeConstraints {
            $0.height.equalTo(200)
        }

        answersButtonStack.snp.makeConstraints {
            $0.top.equalTo(characterLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        lastAnswerLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(answersButtonStack.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(230)
            $0.bottom.greaterThanOrEqualToSuperview().inset(50)
        }
    }
    
    @objc private func answerButtonTapped(_ sender: UIButton) {
        var isCorrect = true
        if correctAnswer == sender.titleLabel?.text {
            sender.backgroundColor = UIColor.correctAnswerColor
        } else {
            sender.backgroundColor = UIColor.wrongAnswerColor
            isCorrect = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if isCorrect {
                self.lastAnswerLabel.backgroundColor = UIColor.correctAnswerColor
            } else {
                self.lastAnswerLabel.backgroundColor = UIColor.wrongAnswerColor
            }
            self.lastAnswerLabel.text = self.lastAnswer
            sender.backgroundColor = UIColor.accentColor
            self.updateViews()
        }
    }
    
    private func updateViews() {
        guard let options = viewModel.getKanaValue() else { return }
        characterLabel.text = options.kanaUnderTest
        correctAnswer = options.correctAnswer
        firstAnswerBtn.setTitle(options.optionOne, for: .normal)
        secondAnswerBtn.setTitle(options.optionTwo, for: .normal)
        thirdAnswerBtn.setTitle(options.optionThree, for: .normal)
        forthAnswerBtn.setTitle(options.optionFour, for: .normal)
        lastAnswer = options.answerString
    }
}

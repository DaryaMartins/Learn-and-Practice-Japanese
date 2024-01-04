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
    
    private var topOptionsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    private var bottomOptionsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    private var optionsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    private var firstOption = UIButton()
    private var secondOption = UIButton()
    private var thirdOption = UIButton()
    private var forthOption = UIButton()
    
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
}

// MARK: Setup

private extension KanaTestingViewController {
    func setupViews() {
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(characterLabel)
        view.addSubview(lastAnswerLabel)
        view.addSubview(optionsStack)
        
        updateButtonStyle(button: firstOption)
        updateButtonStyle(button: secondOption)
        updateButtonStyle(button: thirdOption)
        updateButtonStyle(button: forthOption)
        
        topOptionsStack.addArrangedSubview(firstOption)
        topOptionsStack.addArrangedSubview(secondOption)
        bottomOptionsStack.addArrangedSubview(thirdOption)
        bottomOptionsStack.addArrangedSubview(forthOption)
        optionsStack.addArrangedSubview(topOptionsStack)
        optionsStack.addArrangedSubview(bottomOptionsStack)
        
    }
    
    func setupLayout() {
        characterLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }
        
        topOptionsStack.snp.makeConstraints {
            $0.height.equalTo(200)
        }

        bottomOptionsStack.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        optionsStack.snp.makeConstraints {
            $0.top.equalTo(characterLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        lastAnswerLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(optionsStack.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(230)
            $0.bottom.greaterThanOrEqualToSuperview().inset(50)
        }
    }
    
    func updateButtonStyle(button: UIButton) {
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 60)
        button.backgroundColor = UIColor.accentColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
    }
    
    func updateViews() {
        guard let options = viewModel.getKanaValue() else { return }
        characterLabel.text = options.kanaUnderTest
        correctAnswer = options.correctAnswer
        firstOption.setTitle(options.optionOne, for: .normal)
        secondOption.setTitle(options.optionTwo, for: .normal)
        thirdOption.setTitle(options.optionThree, for: .normal)
        forthOption.setTitle(options.optionFour, for: .normal)
        lastAnswer = options.answerString
    }
    
    @objc func answerButtonTapped(_ sender: UIButton) {
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
}

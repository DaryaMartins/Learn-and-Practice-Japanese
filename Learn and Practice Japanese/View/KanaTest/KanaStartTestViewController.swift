//
//  KanaStartTestViewController.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 02.08.2023.
//

import UIKit
import SnapKit

class KanaStartTestViewController: UIViewController {
    lazy private var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Test your knowledge"
        label.font = UIFont(name: "KleeOne-SemiBold", size: 20)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    lazy private var quizKanaButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.accentColor
        button.layer.cornerRadius = 20
        button.setTitle("Kana Quiz", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy private var quizKanjiButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.accentColor
        button.layer.cornerRadius = 20
        button.setTitle("漢字 Quiz", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy private var drawDescriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Test your drawing skills"
        label.font = UIFont(name: "KleeOne-SemiBold", size: 20)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    lazy private var drawKanaButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.accentColor
        button.layer.cornerRadius = 20
        button.setTitle("Kana Draw", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy private var drawKanjiButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.accentColor
        button.layer.cornerRadius = 20
        button.setTitle("漢字 Draw", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    
    private var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        stack.contentMode = .scaleToFill
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(buttonStack)
        
        buttonStack.addArrangedSubview(descriptionLabel)
        buttonStack.addArrangedSubview(quizKanaButton)
        buttonStack.addArrangedSubview(quizKanjiButton)
        
        buttonStack.addArrangedSubview(drawDescriptionLabel)
        buttonStack.addArrangedSubview(drawKanaButton)
        buttonStack.addArrangedSubview(drawKanjiButton)
        
        title = "Quiz"

    }
    
    private func setupLayout() {
        buttonStack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        quizKanaButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(100)
        }

        drawKanaButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(100)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        var vc: UIViewController? = nil
        
        switch sender.titleLabel?.text {
        case "Kana Quiz":
            vc = KanaTestingViewController()
        case "漢字 Quiz":
            print("Go test kanji")
        case "Kana Draw":
            vc = KanaTestingDrawingViewController()
        case "漢字 Draw":
            vc = KanjiTestingDrawingViewController()
        case .none, .some(_):
            print("Something wrong")
        }
        
        guard let vc = vc else { return }
        
        self.navigationController?.pushViewController(vc, animated:
        true)
    }
}

//
//  WordInfoViewController.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 07.09.2023.
//

import UIKit

class WordInfoViewController: UIViewController {
    
    private let buttonStack: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let plainButton: UIButton = {
        var button = UIButton()
        button.setTitle("Plain", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 20)
        button.backgroundColor = UIColor(hex: "#a1ddf7ff")
        //button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let politeButton: UIButton = {
        var button = UIButton()
        button.setTitle("Polite", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 20)
        button.backgroundColor = UIColor(hex: "#a1ddf7ff")
        //button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

        setupViews()
        setupConstraints()
    }
}

// MARK: Setup

private extension WordInfoViewController {
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(buttonStack)
        
        buttonStack.addArrangedSubview(plainButton)
        buttonStack.addArrangedSubview(politeButton)
        
    }
    
    private func setupConstraints() {
        buttonStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

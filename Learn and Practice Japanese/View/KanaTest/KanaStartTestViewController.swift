//
//  KanaStartTestViewController.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 02.08.2023.
//

import UIKit
import SnapKit

class KanaStartTestViewController: UIViewController {
    lazy private var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.accentColor
        button.layer.cornerRadius = 20
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy private var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Test your kana knowledge"
        label.font = UIFont(name: "KleeOne-SemiBold", size: 20)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    lazy private var startDrawButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.accentColor
        button.layer.cornerRadius = 20
        button.setTitle("Draw", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy private var drawDescriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Test your kana drawing"
        label.font = UIFont(name: "KleeOne-SemiBold", size: 20)
        label.textAlignment = .center
        label.textColor = .gray
        return label
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
        buttonStack.addArrangedSubview(startButton)
        
        buttonStack.addArrangedSubview(drawDescriptionLabel)
        buttonStack.addArrangedSubview(startDrawButton)
        
        title = "Quiz"

    }
    
    private func setupLayout() {
        buttonStack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        startButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(100)
        }

        startDrawButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(100)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let vc = sender.titleLabel?.text == "Start" ? KanaTestingViewController() : KanaTestingDrawingViewController()
        
        self.navigationController?.pushViewController(vc, animated:
        true)
    }
}

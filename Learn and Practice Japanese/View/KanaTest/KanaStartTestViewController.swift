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
        button.backgroundColor = UIColor(hex: "#a1ddf7ff")
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
        button.backgroundColor = UIColor(hex: "#a1ddf7ff")
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
        printSystemFonts()
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
        
//        descriptionLabel.snp.makeConstraints {
//            $0.top.equalTo(startButton.snp.bottom).offset(15)
//            $0.centerX.equalTo(startButton.snp.centerX)
//        }
        
        startDrawButton.snp.makeConstraints {
            //$0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.height.equalTo(50)
            $0.width.equalTo(100)
            //$0.center.equalToSuperview()
        }
        
//        drawDescriptionLabel.snp.makeConstraints {
//            $0.top.equalTo(startButton.snp.bottom).offset(15)
//            $0.centerX.equalTo(startButton.snp.centerX)
//        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let vc = sender.titleLabel?.text == "Start" ? KanaTestingViewController() : KanaTestingDrawingViewController()
        
        self.navigationController?.pushViewController(vc, animated:
        true)
    }
    
    public func printSystemFonts() {
        // Use this identifier to filter out the system fonts in the logs.
        let identifier: String = "[SYSTEM FONTS]"
        // Here's the functionality that prints all the system fonts.
        for family in UIFont.familyNames as [String] {
            debugPrint("\(identifier) FONT FAMILY :  \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                debugPrint("\(identifier) FONT NAME :  \(name)")
            }
        }
    }
}

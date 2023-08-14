//
//  KanaTestingDrawingViewController.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 09.08.2023.
//

import Foundation
import UIKit
import PencilKit

class KanaTestingDrawingViewController: UIViewController {
    private var viewModel = KanaTestingViewModel()
    private var katakanaLabelIsHidden = true
    private var hiraganaLabelIsHidden = true
    
    private var canvasView = PKCanvasView()
    private var characterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "KleeOne-SemiBold", size: 50)
        label.textColor = .black
        return label
    }()
    
    private var hiraganaLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        // todo: fix font size
        label.font = UIFont(name: "KleeOne-SemiBold", size: 300)
        label.textColor = .black
        label.layer.opacity = 0.15
        return label
    }()
    
    private var katakanaLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        // todo: fix font size
        label.font = UIFont(name: "KleeOne-SemiBold", size: 300)
        label.textColor = .black
        label.layer.opacity = 0.15
        return label
    }()
    
    private var drawingView: UIView = {
        var view = UIView()
        view.sizeToFit()
        view.backgroundColor = .white
        return view
    }()
    
    private var horizontalLine: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(hex: "#b8d2deff")
        return view
    }()
    
    private var verticalLine: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(hex: "#b8d2deff")
        return view
    }()
    
    private var kanaButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    // todo: fix name and think "is it necessary?"
    private var otherButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    private var undoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#a1ddf7ff")
        button.layer.cornerRadius = 20
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private var katakanaButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#a1ddf7ff")
        button.layer.cornerRadius = 20
        button.setTitle("Katakana", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private var hiraganaButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#a1ddf7ff")
        button.layer.cornerRadius = 20
        button.setTitle("Hiragana", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private var clearButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#a1ddf7ff")
        button.layer.cornerRadius = 20
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#a1ddf7ff")
        button.layer.cornerRadius = 20
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        canvasView.delegate = self
        canvasView.drawing = PKDrawing()
        
        viewModel.fetchKana()
        setupViews()
        setupLayout()
        updateViews()
        setupCanvasView()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(hex: "#dbf4ffff")
        
        view.addSubview(characterLabel)
        view.addSubview(drawingView)
        view.addSubview(kanaButtonStack)
        view.addSubview(otherButtonStack)
        view.addSubview(stackView)
        view.addSubview(undoButton)
        
        drawingView.addSubview(hiraganaLabel)
        drawingView.addSubview(katakanaLabel)
        drawingView.addSubview(horizontalLine)
        drawingView.addSubview(verticalLine)
        drawingView.addSubview(canvasView)
        
        stackView.addArrangedSubview(kanaButtonStack)
        stackView.addArrangedSubview(otherButtonStack)
        
        kanaButtonStack.addArrangedSubview(hiraganaButton)
        kanaButtonStack.addArrangedSubview(katakanaButton)
        otherButtonStack.addArrangedSubview(clearButton)
        otherButtonStack.addArrangedSubview(nextButton)
        
    }
    
    private func setupLayout() {
        characterLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.centerX.equalToSuperview()
        }
        
        drawingView.snp.makeConstraints {
            $0.top.equalTo(characterLabel.snp.bottom).offset(30)
            $0.height.equalTo(drawingView.snp.width)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        canvasView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        horizontalLine.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(3)
            $0.width.equalToSuperview()
        }
        
        verticalLine.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(3)
            $0.height.equalToSuperview()
        }

        hiraganaLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        katakanaLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        undoButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(drawingView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(undoButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.greaterThanOrEqualToSuperview().inset(50)
        }
    }
    
    private func updateViews() {
        let values = viewModel.getRomajiValue()
        characterLabel.text = values.romaji
        hiraganaLabel.text = values.hiragana
        katakanaLabel.text = values.katakana
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == "Katakana" {
            katakanaLabel.isHidden = katakanaLabelIsHidden ? false : true
            katakanaLabelIsHidden = !katakanaLabelIsHidden
    
            hiraganaLabelIsHidden = true
            hiraganaLabel.isHidden = hiraganaLabelIsHidden
            
            sender.backgroundColor = katakanaLabelIsHidden ? UIColor(hex: "#a1ddf7ff") : UIColor(hex: "#43a6d1ff")
            hiraganaButton.backgroundColor = UIColor(hex: "#a1ddf7ff")
        } else if sender.titleLabel?.text == "Hiragana" {
            hiraganaLabel.isHidden = hiraganaLabelIsHidden ? false : true
            hiraganaLabelIsHidden = !hiraganaLabelIsHidden
            
            katakanaLabelIsHidden = true
            katakanaLabel.isHidden = katakanaLabelIsHidden
            
            sender.backgroundColor = hiraganaLabelIsHidden ? UIColor(hex: "#a1ddf7ff") : UIColor(hex: "#43a6d1ff")
            katakanaButton.backgroundColor = UIColor(hex: "#a1ddf7ff")
        } else if sender.titleLabel?.text == "Undo" {
            canvasView.undoManager?.undo()
        } else if sender.titleLabel?.text == "Clear" {
            canvasView.drawing = PKDrawing()
        } else if sender.titleLabel?.text == "Next" {
            canvasView.drawing = PKDrawing()
            katakanaLabelIsHidden = true
            katakanaLabel.isHidden = katakanaLabelIsHidden
            hiraganaLabelIsHidden = true
            hiraganaLabel.isHidden = hiraganaLabelIsHidden
            
            katakanaButton.backgroundColor = UIColor(hex: "#a1ddf7ff")
            hiraganaButton.backgroundColor = UIColor(hex: "#a1ddf7ff")
            updateViews()
        }
    }
}

// MARK: PKCanvasViewDelegate

extension KanaTestingDrawingViewController: PKCanvasViewDelegate {
    private func setupCanvasView() {
        canvasView.alwaysBounceVertical = true
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = .clear
        canvasView.tool = PKInkingTool(.pen, color: UIColor(hex: "#43a6d1ff") ?? .darkGray, width: 30)
    }
}

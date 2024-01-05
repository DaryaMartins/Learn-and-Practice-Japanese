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
        view.backgroundColor = UIColor.lineColor
        return view
    }()
    
    private var verticalLine: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.lineColor
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
    
    private var undoButton = UIButton()
    private var katakanaButton = UIButton()
    private var hiraganaButton = UIButton()
    private var clearButton = UIButton()
    private var nextButton = UIButton()
    
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
}

// MARK: Setup

private extension KanaTestingDrawingViewController {
    func setupViews() {
        view.backgroundColor = UIColor.backgroundColor
        
        setupButtonStyle(button: clearButton, title: ButtonNames.clear.rawValue)
        setupButtonStyle(button: undoButton, title: ButtonNames.undo.rawValue)
        setupButtonStyle(button: hiraganaButton, title: ButtonNames.hiragana.rawValue)
        setupButtonStyle(button: katakanaButton, title: ButtonNames.katakana.rawValue)
        setupButtonStyle(button: nextButton, title: ButtonNames.next.rawValue)
        
        view.addSubview(characterLabel)
        view.addSubview(drawingView)
        view.addSubview(kanaButtonStack)
        view.addSubview(otherButtonStack)
        view.addSubview(stackView)
        view.addSubview(nextButton)
        
        drawingView.addSubview(hiraganaLabel)
        drawingView.addSubview(katakanaLabel)
        drawingView.addSubview(horizontalLine)
        drawingView.addSubview(verticalLine)
        drawingView.addSubview(canvasView)
        
        stackView.addArrangedSubview(otherButtonStack)
        stackView.addArrangedSubview(kanaButtonStack)
        
        otherButtonStack.addArrangedSubview(clearButton)
        otherButtonStack.addArrangedSubview(undoButton)
        kanaButtonStack.addArrangedSubview(hiraganaButton)
        kanaButtonStack.addArrangedSubview(katakanaButton)
    }
    
    func setupLayout() {
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
        
        stackView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(drawingView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.greaterThanOrEqualToSuperview().inset(50)
        }
    }
    
    func setupButtonStyle(button: UIButton, title: String) {
        button.backgroundColor = UIColor.accentColor
        button.layer.cornerRadius = 20
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func updateViews() {
        let values = viewModel.getRomajiValue()
        characterLabel.text = values.romaji
        hiraganaLabel.text = values.hiragana
        katakanaLabel.text = values.katakana
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let buttonTitle = ButtonNames(rawValue: sender.titleLabel?.text ?? "")
        
        switch buttonTitle {
        case .katakana:
            katakanaLabel.isHidden = katakanaLabelIsHidden ? false : true
            katakanaLabelIsHidden = !katakanaLabelIsHidden
            
            hiraganaLabelIsHidden = true
            hiraganaLabel.isHidden = hiraganaLabelIsHidden
            
            sender.backgroundColor = katakanaLabelIsHidden ? UIColor.accentColor : UIColor.selectedButtonColor
            hiraganaButton.backgroundColor = UIColor.accentColor
        case .hiragana:
            hiraganaLabel.isHidden = hiraganaLabelIsHidden ? false : true
            hiraganaLabelIsHidden = !hiraganaLabelIsHidden
            
            katakanaLabelIsHidden = true
            katakanaLabel.isHidden = katakanaLabelIsHidden
            
            sender.backgroundColor = hiraganaLabelIsHidden ? UIColor.accentColor : UIColor.selectedButtonColor
            katakanaButton.backgroundColor = UIColor.accentColor
        case .clear:
            canvasView.drawing = PKDrawing()
        case .undo:
            canvasView.undoManager?.undo()
        case .next:
            canvasView.drawing = PKDrawing()
            katakanaLabelIsHidden = true
            katakanaLabel.isHidden = katakanaLabelIsHidden
            hiraganaLabelIsHidden = true
            hiraganaLabel.isHidden = hiraganaLabelIsHidden
            
            katakanaButton.backgroundColor = UIColor.accentColor
            hiraganaButton.backgroundColor = UIColor.accentColor
            updateViews()
        case .none:
            break
        }
    }
}

// MARK: PKCanvasViewDelegate

extension KanaTestingDrawingViewController: PKCanvasViewDelegate {
    private func setupCanvasView() {
        canvasView.alwaysBounceVertical = true
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = .clear
        if #available(iOS 17.0, *) {
            canvasView.tool = PKInkingTool(.monoline, color: UIColor.inkColor ?? .darkGray, width: 5)
        } else {
            canvasView.tool = PKInkingTool(.pen, color: UIColor.inkColor ?? .darkGray, width: 8)
        }
    }
}

private extension KanaTestingDrawingViewController {
    enum ButtonNames: String {
        case clear = "Clear"
        case undo = "Undo"
        case hiragana = "Hiragana"
        case katakana = "Katakana"
        case next = "Next"
    }
}

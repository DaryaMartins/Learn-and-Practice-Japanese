//
//  KanjiTestingDrawingViewController.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 02.05.2024.
//

import Foundation
import UIKit
import PencilKit

class KanjiTestingDrawingViewController: UIViewController {
    private var viewModel = KanjiTestingViewModel()
    private var kanjiLabelIsHidden = true
    
    private var canvasView = PKCanvasView()
    private var characterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "KleeOne-SemiBold", size: 50)
        label.textColor = .black
        return label
    }()
    
    private var kanjiLabel: UILabel = {
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
    
    private var undoButton = UIButton()
    private var clearButton = UIButton()
    private var kanjiButton = UIButton()
    private var nextButton = UIButton()
    
    private var otherButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        canvasView.delegate = self
        canvasView.drawing = PKDrawing()
        
        viewModel.fetchKanji()
        setupViews()
        setupLayout()
        updateViews()
        setupCanvasView()
    }
}

private extension KanjiTestingDrawingViewController {
    func setupViews() {
        view.backgroundColor = UIColor.backgroundColor
        
        setupButtonStyle(button: clearButton, title: ButtonNames.clear.rawValue)
        setupButtonStyle(button: undoButton, title: ButtonNames.undo.rawValue)
        setupButtonStyle(button: kanjiButton, title: ButtonNames.kanji.rawValue)
        setupButtonStyle(button: nextButton, title: ButtonNames.next.rawValue)
        
        view.addSubview(characterLabel)
        view.addSubview(drawingView)
        view.addSubview(otherButtonStack)
        view.addSubview(kanjiButton)
        view.addSubview(nextButton)
        
        
        drawingView.addSubview(kanjiLabel)
        drawingView.addSubview(horizontalLine)
        drawingView.addSubview(verticalLine)
        drawingView.addSubview(canvasView)
        
        otherButtonStack.addArrangedSubview(clearButton)
        otherButtonStack.addArrangedSubview(undoButton)
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
        
        kanjiLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        otherButtonStack.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(drawingView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        kanjiButton.snp.makeConstraints {
            $0.top.equalTo(otherButtonStack.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(kanjiButton.snp.bottom).offset(20)
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
        let values = viewModel.getRandomKanji()
        characterLabel.text = values?.meanings
        kanjiLabel.text = values?.kanji
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let buttonTitle = ButtonNames(rawValue: sender.titleLabel?.text ?? "")
        
        switch buttonTitle {
        case .kanji:
            kanjiLabel.isHidden = kanjiLabelIsHidden ? false : true
            kanjiLabelIsHidden = !kanjiLabelIsHidden
            
            sender.backgroundColor = kanjiLabelIsHidden ? UIColor.accentColor : UIColor.selectedButtonColor
        case .clear:
            canvasView.drawing = PKDrawing()
        case .undo:
            canvasView.undoManager?.undo()
        case .next:
            canvasView.drawing = PKDrawing()
            kanjiLabelIsHidden = true
            kanjiLabel.isHidden = kanjiLabelIsHidden
            kanjiButton.backgroundColor = UIColor.accentColor
            
            updateViews()
        case .none:
            break
        }
    }
}

// MARK: PKCanvasViewDelegate

extension KanjiTestingDrawingViewController: PKCanvasViewDelegate {
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

private extension KanjiTestingDrawingViewController {
    enum ButtonNames: String {
        case clear = "Clear"
        case undo = "Undo"
        case kanji = "Kanji"
        case next = "Next"
    }
}

//
//  WordsListViewController.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 03.08.2023.
//

import UIKit

class WordsListViewController: UIViewController {
    lazy private var sampleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Hello, WordsListViewController!"
            return label
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            self.view.addSubview(self.sampleLabel)
            self.setUpConstraints()
        }

        func setUpConstraints() {
            let sampleLabelConstraints = [
                self.sampleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.sampleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ]
            NSLayoutConstraint.activate(sampleLabelConstraints)
        }
}

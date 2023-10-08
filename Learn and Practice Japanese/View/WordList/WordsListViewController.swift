//
//  WordsListViewController.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 03.08.2023.
//

import UIKit
import SnapKit

class WordsListViewController: UIViewController {
    private let searchField = UITextField()
    private let wordList: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorInset = .zero
        tableView.separatorColor = UIColor(hex: "#a1ddf7ff")
        return tableView
    }()
    
    private let buttonStack: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let searchButton: UIButton = {
        var button = UIButton()
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 18)
        button.backgroundColor = UIColor(hex: "#a1ddf7ff")
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
        
    }()
    
    private let addButton: UIButton = {
        var button = UIButton()
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 18)
        button.backgroundColor = UIColor(hex: "#a1ddf7ff")
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
        
    }()
    
    private let filterButton: UIButton = {
        var button = UIButton()
        button.setTitle("Filter", for: .normal)
        button.titleLabel?.font = UIFont(name: "KleeOne-SemiBold", size: 18)
        button.backgroundColor = UIColor(hex: "#a1ddf7ff")
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        wordList.delegate = self
        wordList.dataSource = self
         
        self.setupViews()
        self.setupLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
                                                          
    @objc private func searchButtonTapped(_ sender: AnyObject) {
        if searchField.isHidden {
            searchField.isHidden = false
            
            wordList.snp.remakeConstraints {
                $0.top.equalTo(searchField.snp.bottom).offset(20)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.bottom.equalToSuperview().inset(100)
            }
            
        } else {
            searchField.isHidden = true
            
            wordList.snp.remakeConstraints {
                $0.top.equalTo(searchButton.snp.bottom).offset(20)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.bottom.equalToSuperview().inset(100)
            }
        }
    }
    
    @objc private func addButtonTapped(_ sender: AnyObject) {
        let vc = WordInfoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func filterButtonTapped(_ sender: AnyObject) {
        print("Filter")
    }
}

// MARK: Setup views

extension WordsListViewController {
    private func setupViews() {
        view.backgroundColor = .white
        // todo: hide and show only when it need
        view.addSubview(searchField)
        searchField.isHidden = true
        searchField.borderStyle = .roundedRect
        searchField.backgroundColor = .lightGray
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(searchButton)
        buttonStack.addArrangedSubview(addButton)
        buttonStack.addArrangedSubview(filterButton)
        view.addSubview(wordList)
        
        navigationItem.title = "Word list"
    }
    
    private func setupLayout() {
        buttonStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        searchField.snp.makeConstraints {
            $0.top.equalTo(searchButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        wordList.snp.makeConstraints {
            $0.top.equalTo(searchButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(100)
        }
    }
}

// MARK: UITableViewDelegate

extension WordsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // todo: don't forget to fix it
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        WordListsCell()
    }
}

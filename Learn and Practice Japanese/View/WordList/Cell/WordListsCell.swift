//
//  WordListsCell.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 08.10.2023.
//

import Foundation
import UIKit
import SnapKit

class WordListsCell: UITableViewCell {
    lazy var testLabel: UILabel = {
        var label = UILabel()
        label.text = "Header"
        label.textColor = .black
        return label
    }()
    
    lazy var testLabel2: UILabel = {
        var label = UILabel()
        label.text = "SubHeader"
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubview(testLabel)
        addSubview(testLabel2)
        
        testLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(10)
        }
        
        testLabel2.snp.makeConstraints {
            $0.top.equalTo(testLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

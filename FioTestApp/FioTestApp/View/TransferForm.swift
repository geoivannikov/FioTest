//
//  TransferForm.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import UIKit

final class TransferForm: UIView {
    let accountNumberTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Account number"
        return textField
    }()

    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let executionDateTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Execution date"
        textField.text = "ASAP"
        return textField
    }()
    
    let variableSymbolTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Variable symbol (Optional)"
        textField.keyboardType = .numberPad
        return textField
    }()

    let sendButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5.0
        button.isEnabled = true
        button.backgroundColor = .fioBlue
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("Send", for: .normal)
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10.0
        return stackView
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    convenience init() {
        self.init(frame: .zero)
    }

    func setupView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        [accountNumberTextField,
         amountTextField,
         executionDateTextField,
         variableSymbolTextField,
         sendButton
        ].forEach { view in
            stackView.addArrangedSubview(view)
            view.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10).isActive = true
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10).isActive = true
        }
        
        stackView.setCustomSpacing(30.0, after: variableSymbolTextField)
    }
}

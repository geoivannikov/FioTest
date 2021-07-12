//
//  HistoryCell.swift
//  FioTestApp
//
//  Created by George Ivannikov on 12.07.2021.
//

import Foundation
import UIKit

final class HistoryCell: UITableViewCell {
    private let accountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    private let recipientLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .fioRed
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10.0
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }

    private func setUpLayout() {
        selectionStyle = .none
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        [accountLabel,
         recipientLabel,
         amountLabel].forEach { view in
            stackView.addArrangedSubview(view)
            view.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10).isActive = true
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10).isActive = true
        }
    }
    
    func fillData(transfer: TransferData) {
        accountLabel.text = transfer.accountName
        recipientLabel.text = "Recipient: \(transfer.recipientNumber)"
        amountLabel.text = "-\(String(transfer.amount)) \(transfer.currency)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

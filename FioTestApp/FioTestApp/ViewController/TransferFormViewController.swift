//
//  TransferFormViewController.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import UIKit
import Combine

final class TransferFormViewController: UIViewController {
    private let viewModel: TransferFormViewModelProtocol
    private let transferForm = TransferForm()
    
    private var subscriptions = Set<AnyCancellable>()

    init(viewModel: TransferFormViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        setUpLayout()
        setUpBinds()
    }
    
    private func setUpLayout() {
        title = viewModel.account.name
        view.backgroundColor = .white

        view.addSubview(transferForm)
        transferForm.translatesAutoresizingMaskIntoConstraints = false
        transferForm.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        transferForm.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        transferForm.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        transferForm.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        transferForm.amountTextField.placeholder = "Amount (\(viewModel.account.currency))"
        transferForm.accountBalanceLabel.text = "\(String(viewModel.account.balance)) \(viewModel.account.currency)"
        transferForm.accountBalanceLabel.textColor = viewModel.account.balance >= 0 ? .fioGreen : .fioRed
        
        dismissKeyboardAfterTap()
    }
    
    private func setUpBinds() {
        transferForm.sendButton
            .publisher(for: .touchUpInside)
            .compactMap { [weak self] _ -> TransferData? in
                guard let self = self,
                      let accountNumber = self.transferForm.accountNumberTextField.text?
                        .components(separatedBy: .whitespaces).joined(),
                      let amount = self.transferForm.amountTextField.text,
                      let variableSymbol = self.transferForm.variableSymbolTextField.text else {
                    return nil
                }
                return TransferData(accountName: self.viewModel.account.name,
                                    currency: self.viewModel.account.currency,
                                    recipientNumber: accountNumber,
                                    amount: Double(amount) ?? 0,
                                    variableSymbol: Int(variableSymbol) ?? nil)
            }
            .sink(receiveValue: { [weak self] transferData in
                self?.viewModel.sendTransfer.send(transferData)
            })
            .store(in: &subscriptions)
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification,
                                             object: transferForm.amountTextField)
            .compactMap { [weak self] _ in
                self?.transferForm.amountTextField.text
            }
            .map { Double($0) ?? 0.0 }
            .sink(receiveValue: { [weak self] amount in
                guard let self = self else {
                    return
                }
                let currentBalance = self.viewModel.account.balance - amount
                self.transferForm.accountBalanceLabel.text = "\(currentBalance) \(self.viewModel.account.currency)"
                self.transferForm.accountBalanceLabel.textColor = currentBalance >= 0 ? .fioGreen : .fioRed
            })
            .store(in: &subscriptions)
        
        Publishers.MergeMany(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification,
                                                                  object: transferForm.accountNumberTextField),
                             NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification,
                                                                  object: transferForm.amountTextField))
            .sink(receiveValue: { [weak self] _ in
                guard let self = self,
                      let accountNumber = self.transferForm.accountNumberTextField.text?
                        .components(separatedBy: .whitespaces).joined(),
                      let amount = self.transferForm.amountTextField.text else {
                    return
                }
                let currentBalance = self.viewModel.account.balance - (Double(amount) ?? 0.0)
                if !accountNumber.isEmpty && !amount.isEmpty && currentBalance >= 0 {
                    self.transferForm.sendButton.isEnabled = true
                    self.transferForm.sendButton.backgroundColor = .fioBlue
                } else {
                    self.transferForm.sendButton.isEnabled = false
                    self.transferForm.sendButton.backgroundColor = .fioGrey
                }
            })
            .store(in: &subscriptions)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

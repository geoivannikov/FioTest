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
        
        dismissKeyboardAfterTap()
    }
    
    private func setUpBinds() {
        transferForm.sendButton
            .publisher(for: .touchUpInside)
//            .compactMap { [weak self] _ -> TransferData? in
//                guard let self = self,
//                      let accountNumber = self.transferForm.accountNumberTextField.text,
//                      let amount = self.transferForm.amountTextField.text,
//                      let variableSymbol = self.transferForm.variableSymbolTextField.text else {
//                    return nil
//                }
//                return TransferData(accountName: self.viewModel.account.name,
//                                    currency: self.viewModel.account.currency,
//                                    accountNumber: accountNumber,
//                                    amount: Double(amount) ?? 0,
//                                    variableSymbol: Int(variableSymbol) ?? 0)
//            }
            .map { _ in
                TransferData(accountName: "Some", currency: "USD", accountNumber: "11111", amount: 10, variableSymbol: 1111)
            }
            .sink(receiveValue: { [weak self] transferData in
                self?.viewModel.sendTransfer.send(transferData)
            })
            .store(in: &subscriptions)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITextField {
    func registerUpdate(bindedFunction: @escaping ((String) -> Void),
                        subscriptions: inout Set<AnyCancellable>) {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap {  _ in self.text }
            .sink(receiveValue: bindedFunction)
            .store(in: &subscriptions)
    }
}

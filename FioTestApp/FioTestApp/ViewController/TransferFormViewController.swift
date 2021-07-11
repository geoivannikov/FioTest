//
//  TransferFormViewController.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import UIKit

final class TransferFormViewController: UIViewController {
    private let viewModel: TransferFormViewModelProtocol
    private let transferForm = TransferForm()

    init(viewModel: TransferFormViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        setUpLayout()
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

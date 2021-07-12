//
//  MainCoordinator.swift
//  FioTestApp
//
//  Created by George Ivannikov on 10.07.2021.
//

import Foundation
import UIKit
import Combine

final class MainCoordinator {
    private let navigationController: UINavigationController
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let accountsViewModel = AccountsViewModel()
        let accountsViewController = AccountsViewController(viewModel: accountsViewModel)

        accountsViewModel.selectedAccount
            .sink(receiveValue: { [weak self] selectedAccount in
                guard let self = self else {
                    return
                }
                let transferFormViewModel = TransferFormViewModel(account: selectedAccount)
                let transferFormViewController = TransferFormViewController(viewModel: transferFormViewModel)
                self.navigationController.pushViewController(transferFormViewController, animated: true)
                
                transferFormViewModel.sendTransfer
                    .sink(receiveValue: { [weak self] _ in
                        self?.navigationController.popViewController(animated: true)
                    })
                    .store(in: &self.subscriptions)
            })
            .store(in: &subscriptions)
        
        accountsViewModel.historyPressed
            .sink(receiveValue: { [weak self] _ in
                let historyViewModel = HistoryViewModel()
                let historyViewController = HistoryViewController(viewModel: historyViewModel)
                self?.navigationController.pushViewController(historyViewController, animated: true)
            })
            .store(in: &subscriptions)
        
        accountsViewModel.displayErrorAlert
            .sink(receiveValue: presentError(error:))
            .store(in: &subscriptions)
        
        navigationController.viewControllers = [accountsViewController]
    }
    
    private func presentError(error: APIError) {
        let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        navigationController.present(alert, animated: true)
    }
}

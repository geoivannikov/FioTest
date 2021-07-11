//
//  MainCoordinator.swift
//  FioTestApp
//
//  Created by George Ivannikov on 10.07.2021.
//

import Foundation
import UIKit
import Combine

final class MainCoordinator: CoordinatorProtocol {
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
                let transferFormViewModel = TransferFormViewModel(account: selectedAccount)
                let transferFormViewController = TransferFormViewController(viewModel: transferFormViewModel)
                self?.navigationController.pushViewController(transferFormViewController, animated: true)
            })
            .store(in: &subscriptions)
        
        navigationController.viewControllers = [accountsViewController]
    }
}

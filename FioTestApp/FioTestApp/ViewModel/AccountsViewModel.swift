//
//  AccountsViewModel.swift
//  FioTestApp
//
//  Created by George Ivannikov on 10.07.2021.
//

import Foundation
import Combine

protocol AccountsViewModelProtocol {
    var accounts: AnyPublisher<[Account], Never> { get }
    var displayErrorAlert: AnyPublisher<APIError, Never> { get }
    var selectedAccount: PassthroughSubject<Account, Never> { get }
    var historyPressed: PassthroughSubject<Void, Never> { get }
    
    func viewDidLoad()
}

final class AccountsViewModel: AccountsViewModelProtocol {
    var accounts: AnyPublisher<[Account], Never> {
        accountsSubject.eraseToAnyPublisher()
    }
    var displayErrorAlert: AnyPublisher<APIError, Never> {
        displayErrorAlertSubject.eraseToAnyPublisher()
    }
    let selectedAccount = PassthroughSubject<Account, Never>()
    let historyPressed = PassthroughSubject<Void, Never>()
    
    private let accountsSubject = PassthroughSubject<[Account], Never>()
    private let displayErrorAlertSubject = PassthroughSubject<APIError, Never>()
    private let apiManager: ApiManagerProtocol
    private let reachabilityService: ReachabilityServiceProtocol
    
    private var subscriptions = Set<AnyCancellable>()

    init(apiManager: ApiManagerProtocol = Env.current.apiManager,
         reachabilityService: ReachabilityServiceProtocol = Env.current.reachabilityService) {
        self.apiManager = apiManager
        self.reachabilityService = reachabilityService
    }
    
    func viewDidLoad() {
        if !reachabilityService.isConnectedToNetwork {
            displayErrorAlertSubject.send(.noConnectionError)
            return
        }
        apiManager.fetchData(url: URL(string: Constants.accountsURL))
            .map(\.accounts)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    ()
                case .failure(let error):
                    self?.displayErrorAlertSubject.send(error)
                }
            }, receiveValue: { [weak self] accounts in
                self?.accountsSubject.send(accounts)
            })
            .store(in: &subscriptions)
    }
}

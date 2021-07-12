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
    var isHistoryEmpty: AnyPublisher<Bool, Never> { get }
    var selectedAccount: PassthroughSubject<Account, Never> { get }
    var historyPressed: PassthroughSubject<Void, Never> { get }
    
    func viewDidLoad()
}

final class AccountsViewModel: AccountsViewModelProtocol {
    var accounts: AnyPublisher<[Account], Never> {
        accountsSubject.eraseToAnyPublisher()
    }
    var isHistoryEmpty: AnyPublisher<Bool, Never> {
        isHistoryEmptySubject.eraseToAnyPublisher()
    }
    let selectedAccount = PassthroughSubject<Account, Never>()
    let historyPressed = PassthroughSubject<Void, Never>()
    
    private let accountsSubject = PassthroughSubject<[Account], Never>()
    private let isHistoryEmptySubject = PassthroughSubject<Bool, Never>()
    private let apiManager: ApiManagerProtocol
    
    private var subscriptions = Set<AnyCancellable>()

    init(apiManager: ApiManagerProtocol = Env.current.apiManager,
         reachabilityService: ReachabilityServiceProtocol = Env.current.reachabilityService) {
        self.apiManager = apiManager
        
        apiManager.fetchData(url: URL(string: "http://kali.fio.cz/test/accounts.json"))
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in
            })
            .store(in: &subscriptions)
    }
    
    func viewDidLoad() {
        isHistoryEmptySubject.send(false)
        apiManager.fetchData(url: URL(string: "http://kali.fio.cz/test/accounts.json"))
            .map(\.accounts)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] accounts in
                self?.accountsSubject.send(accounts)
            })
            .store(in: &subscriptions)
    }
}

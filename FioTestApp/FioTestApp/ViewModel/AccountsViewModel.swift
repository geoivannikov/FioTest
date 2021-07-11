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
    
    private let accountsSubject = PassthroughSubject<[Account], Never>()
    private let isHistoryEmptySubject = PassthroughSubject<Bool, Never>()
    
    private var subscriptions = Set<AnyCancellable>()

    init(apiManager: ApiManagerProtocol = Env.current.apiManager,
         reachabilityService: ReachabilityServiceProtocol = Env.current.reachabilityService) {
        
        apiManager.fetchData(url: URL(string: "http://kali.fio.cz/test/accounts.json")!)
            .sink(receiveCompletion: { _ in }, receiveValue: {
                print($0)
            })
            .store(in: &subscriptions)
    }
    
    func viewDidLoad() {
        accountsSubject.send([Account(name: "Some name", number: 1, currency: "USD", balance: 10)])
        isHistoryEmptySubject.send(false)
    }
}

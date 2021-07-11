//
//  AccountsViewController.swift
//  FioTestApp
//
//  Created by George Ivannikov on 10.07.2021.
//

import UIKit
import Combine

final class AccountsViewController: UITableViewController {
    private let viewModel: AccountsViewModelProtocol
    private var accounts: [Account] = []
    
    private var subscriptions = Set<AnyCancellable>()

    init(viewModel: AccountsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        setUpLayout()
        setUpBinds()
        viewModel.viewDidLoad()
        
//        viewModel.selectedAccount.send(Account(name: "Some name", number: 1111, currency: "CZK", balance: 10.0))
    }
    
    private func setUpLayout() {
        title = "Accounts"
        view.backgroundColor = .white
        tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "History",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(self.historyPressed(sender:)))
    }
    
    private func setUpBinds() {
        viewModel.accounts
            .sink(receiveValue: { [weak self] accounts in
                self?.accounts = accounts
                self?.tableView.reloadData()
            })
            .store(in: &subscriptions)
        
        viewModel.isHistoryEmpty
            .sink(receiveValue: { [weak self] in
                self?.navigationItem.rightBarButtonItem?.isEnabled = !$0
            })
            .store(in: &subscriptions)
    }
    
    @objc private func historyPressed(sender: UIBarButtonItem) {
        viewModel.historyPressed.send(())
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accounts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(accounts[indexPath.row].name) (\(accounts[indexPath.row].balance) \(accounts[indexPath.row].currency))"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedAccount.send(accounts[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

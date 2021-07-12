//
//  HistoryViewController.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import UIKit
import Combine

final class HistoryViewController: UITableViewController {
    private let viewModel: HistoryViewModelProtocol
    
    private var subscriptions = Set<AnyCancellable>()

    init(viewModel: HistoryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        setUpLayout()
    }
    
    private func setUpLayout() {
        title = "History"
        view.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(HistoryCell.self, forCellReuseIdentifier: "HistoryCell")
        tableView.separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.transfers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HistoryCell()
        cell.fillData(transfer: viewModel.transfers[indexPath.row])
        return cell
    }
}

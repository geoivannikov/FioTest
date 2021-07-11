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
        setUpBinds()
    }
    
    private func setUpLayout() {
    }
    
    private func setUpBinds() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

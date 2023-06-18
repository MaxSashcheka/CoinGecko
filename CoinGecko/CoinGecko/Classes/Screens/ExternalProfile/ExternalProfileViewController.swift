//
//  ExternalProfileViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class ExternalProfileViewController: ViewController {
    
    // MARK: - UI Components
    
    private let tableView: TableView = .make(style: .insetGrouped) {
        $0.register(ProfileTableCell.self)
        $0.separatorStyle = .none
    }
    
    private let profileImageView = RemoteImageView(placeholder: .color(.gray))
    
    private let headerView: View = .make {
        $0.clipsToBounds = true
    }
    
    override var backgroundColor: UIColor { Assets.Colors.platinum.color }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        headerView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.top.equalToSuperview().inset(17)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.cellsViewModels
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.profileImageURL
            .bind(to: \.imageURL, on: profileImageView)
            .store(in: &cancellables)
        
        viewModel.profileName
            .bind(to: \.title, on: self)
            .store(in: &cancellables)
    }
    
    override func setupData() {
        super.setupData()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ExternalProfileViewController: UITableViewPresentable {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == .zero else { return nil }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == .zero else { return .zero }
        return 380
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.reuse(ProfileTableCell.self, indexPath) else {
            assertionFailure("Cannot deque reusable cell for \(ProfileTableCell.reuseIdentifier) identifier")
            return UITableViewCell()
        }
        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        
        return cell
    }
}

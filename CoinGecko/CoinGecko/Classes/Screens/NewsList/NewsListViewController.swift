//
//  NewsListViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class NewsListViewController: ViewController {
    
    private let postsTableView: TableView = .make {
        $0.register(PostTableCell.self)
        $0.separatorStyle = .none
        $0.backgroundColor = Assets.Colors.platinum.color
    }
    
    override var backgroundColor: UIColor { Assets.Colors.platinum.color }
    override var tabBarTitle: String { L10n.Tabbar.Title.news }
    override var tabBarImage: UIImage? { UIImage(.newspaper) }
    
    var createPostBarButton: UIBarButtonItem {
        UIBarButtonItem.barButtonItem(
            image: UIImage(.plus),
            action: { [weak viewModel] in viewModel?.didTapComposePostButton() }
        )
    }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = L10n.NewsList.title
        
        viewModel.fetchPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchCurrentUserData()
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(postsTableView)
        postsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.postsViewModels
            .sink { [weak self] _ in
                self?.postsTableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.isAddPostButtonHidden
            .sink { [weak self] in
                self?.navigationItem.rightBarButtonItem = $0 ? nil : self?.createPostBarButton
                
            }
            .store(in: &cancellables)
    }
    
    override func setupData() {
        super.setupData()
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
    }
}

// MARK: - NewsListViewController+UITableViewPresentable
extension NewsListViewController: UITableViewPresentable {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.reuse(PostTableCell.self, indexPath) else {
            assertionFailure("Cannot deque reusable cell for \(PostTableCell.reuseIdentifier) identifier")
            return UITableViewCell()
        }
        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCell(at: indexPath)
    }
}

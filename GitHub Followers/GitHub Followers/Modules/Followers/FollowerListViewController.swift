//
//  FollowerListViewController.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit

class FollowerListViewController: BaseViewController {

    // MARK: - Properties
    private lazy var searchController: UISearchController = {
        let searchField = UISearchController(searchResultsController: .none)
        searchField.searchBar.autocapitalizationType = .none
        searchField.searchBar.autocorrectionType = .no
        searchField.searchBar.keyboardType = .default
        searchField.searchBar.returnKeyType = .search
        searchField.searchBar.barTintColor = .label
        searchField.searchBar.placeholder = "Search for username"
        searchField.searchBar.layer.cornerRadius = 8
        searchField.searchBar.delegate = self
        return searchField
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = gridSpacing
        layout.minimumInteritemSpacing = gridSpacing
        let width = floor((view.frame.width - gridSpacing * (numberOfItemsInRow + 1)) / numberOfItemsInRow)
        layout.itemSize = CGSize(width: width, height: width + 40) // adding margin to give extra height
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cell: GitHubProfileCollectionCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var searchDelayTimer: Timer?
    private let dataSource = FollowerListDataSource()
    private var username: String
    private var numberOfItemsInRow: CGFloat = 3
    private var gridSpacing: CGFloat = 10
    
    
    // MARK: - Life Cycle
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        initialFetch()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        navigationItem.title = username
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubviews(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func initialFetch() {
        dataSource.fetchFollowers(for: username) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension FollowerListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.numberOfItem(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: GitHubProfileCollectionCell.self, for: indexPath)
        cell.configure(with: dataSource.objectAt(indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedFollower = dataSource.objectAt(indexPath) else { return }
        let detailController = UserDetailViewController(username: selectedFollower.followerUserName)
        navigationController?.pushViewController(detailController, animated: true)
    }
}

extension FollowerListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchDelayTimer?.invalidate()
        
        if searchText.isEmpty {
            dataSource.showOldData()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } else {
            searchDelayTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                guard let self else { return }
                dataSource.filterFollowers(searchText: searchText)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dataSource.showOldData()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

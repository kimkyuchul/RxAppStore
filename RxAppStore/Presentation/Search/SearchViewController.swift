//
//  SearchViewController.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/10.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

final class SearchViewController: BaseViewController {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "게임 앱 스토리 등"
        return searchBar
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.rowHeight = UIScreen.main.bounds.height / 2
        tableView.backgroundColor = .systemBackground
        tableView.showsVerticalScrollIndicator = false
        return tableView
      }()
    
    private let viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bind() {
        let input = SearchViewModel.Input(
            searchButtonTapped: searchBar.rx.searchButtonClicked.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.appInfo
            .asDriver()
            .drive(with: self) { owner, appInfo in
                print(appInfo)
            }
            .disposed(by: disposeBag)
        
        output.error
            .asDriver(onErrorDriveWith: .never())
            .drive(with: self) { owner, error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        Observable.just([UIImage(systemName: "star"), UIImage(systemName: "star"), UIImage(systemName: "star")])
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appIconImageView.image = element
            }
            .disposed(by: disposeBag)
            
    }
    
    override func setNavigationBar() {
        title = "iTunes 검색"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func setHierarchy() {
        [searchBar, tableView]
            .forEach {
                view.addSubview($0)
            }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(3)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(3)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//
//  SearchView.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import UIKit

final class SearchView: UIView {
	private lazy var searchBar = UISearchBar()
	private lazy var tableView = UITableView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		applyViewCode()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func tableViewUpdate() {
		tableView.reloadData()
	}
	
	func setupTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
		tableView.delegate = delegate
		tableView.dataSource = dataSource
	}

	func setupSearchBar(delegate: UISearchBarDelegate) {
		searchBar.delegate = delegate
	}
}

extension SearchView: ViewCodeConfiguration {
	func buildHierarchy() {
		searchBar.setViewIsCodable()
		addSubview(searchBar)
		tableView.setViewIsCodable()
		addSubview(tableView)
	}
	
	func setupContraints() {
		let searchBarConstraints = [
			searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
		]
		
		let tableViewConstraints = [
			tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
			tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		]
		
		NSLayoutConstraint.activate(searchBarConstraints + tableViewConstraints)
	}
	
	func configureViews() {
		tableView.register(SearchViewCell.self,
						   forCellReuseIdentifier: SearchViewCell.identifier)
		let tap = UITapGestureRecognizer(target: self, action: #selector(searchBar.endEditing))
		self.addGestureRecognizer(tap)
	}
}

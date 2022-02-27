//
//  SearchViewController.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 24/02/22.
//

import UIKit

final class SearchViewController: UIViewController {
	private var dataSource: [SearchViewCell.Model] = [] {
		didSet {
			searchView?.tableViewUpdate()
		}
	}
	
	private var searchView: SearchView? {
		view as? SearchView
	}
	
	var viewModel: SearchViewModelProtocol?
	weak var coordinator: DogsListCoodinatorProtocol?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		searchView?.setupSearchBar(delegate: self)
		searchView?.setupTableView(dataSource: self,
								   delegate: self)
	}
	
	override func loadView() {
		view = SearchView()
	}
}

extension SearchViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		dataSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.identifier,
													  for: indexPath) as? SearchViewCell
		
		cell?.model = dataSource[indexPath.row]
		return cell!
	}
}

extension SearchViewController: UITableViewDelegate {
	
}

extension SearchViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.text else { return }
		viewModel?.searchDogsBy(breed: text)
		searchBar.endEditing(true)
	}
}

extension SearchViewController: SearchViewModelDelegate {
	func searchViewModel(_ viewModel: SearchViewModelProtocol, didUpdate dataSource: [SearchViewCell.Model]) {
		self.dataSource = dataSource
	}
}

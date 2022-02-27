//
//  DogListViewController.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 24/02/22.
//

import UIKit

final class DogListViewController: UIViewController {
	
	private var listView: DogListView? {
		view as? DogListView
	}
	
	private var dataSource = [DogCollectionViewCell.Model]() {
		didSet {
			listView?.reloadData()
		}
	}
	
	var viewModel: DogsListViewModelProtocol?
	weak var coordinator: DogsListCoodinatorProtocol?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		listView?.setCollectionView(dataSource: self,
									delegate: self)
		listView?.layoutAndFilterView(delegate: self)
		self.navigationController?.navigationBar.isHidden = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		listView?.set(layout: .list)
		viewModel?.getNextPage()
	}
	
	override func loadView() {
		view = DogListView()
	}
}

extension DogListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if dataSource.isEmpty {
			return 0
		}
		
		return dataSource.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
				if dataSource.isEmpty || dataSource.count <= indexPath.item {
					return UICollectionViewCell()
				}
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogCollectionViewCell.identifier,
													  for: indexPath) as? DogCollectionViewCell
		
		cell?.model = dataSource[indexPath.row]
		cell?.sizeToFit()
		return cell!
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if (viewModel?.hasNextPage ?? false),
			indexPath.item == (dataSource.count - 1) {
			viewModel?.getNextPage()
		}
	}
}

extension DogListViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		coordinator?.didPresentDetailsView()
	}
}

extension DogListViewController: DogsListViewModelDelegate {
	func dogsListViewModel(_ viewModel: DogsListViewModelProtocol, willUpdateDataSource dataSource: [DogCollectionViewCell.Model]) {
		self.dataSource = dataSource
	}
}

extension DogListViewController: LayoutAndFilterViewDelegate {
	func layoutAndFilterView(_ view: LayoutAndFilterView, orderIsSelected: LayoutAndFilterView.Alphabetic) {
		viewModel?.getListByOrder(isAscending: orderIsSelected == .ascending)
	}
	
	func layoutAndFilterView(_ view: LayoutAndFilterView, layoutIsSelected: LayoutAndFilterView.LayoutFormat) {
		listView?.set(layout: layoutIsSelected)
	}
}

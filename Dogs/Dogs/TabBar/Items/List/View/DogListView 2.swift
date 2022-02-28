//
//  DogListView.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import UIKit

final class DogListView: UIView {
	private lazy var layoutAndFilterView = LayoutAndFilterView()
	private lazy var flowLayout = ListOrGridCollectionViewFlowLayout()
	private lazy var myCollectionView: UICollectionView = {
		let myCollectionView = UICollectionView(frame: frame,
												collectionViewLayout: flowLayout)
		myCollectionView.register(DogCollectionViewCell.self,
								  forCellWithReuseIdentifier: DogCollectionViewCell.identifier)
		return myCollectionView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		applyViewCode()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setGridLayout() {
		flowLayout.selectGridLayout(width: frame.width)
		myCollectionView.reloadData()
	}
	
	func set(layout: LayoutAndFilterView.LayoutFormat) {
		
		switch layout {
		case .list:
			flowLayout.selectListLayout(width: frame.width)
		case .grid:
			flowLayout.selectGridLayout(width: frame.width)
		}
		
		myCollectionView.reloadData()
	}
	
	func reloadData() {
		myCollectionView.reloadData()
	}
	
	func setCollectionView(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) {
		myCollectionView.dataSource = dataSource
		myCollectionView.delegate = delegate
	}
	
	func layoutAndFilterView(delegate: LayoutAndFilterViewDelegate) {
		layoutAndFilterView.delegate = delegate
	}
}

extension DogListView: ViewCodeConfiguration {
	func buildHierarchy() {
		layoutAndFilterView.setViewIsCodable()
		addSubview(layoutAndFilterView)
		myCollectionView.setViewIsCodable()
		addSubview(myCollectionView)
	}
	
	func setupContraints() {
		let layoutAndFilterViewConstraints = [
			layoutAndFilterView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			layoutAndFilterView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			layoutAndFilterView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
			layoutAndFilterView.heightAnchor.constraint(equalToConstant: 36)
		]
		
		let myCollectionViewConstraints = [
			myCollectionView.topAnchor.constraint(equalTo: layoutAndFilterView.bottomAnchor),
			myCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
			myCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
			myCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		]
		
		NSLayoutConstraint.activate(layoutAndFilterViewConstraints + myCollectionViewConstraints)
	}
	
	func configureViews() {
		backgroundColor = .white
	}
}

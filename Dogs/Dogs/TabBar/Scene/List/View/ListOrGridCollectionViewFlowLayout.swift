//
//  ListOrGridCollectionViewFlowLayout.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import UIKit

final class ListOrGridCollectionViewFlowLayout: UICollectionViewFlowLayout {
	
	func selectListLayout(width: CGFloat) {
		itemSize.width = width
		itemSize.height = 100
		minimumInteritemSpacing = .zero
		minimumLineSpacing = 4
		scrollDirection = .vertical
	}
	
	func selectGridLayout(width: CGFloat) {
		scrollDirection = .vertical
		itemSize.width = (width/2 - 20)
		itemSize.height = 120
		minimumInteritemSpacing = 10
		minimumLineSpacing = 10
	}
}

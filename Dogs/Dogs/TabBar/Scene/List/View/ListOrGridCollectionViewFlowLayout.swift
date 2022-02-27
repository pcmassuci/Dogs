//
//  ListOrGridCollectionViewFlowLayout.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import UIKit

final class ListOrGridCollectionViewFlowLayout: UICollectionViewFlowLayout {
	
	func selectListLayout(width: CGFloat) {
		sectionInset = UIEdgeInsets(top: .zero,
									left: 10,
									bottom: .zero,
									right: 10)
		
		itemSize.width = width
				minimumInteritemSpacing = .zero
				minimumLineSpacing = .zero
				scrollDirection = .vertical
	}
	
	func selectGridLayout(width: CGFloat) {
		scrollDirection = .vertical
		itemSize.width = (width/2 - 20)
		minimumInteritemSpacing = 10
		minimumLineSpacing = 10
	}
}

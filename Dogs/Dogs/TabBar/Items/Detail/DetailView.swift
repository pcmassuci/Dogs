//
//  DetailView.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import Foundation
import UIKit

final class DetailView: UIView {
	struct Model {
		let breedName: String
		let breedCategory: String
		let origin: String
		let temperament: String
	}
	
	private lazy var breedNameLabel = UILabel()
	private lazy var breedCategoryLabel = UILabel()
	private lazy var originLabel = UILabel()
	private lazy var temperamentLabel = UILabel()
	
	var model: Model? {
		didSet {
			didSetModel()
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		applyViewCode()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		applyViewCode()
	}
	
	private func didSetModel() {
		breedNameLabel.text = model?.breedName
		breedCategoryLabel.text = model?.breedCategory
		originLabel.text = model?.origin
		temperamentLabel.text = model?.temperament
	}
}

extension DetailView: ViewCodeConfiguration {
	func buildHierarchy() {
		breedNameLabel.setViewIsCodable()
		addSubview(breedNameLabel)
		
		breedCategoryLabel.setViewIsCodable()
		addSubview(breedCategoryLabel)
		
		originLabel.setViewIsCodable()
		addSubview(originLabel)
		
		temperamentLabel.setViewIsCodable()
		addSubview(temperamentLabel)
	}
	
	func setupContraints() {
		let breedNameLabelConstraints = [
			breedNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
												constant: 8),
			breedNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
													constant: 8),
			breedNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
													 constant: -8)
		]
		
		let breedCategoryLabelConstraints = [
			breedCategoryLabel.topAnchor.constraint(equalTo: breedNameLabel.bottomAnchor,
												 constant: 8),
			breedCategoryLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
													 constant: 8),
			breedCategoryLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
													  constant: -8)
		]
		
		let originLabelConstraints = [
			originLabel.topAnchor.constraint(equalTo: breedCategoryLabel.bottomAnchor,
												 constant: 8),
			originLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
													 constant: 8),
			originLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
													  constant: -8)
		]
		
		let temperamentLabelConstraints = [
			temperamentLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor,
											 constant: 8),
			temperamentLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
												 constant: 8),
			temperamentLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
												  constant: -8),
			temperamentLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor,
												constant: -8)
		]
		
		NSLayoutConstraint.activate(breedNameLabelConstraints + breedCategoryLabelConstraints + originLabelConstraints + temperamentLabelConstraints)
	}
	
	func configureViews() {
		backgroundColor = .white
	}
}


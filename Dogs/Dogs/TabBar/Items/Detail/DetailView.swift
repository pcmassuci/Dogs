//
//  DetailView.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import Foundation
import UIKit
import SwiftUI

final class DetailView: UIView {
	struct Model {
		let urlImage: String?
		let breedName: String
		let breedCategory: String
		let origin: String
		let temperament: String
	}
	
	private lazy var imageView = UIImageView()
	
	private lazy var breedNameLabel = UILabel()
	private lazy var breedNameValueLabel = UILabel()
	
	private lazy var breedCategoryLabel = UILabel()
	private lazy var breedCategoryValueLabel = UILabel()
	
	private lazy var originLabel = UILabel()
	private lazy var originValueLabel = UILabel()
	
	private lazy var temperamentLabel = UILabel()
	private lazy var temperamentValueLabel = UILabel()
	
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
		if let urlPhoto = URL(string: model?.urlImage ?? String()) {
			imageView.kf.setImage(with: urlPhoto)
			}
		}

		breedNameValueLabel.text = model?.breedName
		breedCategoryValueLabel.text = model?.breedCategory
		originValueLabel.text = model?.origin
		temperamentValueLabel.text = model?.temperament
	}
}

extension DetailView: ViewCodeConfiguration {
	func buildHierarchy() {
		imageView.setViewIsCodable()
		addSubview(imageView)
		
		breedNameLabel.setViewIsCodable()
		addSubview(breedNameLabel)
		
		breedNameValueLabel.setViewIsCodable()
		addSubview(breedNameValueLabel)
		
		breedCategoryLabel.setViewIsCodable()
		addSubview(breedCategoryLabel)
		
		breedCategoryValueLabel.setViewIsCodable()
		addSubview(breedCategoryValueLabel)
		
		originLabel.setViewIsCodable()
		addSubview(originLabel)
		
		originValueLabel.setViewIsCodable()
		addSubview(originValueLabel)
		
		temperamentLabel.setViewIsCodable()
		addSubview(temperamentLabel)
		
		temperamentValueLabel.setViewIsCodable()
		addSubview(temperamentValueLabel)
	}
	
	func setupContraints() {
		let imageViewConstraints = [
			imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
										   constant: 20),
			imageView.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor,
											   constant: 8),
			imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
												constant: -8),
			imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			imageView.heightAnchor.constraint(equalToConstant: 120),
			imageView.widthAnchor.constraint(equalToConstant: 120)
		]
		
		let breedNameLabelConstraints = [
			breedNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
												constant: 16),
			breedNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
													constant: 8),
			breedNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
													 constant: -8)
		]
		
		let breedNameValueLabelConstraints = [
			breedNameValueLabel.topAnchor.constraint(equalTo: breedNameLabel.bottomAnchor,
													 constant: 16),
			breedNameValueLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
														 constant: 8),
			breedNameValueLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
														  constant: -8)
		]
		
		let breedCategoryLabelConstraints = [
			breedCategoryLabel.topAnchor.constraint(equalTo: breedNameValueLabel.bottomAnchor,
													constant: 16),
			breedCategoryLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
														constant: 8),
			breedCategoryLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
														 constant: -8)
		]
		
		let breedCategoryValueLabelConstraints = [
			breedCategoryValueLabel.topAnchor.constraint(equalTo: breedCategoryLabel.bottomAnchor,
														 constant: 16),
			breedCategoryValueLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
															 constant: 8),
			breedCategoryValueLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
															  constant: -8)
		]
		
		let originLabelConstraints = [
			originLabel.topAnchor.constraint(equalTo: breedCategoryValueLabel.bottomAnchor,
											 constant: 16),
			originLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
												 constant: 8),
			originLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
												  constant: -8)
		]
		
		let originValueLabelConstraints = [
			originValueLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor,
												  constant: 16),
			originValueLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
													  constant: 8),
			originValueLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
													   constant: -8)
		]
		
		let temperamentLabelConstraints = [
			temperamentLabel.topAnchor.constraint(equalTo: originValueLabel.bottomAnchor,
												  constant: 16),
			temperamentLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
													  constant: 8),
			temperamentLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
													   constant: -8)
		]
		
		let temperamentValueLabelConstraints = [
			temperamentValueLabel.topAnchor.constraint(equalTo: temperamentLabel.bottomAnchor,
													   constant: 16),
			temperamentValueLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
														   constant: 8),
			temperamentValueLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
															constant: -8),
			temperamentValueLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor,
														  constant: -8)
		]
		
		NSLayoutConstraint.activate(imageViewConstraints + breedNameLabelConstraints + breedNameValueLabelConstraints + breedCategoryLabelConstraints + breedCategoryValueLabelConstraints + originLabelConstraints + originValueLabelConstraints + temperamentLabelConstraints + temperamentValueLabelConstraints)
	}
	
	func configureViews() {
		backgroundColor = .white
		
		imageView.contentMode = .scaleAspectFit

		breedNameLabel.text = "Breed:"
		breedNameLabel.textAlignment = .left
		breedNameLabel.font = .systemFont(ofSize: 24)
		breedNameLabel.numberOfLines = .zero

		breedNameValueLabel.font = .systemFont(ofSize: 16)
		breedNameValueLabel.textAlignment = .right
		breedNameValueLabel.numberOfLines = .zero
		
		breedCategoryLabel.text = "Category:"
		breedCategoryLabel.textAlignment = .left
		breedCategoryLabel.font = .systemFont(ofSize: 24)
		breedCategoryLabel.numberOfLines = .zero
		
		breedCategoryValueLabel.textAlignment = .right
		breedCategoryValueLabel.font = .systemFont(ofSize: 16)
		breedCategoryValueLabel.numberOfLines = .zero

		originLabel.text = "Origin:"
		originLabel.textAlignment = .left
		originLabel.font = .systemFont(ofSize: 24)
		originLabel.numberOfLines = .zero
		
		originValueLabel.font = .systemFont(ofSize: 16)
		originValueLabel.textAlignment = .right
		originValueLabel.numberOfLines = .zero

		temperamentLabel.text = "Temperament:"
		temperamentLabel.font = .systemFont(ofSize: 24)
		temperamentLabel.textAlignment = .left
		temperamentLabel.numberOfLines = .zero

		temperamentValueLabel.font = .systemFont(ofSize: 16)
		temperamentValueLabel.textAlignment = .right
		temperamentValueLabel.numberOfLines = .zero
	}
}

struct LoadingViewPreview: PreviewProvider {
	static var previews: some View {
		UIViewPreview {
			DetailView()
		}
	}
}

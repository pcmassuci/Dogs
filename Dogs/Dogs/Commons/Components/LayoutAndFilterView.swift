//
//  LayoutAndFilterView.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import UIKit

protocol LayoutAndFilterViewDelegate: AnyObject {
	
	func layoutAndFilterView(_ view: LayoutAndFilterView, orderIsSelected: LayoutAndFilterView.Alphabetic)
	
	func layoutAndFilterView(_ view: LayoutAndFilterView, layoutIsSelected: LayoutAndFilterView.LayoutFormat)
}

final class LayoutAndFilterView: UIView {
	enum Alphabetic {
		case ascending
		case descending
	}
	
	enum LayoutFormat {
		case list
		case grid
	}
	
	private(set) var alphabeticState: Alphabetic = .ascending {
		didSet {
			alphabeticButton.setImage(alphabeticState.getImage(),
								  for: .normal)

			delegate?.layoutAndFilterView(self,
										  orderIsSelected: alphabeticState)
		}
	}
	
	private(set) var layoutFormatState: LayoutFormat = .list {
		didSet {
			layoutButton.setImage(layoutFormatState.getImage(),
								  for: .normal)
			delegate?.layoutAndFilterView(self,
										  layoutIsSelected: layoutFormatState)
		}
	}
	
	weak var delegate: LayoutAndFilterViewDelegate?
	
	private lazy var alphabeticButton = UIButton()
	private lazy var layoutButton = UIButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		applyViewCode()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc
	private func alphabeticButtonSelected() {
		switch alphabeticState {
		case .ascending:
			alphabeticState = .descending
		case .descending:
			alphabeticState = .ascending
		}
	}
	
	@objc
	private func layoutButtonSelected() {
		switch layoutFormatState {
		case .list:
			layoutFormatState = .grid
		case .grid:
			layoutFormatState = .list
		}
	}
}

extension LayoutAndFilterView: ViewCodeConfiguration {
	func buildHierarchy() {
		alphabeticButton.setViewIsCodable()
		addSubview(alphabeticButton)
		
		layoutButton.setViewIsCodable()
		addSubview(layoutButton)
	}
	
	func setupContraints() {
		let alphabeticButtonConstraints = [
			alphabeticButton.topAnchor.constraint(equalTo: topAnchor,
												  constant: 8),
			alphabeticButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,
													 constant: -8),
			alphabeticButton.leadingAnchor.constraint(equalTo: leadingAnchor,
													  constant: 20),
			alphabeticButton.heightAnchor.constraint(equalToConstant: 40)
		]
		
		let layoutButtonConstraints = [
			layoutButton.topAnchor.constraint(equalTo: topAnchor,
											  constant: 8),
			layoutButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,
												 constant: -8),
			layoutButton.leadingAnchor.constraint(greaterThanOrEqualTo: alphabeticButton.trailingAnchor,
												  constant: 8),
			layoutButton.trailingAnchor.constraint(equalTo: trailingAnchor,
												   constant: -20),
			layoutButton.heightAnchor.constraint(equalToConstant: 40)
		]
		
		NSLayoutConstraint.activate(alphabeticButtonConstraints + layoutButtonConstraints)
	}
	
	func configureViews() {
		backgroundColor = .white
		layoutButton.setImage(layoutFormatState.getImage(),
							  for: .normal)
		
		layoutButton.addTarget(self,
							   action: #selector(layoutButtonSelected),
							   for: .touchUpInside)
		alphabeticButton.setImage(alphabeticState.getImage(),
								  for: .normal)
		alphabeticButton.addTarget(self,
								   action: #selector(alphabeticButtonSelected),
								   for: .touchUpInside)
	}
}

extension LayoutAndFilterView.Alphabetic {
	func getImage() -> UIImage? {
		switch self {
		case .ascending:
			return UIImage(named: "alpha_desc")
		case .descending:
			return UIImage(named: "alpha_asc")
		}
	}
}

extension LayoutAndFilterView.LayoutFormat {
	func getImage() -> UIImage? {
		switch self {
		case .list:
			return UIImage(named: "grid")
		case .grid:
			return UIImage(named: "list")
		}
	}
}

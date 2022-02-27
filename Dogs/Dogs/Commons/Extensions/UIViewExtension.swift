//
//  UIViewExtension.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import UIKit

extension UIView {
	
	func strach(_ view: UIView?) {
		guard let view = view else { return }
		view.setViewIsCodable()
		addSubview(view)
		let constraints = [
			view.topAnchor.constraint(equalTo: topAnchor),
			view.topAnchor.constraint(equalTo: bottomAnchor),
			view.leadingAnchor.constraint(equalTo: leadingAnchor),
			view.trailingAnchor.constraint(equalTo: trailingAnchor)
		]
		
		NSLayoutConstraint.activate(constraints)
	}
	
	func setViewIsCodable() {
		translatesAutoresizingMaskIntoConstraints = false
	}
}

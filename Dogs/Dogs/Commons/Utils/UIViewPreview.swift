//
//  UIViewPreview.swift
//  Dogs
//
//  Created by ACT on 28/02/22.
//

import SwiftUI

struct UIViewPreview<View: UIView>: UIViewRepresentable {
let view: View
init(_ builder: @escaping () -> View) {
		view = builder()
	}
func makeUIView(context: Context) -> View {
return view
	}
func updateUIView(_ uiView: View, context: Context) {
		uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
	}
}

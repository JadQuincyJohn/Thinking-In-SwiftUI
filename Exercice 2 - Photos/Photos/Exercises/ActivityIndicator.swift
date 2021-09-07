//
//  ActivityIndicator.swift
//  Photos
//
//  Created by Abi-Abdallah Jad on 29/07/2021.
//

import SwiftUI


struct ActivityIndicator: UIViewRepresentable {
	
	let style: UIActivityIndicatorView.Style
	@Binding var animating: Bool
	
	func makeUIView(context: Context) -> UIActivityIndicatorView {
		UIActivityIndicatorView(style: style)
	}
	
	func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
		if animating {
			uiView.startAnimating()
		} else {
			uiView.stopAnimating()
		}
	}
}

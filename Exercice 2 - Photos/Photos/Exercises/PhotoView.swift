//
//  PhotoView.swift
//  Photos
//
//  Created by Abi-Abdallah Jad on 29/07/2021.
//

import SwiftUI
import UIKit

struct PhotoView: View {
	
	@ObservedObject var image: Remote<UIImage>
	
	let aspectRatio: CGFloat
	
	init(url: URL, aspectRatio: CGFloat) {
		image = Remote(url: url, transform: {
			UIImage(data: $0)
		})
		self.aspectRatio = aspectRatio
	}
	
	var imageOrPlaceholder: Image {
		image.value.map(Image.init) ?? Image(systemName: "photo")
	}
		
    var body: some View {
		
		ZStack {
			imageOrPlaceholder
				.resizable()
				.foregroundColor(.secondary)
				.aspectRatio(aspectRatio, contentMode: .fit)
				.padding()
				.onAppear { image.loadData() }
				.onDisappear { image.cancel() }
			
			ActivityIndicator(style: .large, animating: .constant(image.value == nil))
		}
    }
}

//
//  PhotoView.swift
//  Photos
//
//  Created by Abi-Abdallah Jad on 29/07/2021.
//

import SwiftUI

struct ListView: View {
		
	@ObservedObject var items = Remote<[Photo]>(url: URL(string: "https://picsum.photos/v2/list")!) {
		try? JSONDecoder().decode([Photo].self, from: $0)
	}
		
    var body: some View {
		NavigationView {
			if items.value == nil {
				ActivityIndicator(style: .large, animating: .constant(true))
					.onAppear {
						items.loadData()
					}
			} else {
				List {
					ForEach(items.value!) { photo in
						let photoView = PhotoView(url: photo.download_url, aspectRatio: photo.ratio)
						NavigationLink(destination: photoView, label: {
							PhotoListItem(photo: photo)
						})
					}
				}
				.navigationBarTitle("Photos")
			}
		}
    }
}

struct PhotoListItem: View {
	let photo: Photo
	@ObservedObject var thumbnailResource: Remote<Image>

	init(photo: Photo) {
		self.photo = photo
		self.thumbnailResource = Remote(url: photo.thumbnailURL, transform: {
			Image(uiImage: UIImage(data: $0)!)
		})
	}

	var body: some View {
		HStack {
			Group {
				if thumbnailResource.value != nil {
					thumbnailResource.value!
						.resizable()
				} else {
					ZStack {
						Color(UIColor.secondarySystemBackground)
						ActivityIndicator(style: .medium, animating: .constant(true))
					}
				}
			}
			.frame(width: 44, height: 44)
			.cornerRadius(8)
			Text(photo.author)
		}
		.onAppear {
			thumbnailResource.loadData()
		}
		.onDisappear {
			thumbnailResource.cancel()
		}

	}
}


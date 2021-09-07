//
//  Photo.swift
//  Photos
//
//  Created by Abi-Abdallah Jad on 29/07/2021.
//

import Foundation
import CoreGraphics
import UIKit

struct Photo: Codable, Identifiable {
	var id: String
	var author: String
	var width, height: CGFloat
	let url, download_url: URL
}

extension Photo {
	var thumbnailURL: URL {
		let size = Int(44 * UIScreen.main.scale)
		let url = URL(string: "https://picsum.photos/id/\(id)/\(size)/\(size)")!
		return url
	}
	
	var ratio: CGFloat {
		width / height
	}
}

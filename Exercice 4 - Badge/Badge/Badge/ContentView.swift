//
//  ContentView.swift
//  Badge
//
//  Created by Abi-Abdallah Jad on 09/09/2021.
//

import SwiftUI

struct ContentView: View {
	
	let count: Int
	var badgeAlignment: Alignment = .topTrailing
	var size: CGFloat = 24
	var color: Color = Color.orange
	
    var body: some View {
        Text("Hello, world!")
			.font(.headline)
			.padding(10)
			.background(Color.green)
			.badge(count: count, size: size, alignment: badgeAlignment, color: color)
    }
}

extension View {
	
	func badge(count: Int, size: CGFloat, alignment: Alignment, color: Color) -> some View {
		
		let xOffset = (alignment == .topTrailing) ? size / 2 : (size / 2) * -1
		let yOffset = (alignment == .topLeading) ? (size / 2) * -1 :  (size / 2) * -1
		
		return overlay(
			ZStack {
				if count > 0 {
					Circle().fill(color)
					Text(String(count))
						.font(.caption)
						.foregroundColor(Color.white)
				}
			}
			.frame(width: size, height: size)
			.offset(x: xOffset, y: yOffset)
		, alignment: alignment)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		
		Group {
			ContentView(count: 5)
			ContentView(count: 0)
		}
	}
}

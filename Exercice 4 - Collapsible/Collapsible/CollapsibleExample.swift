//
//  ContentView.swift
//  Layout
//
//  Created by Abi-Abdallah Jad on 09/09/2021.
//

import SwiftUI

struct CollapsibleExample: View {
	@State private var expanded = true
	
    var body: some View {
		
		Group {
			Collapsible(data: [Color.red,Color.blue,Color.green], expanded: expanded) { color in
				Rectangle().fill(color)
			}
			Collapsible(data: [30,90,120], expanded: expanded) { width in
				Rectangle()
					.fill(Color.yellow)
					.frame(width: width, height: width, alignment: .center)
					
			}
			Collapsible(data: ["Holà","Mi","Alma"], expanded: expanded) { word in
				Text(word)
					.font(.title)
			}
			Toggle("Expanded", isOn: $expanded)
				.padding()
		}
    }
}

struct Collapsible<Element, Content: View>: View  {
	var data: [Element]
	var expanded: Bool = false
	var content: (Element) -> Content
	var verticalAlignment: VerticalAlignment = .center
	var spacing: CGFloat = 0
	var collapsedWidth: CGFloat = 0

	func child(at index: Int) -> some View {
		let showExpanded = expanded || index == self.data.endIndex - 1
		return content(data[index])
			.frame(width: showExpanded ? nil : collapsedWidth, alignment: .leading)
	}
	
	var body: some View {
		HStack(alignment: verticalAlignment, spacing: self.spacing) {
			ForEach(data.indices, content: { self.child(at: $0) })
		}
		.border(Color.orange)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		CollapsibleExample()
	}
}

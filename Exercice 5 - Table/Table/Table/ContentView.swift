//
//  ContentView.swift
//  Table
//
//  Created by Abi-Abdallah Jad on 10/09/2021.
//

import SwiftUI

struct ContentView: View {
	
	var cells = [
	[Text(""), Text("Monday").bold(), Text("Tuesday").bold(),
	Text("Wednesday").bold()],
	[Text("Berlin").bold(), Text("Cloudy"), Text("Mostly\nSunny"), Text("Sunny")],
	[Text("London").bold(), Text("Heavy Rain"), Text("Cloudy"), Text("Sunny")],
	]
	
    var body: some View {
		Table(cells: cells)
			.font(Font.system(.body, design: .serif))
    }
}


struct Table: View {
	
	let cells: [[Text]]
	
	func cell(for row: Int, column: Int) -> some View {
		cells[row][column]
	}
	
	var body: some View {
		
		VStack {
			ForEach(cells.indices) { row in
				HStack {
					ForEach(cells.indices) { column in
						cell(for: row, column: column)
					}
				}
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

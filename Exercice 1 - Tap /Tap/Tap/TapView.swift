//
//  ContentView.swift
//  Photos
//
//  Created by Abi-Abdallah Jad on 28/07/2021.
//

import SwiftUI

struct TapView: View {
	
	@State var counter = 0
	
	var body: some View {
		
		NavigationView {
			VStack {
				Button("Tap me!") {
					counter += 1
				}
				.padding()
				.background(Color(.tertiarySystemFill))
				.cornerRadius(5)
				
				if counter > 0 {
					Text("You tapped \(counter) times")
				} else {
					Text("Not tapped yet")
				}
			}
			.navigationBarTitle("Tap me!")
			//.debug()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		TapView()
	}
}

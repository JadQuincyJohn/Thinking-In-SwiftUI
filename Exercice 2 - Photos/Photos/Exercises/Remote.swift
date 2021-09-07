//
//  Remote.swift
//  Photos
//
//  Created by Abi-Abdallah Jad on 29/07/2021.
//

import Combine
import Foundation
import UIKit

struct LoadingError: Error {}


final class Remote<T>: ObservableObject {
		
	@Published var result: Result<T, Error>? = nil
	
	private let session: URLSession = URLSession.shared
	private let cache: URLCache?
	
	var value: T? {
		try? result?.get()
	}
	
	let url: URL
	let transform: (Data) -> T?
	
	private var cancellable: AnyCancellable?
	
	init(url: URL, cache: URLCache? = .shared, transform: @escaping (Data) -> T?) {
		self.url = url
		self.cache = cache
		self.transform = transform
		//self.loadData()
	}
	
	func loadData() {
		
		cancellable = responsePublisher
			.handleEvents(receiveOutput: { [weak self] data, response in
				self?.storeCachedResponse(data: data, response: response)
			})
			.map({ [weak self] data, response -> T? in
				self?.transform(data)
			})
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] _ in
				
			}, receiveValue: { [weak self] value in
				if let value = value {
					self?.result = .success(value)
				} else {
					self?.result = .failure(LoadingError())
				}
			})
	}
	
	func cancel() {
		cancellable?.cancel()
		cancellable = nil
	}
	
	private func storeCachedResponse(data: Data, response: URLResponse) {
		let cachedResponse = CachedURLResponse(response: response, data: data)
		cache?.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
		//print("Storing cache for \(self.url)")
	}
	
	private var responsePublisher: AnyPublisher<(data: Data, response: URLResponse), URLError> {
		let request = URLRequest(url: url)
		
		if let cachedResponse = cache?.cachedResponse(for: request) {
			//print("Retrevied data from cache for \(self.url)")
			return Just((data: cachedResponse.data, response: cachedResponse.response))
				.setFailureType(to: URLError.self)
				.eraseToAnyPublisher()
		} else {
			//print("Requesting data for \(url)")
			return URLSession.shared.dataTaskPublisher(for: request)
				.eraseToAnyPublisher()
		}
	}
}

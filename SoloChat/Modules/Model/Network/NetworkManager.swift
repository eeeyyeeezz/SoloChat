//
//  ImageLoader.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

final class NetworkManager {
	
	/// Счетчик offset для иттерации по API
	private static var offsetCounter = 0
	
	private static let cache = NSCache<NSString, UIImage>()

	// Переделать на тот что снизу
	static func loadImageFromURL(completion: @escaping (DownloadResult) -> Void) {
		let links = ["https://sun9-10.userapi.com/impg/anSpvCioEPxnPyGSNiGp8WF2o0UUbyI__t5CUg/-HX97gplAak.jpg?size=807x454&quality=96&sign=17fc241d7a1b40329295034eb6912fde&type=album"]
		
		
		// Берется рандомный элемент с той логикой что в links возможно добавить другие значения для расширения функционала
		guard let url = URL(string: links.randomElement() ?? "") else {
			completion(.failure(nil))
			return
		}

		if let cachedImage = NetworkManager.cache.object(forKey: url.absoluteString as NSString) {
			completion(.success(cachedImage))
		} else {
			URLSession.shared.dataTask(with: url) { (data, response, error) in
				guard let httpResponse = response as? HTTPURLResponse,
					  httpResponse.statusCode == 200,
					  let data = data,
					  error == nil else {
					completion(.failure(error))
					return
				}
				
				if let image = UIImage(data: data) {
					NetworkManager.cache.setObject(image, forKey: url.absoluteString as NSString)
					completion(.success(image))
				} else {
					completion(.failure(nil))
				}
			}.resume()
		}
		
	}
	
	static func parseAPI(completionHandler: @escaping (Result<MessageStruct, Error>) -> Void) {
		debugPrint("OFFSET COUNTER \(NetworkManager.offsetCounter)")
		guard let url = URL(string: "https://numia.ru/api/getMessages?offset=\(offsetCounter)")
		else {
			debugPrint("ERROR")
			return
		}
		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
				return
			}
			guard let data = data else {
				let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data not found"])
				completionHandler(.failure(error))
				return
			}
			
			do {
				let message = try JSONDecoder().decode(MessageStruct.self, from: data)
				/// При успешном респонс повышать значение на +1 для следующей иттерации
				NetworkManager.offsetCounter += 1
				completionHandler(.success(message))
			} catch {
				completionHandler(.failure(error))
			}
		}.resume()
	}

	
}

//
//  ImageLoader.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

final class ImageLoader {
	
	private static let cache = NSCache<NSString, UIImage>()

	static func loadImageFromURL(completion: @escaping (DownloadResult) -> Void) {
		let links = ["https://sun9-10.userapi.com/impg/anSpvCioEPxnPyGSNiGp8WF2o0UUbyI__t5CUg/-HX97gplAak.jpg?size=807x454&quality=96&sign=17fc241d7a1b40329295034eb6912fde&type=album"]
		
		
		// Берется рандомный элемент с той логикой что в links возможно добавить другие значения для расширения функционала
		guard let url = URL(string: links.randomElement() ?? "") else {
			completion(.failure(nil))
			return
		}

		if let cachedImage = ImageLoader.cache.object(forKey: url.absoluteString as NSString) {
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
					ImageLoader.cache.setObject(image, forKey: url.absoluteString as NSString)
					completion(.success(image))
				} else {
					completion(.failure(nil))
				}
			}.resume()
		}
		
	}

	
}

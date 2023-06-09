//
//  ImageLoader.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

enum DownloadResult {
	case success(UIImage)
	case failure(Error?)
}

final class ImageLoader {
	
	private static let cache = NSCache<NSString, UIImage>()

	static func loadImageFromURL(completion: @escaping (DownloadResult) -> Void) {
		let links = [//"https://memepedia.ru/wp-content/uploads/2020/03/kachok-s-noutbukom-mem-5.jpg",
//							 "https://krot.info/uploads/posts/2023-04/1681312940_krot-info-p-kachok-za-kompom-oboi-5.jpg",
//							 "https://krot.info/uploads/posts/2023-04/1680709297_krot-info-p-kachok-za-noutbukom-vkontakte-9.jpg",
//							 "https://kartinkof.club/uploads/posts/2022-03/1648279879_21-kartinkof-club-p-kachok-za-kompom-mem-23.jpg",
							 //"https://r2.mt.ru/r17/photo905F/20484921682-0/jpg/bp.webp",
							 "https://sun9-10.userapi.com/impg/anSpvCioEPxnPyGSNiGp8WF2o0UUbyI__t5CUg/-HX97gplAak.jpg?size=807x454&quality=96&sign=17fc241d7a1b40329295034eb6912fde&type=album"]
		
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

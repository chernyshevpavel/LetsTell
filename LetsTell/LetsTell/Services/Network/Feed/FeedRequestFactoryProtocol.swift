//
//  FeedRequestFactoryProtocol.swift
//  LetsTell
//
//  Created by Павел Чернышев on 02.04.2021.
//

import Foundation
import Alamofire

struct FeedRequestFilters: Codable {
    var languageId: Int?
    var genreId: Int?
    
    enum CodingKeys: String, CodingKey {
        case languageId = "language_id"
        case genreId = "genre_id"
    }
}

protocol FeedRequestFactoryProtocol {
    func get(page: Int, filters: FeedRequestFilters?, complition: @escaping (AFDataResponse<FeedResponse>) -> Void)
}

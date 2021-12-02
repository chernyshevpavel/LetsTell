//
//  Story.swift
//  LetsTell
//
//  Created by Павел Чернышев on 01.04.2021.
//

import Foundation
import UIKit

struct Story: Codable, Identifiable, Hashable {
    let ownRate: Int?
  //  let rate: Int
   // let rates: [Rate]
    let authorsCount: Int
    let authorshipAccess: Access
    let authorshipAccessID: Int
    let availableToWrite, censorship: Bool
    let createdAt: String
    let firstStep: StoryStep
    let genre: Genre
    let genreID: Int
    let id: String
    let isAuthor: Bool
    let language: Language
    let languageID: Int
    let storyCreator: StoryCreator
    let lastStep: StoryStep
    let narrativeType: Genre
    let narrativeTypeID: Int
    let readAccess: Access
    let readAccessID: Int
    let readDuration: String
    let statusID, steps: Int
    let tags: [String]
    let title: String
    let cover, coverFull: String?
    
    // MARK: - Non server response fields
    var image: UIImage?
    var isImageLoading: Bool = true
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case ownRate = "own_rate"
        //case rate, rates
        case authorsCount = "authors_count"
        case authorshipAccess = "authorship_access"
        case authorshipAccessID = "authorship_access_id"
        case availableToWrite = "available_to_write"
        case censorship
        case createdAt = "created_at"
        case firstStep = "first_step"
        case genre
        case genreID = "genre_id"
        case id
        case isAuthor = "is_author"
        case language
        case languageID = "language_id"
        case lastStep = "last_step"
        case storyCreator = "master"
        case narrativeType = "narrative_type"
        case narrativeTypeID = "narrative_type_id"
        case readAccess = "read_access"
        case readAccessID = "read_access_id"
        case readDuration = "read_duration"
        case statusID = "status_id"
        case steps, tags, title, cover
        case coverFull = "cover_full"
    }
}

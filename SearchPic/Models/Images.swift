//
//  Images.swift
//  SearchPic
//
//  Created by Сергей Юханов on 06.02.2023.
//

import Foundation

// MARK: - Images
struct Images: Codable {
    let searchMetadata: SearchMetadata
    let searchParameters: SearchParameters
    let searchInformation: SearchInformation
    let suggestedSearches: [SuggestedSearch]
    let imagesResults: [ImagesResult]

    enum CodingKeys: String, CodingKey {
        case searchMetadata = "search_metadata"
        case searchParameters = "search_parameters"
        case searchInformation = "search_information"
        case suggestedSearches = "suggested_searches"
        case imagesResults = "images_results"
    }
}

// MARK: - ImagesResult
struct ImagesResult: Codable {
    let position: Int
    let thumbnail: String
    let source: String
    let title: String
    let link: String
    let original: String
    let originalWidth: Int
    let originalHeight: Int
    let isProduct: Bool
    let inStock: Bool?

    enum CodingKeys: String, CodingKey {
        case position = "position"
        case thumbnail = "thumbnail"
        case source = "source"
        case title = "title"
        case link = "link"
        case original = "original"
        case originalWidth = "original_width"
        case originalHeight = "original_height"
        case isProduct = "is_product"
        case inStock = "in_stock"
    }
}

// MARK: - SearchInformation
struct SearchInformation: Codable {
    let imageResultsState: String
    let queryDisplayed: String
    let menuItems: [MenuItem]

    enum CodingKeys: String, CodingKey {
        case imageResultsState = "image_results_state"
        case queryDisplayed = "query_displayed"
        case menuItems = "menu_items"
    }
}

// MARK: - MenuItem
struct MenuItem: Codable {
    let position: Int
    let title: String
    let link: String?
    let serpapiLink: String?

    enum CodingKeys: String, CodingKey {
        case position = "position"
        case title = "title"
        case link = "link"
        case serpapiLink = "serpapi_link"
    }
}

// MARK: - SearchMetadata
struct SearchMetadata: Codable {
    let id: String
    let status: String
    let jsonEndpoint: String
    let createdAt: String
    let processedAt: String
    let googleURL: String
    let rawHTMLFile: String
    let totalTimeTaken: Double

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case status = "status"
        case jsonEndpoint = "json_endpoint"
        case createdAt = "created_at"
        case processedAt = "processed_at"
        case googleURL = "google_url"
        case rawHTMLFile = "raw_html_file"
        case totalTimeTaken = "total_time_taken"
    }
}

// MARK: - SearchParameters
struct SearchParameters: Codable {
    let engine: String
    let q: String
    let googleDomain: String
    let ijn: String
    let device: String
    let tbm: String

    enum CodingKeys: String, CodingKey {
        case engine = "engine"
        case q = "q"
        case googleDomain = "google_domain"
        case ijn = "ijn"
        case device = "device"
        case tbm = "tbm"
    }
}

// MARK: - SuggestedSearch
struct SuggestedSearch: Codable {
    let name: String
    let link: String
    let chips: String
    let serpapiLink: String
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case link = "link"
        case chips = "chips"
        case serpapiLink = "serpapi_link"
        case thumbnail = "thumbnail"
    }
}

//
//  CoinAPIError.swift
//  NetWorking
//
//  Created by MacBook Air on 24/09/2024.
//

import Foundation

enum CoinAPIError: Error {
    case jsonParsingFailure
    case invalidData
    case requestFailed(description: String)
    case invalidStatusCode(Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .jsonParsingFailure:
            return "JSON parsing failed"
        case .invalidData:
            return "Invalid data"
        case let .requestFailed(description):
            return "Request Failed: \(description)"
        case let .invalidStatusCode(statusCode):
            return "Invalid status Code: \(statusCode)"
        case let .unknownError(error):
            return "Unknown error occurred: \(error.localizedDescription)"
        }
    }
}

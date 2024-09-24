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
    case invalidHTTPStatus(Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .jsonParsingFailure:
            return "JSON parsing failed"
        case .invalidData:
            return "Invalid data"
        case .requestFailed(description: let description):
            return "Request Failed: \(description)"
        case .invalidHTTPStatus(let status):
            return "Invalid HTTP status: \(status)"
        case .unknownError(error: let error):
            return "Unknown error occurred: \(error.localizedDescription)"
        }
    }
}

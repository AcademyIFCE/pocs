//
//  DecodeError.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 24/08/22.
//

import Foundation

enum DecodeError: Error, LocalizedError {
    case errorWhileDecodingJson
    
    var errorDescription: String? {
        switch self {
        case .errorWhileDecodingJson:
                return "Erro no processamento das informações"
        }
    }
}

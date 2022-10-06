//
//  HttpError.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 24/08/22.
//

import Foundation

enum HTTPError: Error {
       case transportError(Error)
       case serverSideError(Int)
}

//
//  RequestError.swift
//  student568908
//
//  Created by user180971 on 10/12/20.
//

import Foundation

enum RequestError: Error {
    case urlError(URLError)
    case decodingError(DecodingError)
    case genericError(Error)
}

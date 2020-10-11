//
//  NewsReaderAPI.swift
//  student568908
//
//  Created by user180971 on 10/11/20.
//

import Foundation
import Combine
import KeychainAccess

final class NewsReaderAPI: ObservableObject {
    static let shared = NewsReaderAPI()
    
    @Published var isAuthenticated: Bool = false
    
    private let keychain = Keychain()
    private var accessTokenKeychainKey = "accessToken"
    
    private var cancellable: AnyCancellable?
    
    var accessToken: String? {
        get {
            try? keychain.get(accessTokenKeychainKey)
        }
        set(newValue) {
            guard let accessToken = newValue else {
                try? keychain.remove(accessTokenKeychainKey)
                isAuthenticated = false
                return
            }
            try? keychain.set(accessToken, key: accessTokenKeychainKey)
            isAuthenticated = true
        }
    }
    
    private init() {
        isAuthenticated = accessToken != nil
    }
    
    func login(
        username: String,
        password: String,
        completion: @escaping (Result<LoginResponse, RequestError>) -> Void
    ) {
        let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Users/login")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        
        let parameters = LoginRequest (
            username: username,
            password: password
        )
        
        let encoder = JSONEncoder()
        guard let body = try? encoder.encode(parameters) else { return }
        urlRequest.httpBody = body
        
        cancellable = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (result) in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                        case let urlError as URLError:
                            completion(.failure(.urlError(urlError)))
                        case let decodingError as DecodingError:
                            completion(.failure(.decodingError(decodingError)))
                        default:
                            completion(.failure(.genericError(error)))
                    }
                }
            }, receiveValue: { (resonse) in
                completion(.success(resonse))
            })
    }
    
    func logout() {
        accessToken = nil
    }
}


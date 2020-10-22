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
//final class NewsReaderAPI {
    static let shared = NewsReaderAPI()
    private let baseURL = "https://inhollandbackend.azurewebsites.net/api"
    
    @Published var isAuthenticated: Bool = false
    
    private let keychain = Keychain()
    private var accessTokenKeychainKey = "accessToken"
    
    private var cancellables: Set<AnyCancellable> = []
    
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
    
    
    // (POST)Users/register
    func register(
        username: String,
        password: String,
        completion: @escaping (Result<RegisterResponse, RequestError>) -> Void
    ) {
        let fullurl: String = baseURL + "/Users/register"
        let url = URL(string: fullurl)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        
        let parameters = RegisterRequest (
            username: username,
            password: password
        )
        
        let encoder = JSONEncoder()
        guard let body = try? encoder.encode(parameters) else { return }
        urlRequest.httpBody = body
        
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: RegisterResponse.self, decoder: JSONDecoder())
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
            .store(in: &cancellables)

    }
    
    // (POST)Users/login
    func login(
        username: String,
        password: String,
        completion: @escaping (Result<LoginResponse, RequestError>) -> Void
    ) {
        print(username + " " + password)
        let fullurl: String = baseURL + "/Users/login"
        let url = URL(string: fullurl)!
        
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
        
        URLSession.shared.dataTaskPublisher(for: urlRequest)
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
            .store(in: &cancellables)
    }
    
    func logout() {
        print("test logout")
        accessToken = nil
    }
    
    // (GET)Feeds
    func getFeeds(completion: @escaping (Result<[Feeds], RequestError>) -> Void) {
        let url = URL(string: baseURL + "/Feeds")!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
//        print(urlRequest.allHTTPHeaderFields?.values)
        
    }
    
    
    // (GET)Articles
    func getArticles(completion: @escaping (Result<[Articles], RequestError>) -> Void) {
        let fullurl: String = baseURL + "/Articles"
        let url = URL(string: fullurl)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        
        cancellable = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map({ $0.data })
            .decode(type: GetArticleResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
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
            }) { response in
                completion(.success(response.articles))
            }
    }
    
    
    
    
    
    
    
    
    func getArticle(completion: @escaping (Result<[Articles], RequestError>) -> Void) {
        let url = URL(string: baseURL + "/Articles")!
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map({ $0.data })
            .decode(type: GetArticleResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
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
            }) { response in
<<<<<<< Updated upstream
=======
                print(response.articles)
>>>>>>> Stashed changes
                completion(.success(response.articles))
            }
            .store(in: &cancellables)
    }
    
}


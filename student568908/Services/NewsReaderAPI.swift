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
    private let baseURL = "https://inhollandbackend.azurewebsites.net/api"
    
    @Published var isAuthenticated: Bool = false
    @Published var articles: [Articles] = []
    @Published var favorites: [Articles] = []
    
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
        let url = URL(string: baseURL + "/Users/register")!
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
            }, receiveValue: { (response) in
                completion(.success(response))
            })
            .store(in: &cancellables)
    }
    
    // (POST)Users/login
    func login(
        username: String,
        password: String,
        completion: @escaping (Result<LoginResponse, RequestError>) -> Void
    ) {
        let url = URL(string: baseURL + "/Users/login")!
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
            }, receiveValue: { (response) in
                completion(.success(response))
            })
            .store(in: &cancellables)
    }
    
    func logout() {
        accessToken = nil
    }
    
    // (GET)Feeds
    func getFeeds(completion: @escaping (Result<[Feed], RequestError>) -> Void) {
        let url = URL(string: baseURL + "/Feeds")!
        var urlrequest = URLRequest(url: url)
        
        urlrequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlrequest.httpMethod = "GET"
    }
    
    
    // (GET)Articles
    func getArticles(completion: @escaping (Result<[Articles], RequestError>) -> Void) {
        let fullurl: String = baseURL + "/Articles"
        let url = URL(string: fullurl)!
        var urlRequest = URLRequest(url: url)
        if accessToken != nil {
            urlRequest.setValue(accessToken, forHTTPHeaderField: "x-authtoken")
        }
        
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map({ $0.data })
            .decode(type: ArticleResponse.self, decoder: JSONDecoder())
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
                    print(error)
                }
            }) { response in
                completion(.success(response.articles))
            }
            .store(in: &cancellables)
    }
    
    
    // (PUT)Article/{id}//like
    func likeArticle(withId id: Int, completion: @escaping (Result<Data, RequestError>) -> Void) {
        let url = URL(string: baseURL + "/Articles/\(id)//like")!
        print("article id = \(id)")
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue(accessToken, forHTTPHeaderField: "x-authtoken")
      
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: Data.self, decoder: JSONDecoder())
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
            }, receiveValue: { (response) in
            })
            .store(in: &cancellables)
    }
    
    
    // (DELETE)Article/{id}//like
    func unlikeArticle(withId id: Int, completion: @escaping (Result<Data, RequestError>) -> Void) {
        let url = URL(string: baseURL + "/Articles/\(id)//like")!
        print("article id = \(id)")
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue(accessToken, forHTTPHeaderField: "x-authtoken")
      
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: Data.self, decoder: JSONDecoder())
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
            }, receiveValue: { (response) in
            })
            .store(in: &cancellables)
    }
    
    // (GET)Liked
    func getLiked(completion: @escaping (Result<[Articles], RequestError>) -> Void) -> Void {
        print("GET/Liked")
        
        let url = URL(string: baseURL + "/Articles/liked")!
        var urlrequest = URLRequest(url: url)
        
        urlrequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlrequest.httpMethod = "GET"
        urlrequest.setValue(accessToken, forHTTPHeaderField: "x-authtoken")
        
        URLSession.shared.dataTaskPublisher(for: urlrequest)
            .map { $0.data }
            .decode(type: ArticleResponse.self, decoder: JSONDecoder())
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
            }, receiveValue: { (response) in
                completion(.success(response.articles))
            })
            .store(in: &cancellables)
        
        print(completion)
    }
}

//
//  Network.swift
//  PokemonApp
//
//  Created by Dominik Maric on 17.02.2023..
//

import Foundation
import Alamofire

struct Network {
    
    static let shared = Network()
    
    let baseUrl = "https://pokeapi.co/api/v2/pokemon"
    
    private init() {}
    
    private func prepareStringForUrl() -> String {
        let url = baseUrl
        let unreserved = "=&:-._~/?"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        
        let decodedString = url.addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
        guard let decodedString else { return url }
        print(decodedString)

        return decodedString
    }
    
    func getRepositories(completion: @escaping(Result<Repository, AFError>) -> Void) {
    
        let preparedString = prepareStringForUrl
        let request = AF.request(preparedString())
        
        request.responseDecodable(of: Repository.self) { response in
            switch response.result {
            case .success(_):
                guard let repositories = response.value else { return }
                completion(.success(repositories))
                print(repositories)
            case .failure(_):
                guard let error = response.error else { return }
                completion(.failure(error))
            }
        }
    }
    
    func getPokemonDetail(url: String, completion: @escaping(Result<PokemonDetail, AFError>) -> Void) {
        
        let request = AF.request(url)
        request.responseDecodable(of: PokemonDetail.self) { response in
            switch response.result {
            case .success(let pokemonDetail):
                completion(.success(pokemonDetail))
                print(pokemonDetail)
            case .failure(_):
                guard let error = response.error else { return }
                completion(.failure(error))
            }
        }
    }
}

//request.responseDecodable(of: Repository.self) { response in
//    switch response.result {
//    case .success(_):
//        guard let repositories = response.value else { return }
//        completion(.success(repositories))
//        print(repositories)
//    case .failure(_):
//        guard let error = response.error else { return }
//        completion(.failure(error))
//    }
//}
//
//func getRepositories(searchParameter: String, sortType: String, completion: @escaping(Result<Repository, AFError>) -> Void){
//
//    let preparedString = prepareStringForUrl(searchParameter: searchParameter, sortType: sortType)
//    let request = AF.request(preparedString)
//
//    request.responseDecodable(of: Repository.self) { response in
//        switch response.result {
//        case .success(_):
//            guard let repositories = response.value else { return }
//            completion(.success(repositories))
//            print(repositories)
//        case .failure(_):
//            guard let error = response.error else { return }
//            completion(.failure(error))
//        }
//    }
//}

//    func getRepositories(searchParameter: String, sortType: String, completion: @escaping(Result<Repository, AFError>) -> Void) {
//
//    }

//func fetchData(at url: URL, completion: @escaping (Result<[Results], Error>) -> Void) {
//    self.dataTask(with: url) { (data, response, error) in
//        if let error = error {
//            completion(.failure(error))
//        }
//
//        if let data = data {
//            do {
//                let toDos = try JSONDecoder().decode([Results].self, from: data)
//                completion(.success(toDos))
//            } catch let decoderError {
//                completion(.failure(decoderError))
//            }
//        }
//    }.resume()
//}
//
//func getRepos() {
//    let url = URL(string: "https://pokeapi.co/api/v2/pokemon")!
//    URLSession.shared.fetchData(at: url) { result in
//        switch result {
//        case .success(let pokemons):
//            print("\(pokemons)")
//        case .failure(let error):
//            print("")
//        }
//    }
//}

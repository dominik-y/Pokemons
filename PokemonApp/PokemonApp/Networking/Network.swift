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
    
    func getPokemontImage(url: String, completion: @escaping(Result<Sprites ,AFError>) -> Void) {
        
        let request = AF.request(url)
        request.responseDecodable(of: Sprites.self) { response in
            switch response.result {
            case .success(let pokemonImage):
                completion(.success(pokemonImage))
            case .failure(_):
                guard let error = response.error else { return }
                completion(.failure(error))
            }
        }
    }
}

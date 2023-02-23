//
//  DetailsViewController.swift
//  PokemonApp
//
//  Created by Dominik Maric on 19.02.2023..
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    
    var url: String = ""
//    {
//        didSet {
//            //self.fetchData()
//            print(url)
//        }
//    }
    
    var titleName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //        fetchData()
        navigationBar.topItem?.title = titleName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationBar.topItem?.title = titleName
        self.fetchData()
    }
    
    private func configureItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
    
    func fetchData() {
        //        DispatchQueue.main.async {
        Network.shared.getPokemonDetail(url: url, completion: { result in
            print("URL")
            print(self.url)
            switch result {
            case .success(let details):
                
                guard let baseExperience = details.baseExperience else { return }
                
                //guard let weight = details.weight else { return }
                
                self.experienceLabel.text = String(baseExperience)
                //self.weightLabel.text = String(weight)
                
                //                DispatchQueue.main.async {
                //                    self.baseExperienceLabel.text = String(baseExperience)
                //                }
                //
                //                self.baseExperienceLabel.text = String(baseExperience)
                //                self.weightLabel.text = String(details.weight)
                //
                //                print("---------------"
                //                print(self.baseExperienceLabel?.text as Any)
                //                print(self.weightLabel?.text as Any)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchPokemonImage() {
        Network.shared.getPokemontImage(url: "url", completion: { result in
            switch result {
            case .success(let pokemonImage):
                
                guard let frontDefault = pokemonImage.frontDefault else { return }
                print("---------------------------------------------------------")
                print(pokemonImage.frontDefault)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

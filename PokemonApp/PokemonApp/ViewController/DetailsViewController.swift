//
//  DetailsViewController.swift
//  PokemonApp
//
//  Created by Dominik Maric on 19.02.2023..
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var baseExperienceLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var url: String
    
    required init?(coder: NSCoder) {
        self.url = ""
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchData()
    }
    
    func fetchData() {
        Network.shared.getPokemonDetail(url: url, completion: { result in
            switch result {
            case .success(let details):
                
                self.baseExperienceLabel?.text = String(details.baseExperience)
                self.weightLabel?.text = String(details.weight)

                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

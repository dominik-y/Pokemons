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
    
    private func configureItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
    
    func fetchData() {
        Network.shared.getPokemonDetail(url: url, completion: { result in
            switch result {
            case .success(let details):
    
                guard let baseExperience = details.baseExperience else { return }
                
//                DispatchQueue.main.async {
//                    self.baseExperienceLabel.text = String(baseExperience)
//                }
//                
//                self.baseExperienceLabel.text = String(baseExperience)
//                self.weightLabel.text = String(details.weight)
//
//                print("---------------")
//                print(self.baseExperienceLabel?.text as Any)
//                print(self.weightLabel?.text as Any)
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

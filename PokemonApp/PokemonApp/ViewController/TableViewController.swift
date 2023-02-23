//
//  TableViewController.swift
//  PokemonApp
//
//  Created by Dominik Maric on 18.02.2023..
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoritesButton: UIBarButtonItem!
    
    var navigationTitle: String = ""
    
    var repository: Repository? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        loadPokemonData()
        navigationBar.topItem?.title = "Welcome \(navigationTitle)"
    }
    
    private func loadPokemonData() {
        Network.shared.getRepositories { result in
            switch result {
            case .success(let repository):
                self.repository = repository
                self.tableView.reloadData()
            case .failure(_):
                print("EARSDSA")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let repository = repository else {
            return 0
        }
        
        return repository.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let repository = repository else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        cell.textLabel?.text = repository.results[indexPath.row].name
        
        cell.textLabel?.textAlignment = .center
        cell.contentView.layer.cornerRadius = 15
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repository = repository else {
            return
        }
        
        //        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        //        vc?.titleName = repository.results[indexPath.row].name
        let pokemonName = repository.results[indexPath.row].name
        
        let selectedPokemonUrl = repository.results[indexPath.row].url
        guard !pokemonName.isEmpty, !selectedPokemonUrl.isEmpty else { return }
        performSegue(withIdentifier: "segueToDetails", sender: ["url": selectedPokemonUrl, "titleName": pokemonName])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToDetails") {
            guard let detailsViewController = segue.destination as? DetailsViewController else { return }
            if let object = sender as? [String: String] {
                
                guard let url = object["url"],
                      let pokemonName = object["titleName"] else {
                    return
                }
                
                detailsViewController.url = url
                detailsViewController.titleName = pokemonName
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func favoritesButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToFavorites", sender: self)
    }
}


//
//  ViewController.swift
//  PokemonApp
//
//  Created by Dominik Maric on 17.02.2023..

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func isItEmpty() {
        guard let userInput = inputTextField.text else { return }
        if userInput.isEmpty {
            displayMyAlertMessage(userMessage: "")
        } else {
            performSegue(withIdentifier: "sequeToCells", sender: nil)
        }
    }
    
    func displayMyAlertMessage(userMessage:String){
        let myAlert = UIAlertController(title: "Oops! Empty field", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        isItEmpty()
    }
}

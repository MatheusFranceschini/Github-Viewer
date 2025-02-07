//
//  ViewController.swift
//  Github Viewer
//
//  Created by Matheus Franceschini on 07/02/25.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func fetchData() {
        
        guard let username = usernameTextField.text else { return }
        
        let url = "https://api.github.com/users/\(username)/repos"
        print(url)
        
        AF.request(url).responseDecodable(of: [Repository].self) { response in
            switch response.result {
            case .success(let repositories):
                for repository in repositories {
                    print(repository.name)
                    print(repository.language ?? "Não especificado")
                    print("--------")
                }
            case.failure(let error):
                //Colocar alerta de erro
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func searchButton(_ sender: UIButton) {
        fetchData()
    }
    
}


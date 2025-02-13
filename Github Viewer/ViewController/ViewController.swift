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
    
    var repositories: [Repository] = []
    var userLogin: String?
    var userAvatarURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func fetchUser() {
        guard let username = usernameTextField.text else { return }
        
        let repoUser = "https://api.github.com/users/\(username)"
        let repoUrl = "https://api.github.com/users/\(username)/repos"
        
        AF.request(repoUser).responseDecodable(of: User.self) { response in
            switch response.result {
            case.success(let user):
                self.userLogin = user.login
                self.userAvatarURL = user.avatar_url
                self.fetchRepositories(from: repoUrl)
            case.failure(let error):
                self.createAlert(title: "User not found. Please enter another name.", message: nil)
            }
        }
    }
    
    func fetchRepositories(from url: String) {
        
        AF.request(url).responseDecodable(of: [Repository].self) { response in
            switch response.result {
            case .success(let repositories):
                self.repositories.removeAll()
                
                for repository in repositories {
                    self.repositories.append(repository)
                }
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showDetailViewController", sender: self)
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func createAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailViewController" {
            if let detailsViewController = segue.destination as? DetailViewController {
                detailsViewController.repositories = repositories
                detailsViewController.userLogin = userLogin
                detailsViewController.userAvatarURL = userAvatarURL
            }
        }
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        fetchUser()
    }
    
}


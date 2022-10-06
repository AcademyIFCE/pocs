//
//  ViewController.swift
//  KeychainPOC
//
//  Created by Thiago Henrique on 08/08/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.boldSystemFont(ofSize: 46)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameInput: UITextField = {
        let nameField = UITextField()
        nameField.placeholder = "Nome"
        nameField.translatesAutoresizingMaskIntoConstraints = false
        return nameField
    }()
    
    let passwordInput: UITextField = {
        let passwordField = UITextField()
        passwordField.placeholder = "Senha"
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        return passwordField
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onTapSubmit), for: .touchUpInside)
        return button
    }()
    
    private lazy var recoverInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Recover", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(recoverData), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }
    
    @objc func onTapSubmit() {
        guard let account = nameInput.text else { return }
        guard let password = passwordInput.text else { return }
        
        do {
            try KeychainWrapper.shared.saveData(account: account, data: password.data(using: .utf8)!)
            print("Sucessfully saved data")
        } catch {
            print(error)
        }
    }
    
    @objc func recoverData() {
        do {
            let data = try KeychainWrapper.shared.getData()
            print("Recovered Data: \(String(data: data, encoding: .utf8) ?? "")")
        } catch {
            print(error)
        }
    }
    
    @objc func deleteData() {
        do {
            try KeychainWrapper.shared.deleteData()
            print("Sucessfully delete data!")
        } catch {
            print(error)
        }
    }
}

// MARK - ViewCoding Implementation

extension LoginViewController: ViewCoding {
    
    func addViewsInHierarchy() {
        view.addSubview(loginLabel)
        view.addSubview(nameInput)
        view.addSubview(passwordInput)
        view.addSubview(submitButton)
        view.addSubview(recoverInfoButton)
        view.addSubview(deleteInfoButton)
    }
    
    func setupConstraints() {
        let loginLabelConstraints = [
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250)
        ]
        
        let nameInputConstraints = [
            nameInput.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 100),
            nameInput.heightAnchor.constraint(equalToConstant: 45),
            nameInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            nameInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
        ]
        
        let passwordInputConstraints = [
            passwordInput.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 50),
            passwordInput.leadingAnchor.constraint(equalTo: nameInput.leadingAnchor),
            passwordInput.heightAnchor.constraint(equalTo: nameInput.heightAnchor),
            passwordInput.trailingAnchor.constraint(equalTo: nameInput.trailingAnchor)
        ]
        
        let submitButtonConstraints = [
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 75),
            submitButton.widthAnchor.constraint(equalToConstant: 150),
            submitButton.heightAnchor.constraint(equalToConstant: 36)
        ]
    
        let recoverButtonConstraints = [
            recoverInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recoverInfoButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 25),
            recoverInfoButton.widthAnchor.constraint(equalToConstant: 150),
            recoverInfoButton.heightAnchor.constraint(equalToConstant: 36)
        ]
        
        let deleteButtonConstraints = [
            deleteInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteInfoButton.topAnchor.constraint(equalTo: recoverInfoButton.bottomAnchor, constant: 25),
            deleteInfoButton.widthAnchor.constraint(equalToConstant: 150),
            deleteInfoButton.heightAnchor.constraint(equalToConstant: 36)
        ]
        
        NSLayoutConstraint.activate(loginLabelConstraints)
        NSLayoutConstraint.activate(nameInputConstraints)
        NSLayoutConstraint.activate(passwordInputConstraints)
        NSLayoutConstraint.activate(submitButtonConstraints)
        NSLayoutConstraint.activate(recoverButtonConstraints)
        NSLayoutConstraint.activate(deleteButtonConstraints)
    }
    
    func setupAditionalConfiguration() {
        view.backgroundColor = .systemBackground
    }
}


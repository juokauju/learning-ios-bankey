//
//  ViewController.swift
//  Udemy-Bankey
//
//  Created by jimi bird on 2023-01-16.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    private let sighInButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension LoginViewController {
    private func style() {
        setSighInButton()
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(sighInButton)
        
        addLoginViewConstraints()
        addSighInButtonConstraints()
    }
    
    private func addLoginViewConstraints() {
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
    }
    
    private func addSighInButtonConstraints() {
        NSLayoutConstraint.activate([
            sighInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            sighInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            sighInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
    }
    
    private func setSighInButton() {
        sighInButton.translatesAutoresizingMaskIntoConstraints = false
        sighInButton.configuration = .filled()
        sighInButton.configuration?.imagePadding = 8
        sighInButton.setTitle("Sigh In", for: [])
        sighInButton.addTarget(self, action: #selector(sighInTapped), for: .primaryActionTriggered)
    }
    
    @objc private func sighInTapped(sender: UIButton) {
        
    }
}



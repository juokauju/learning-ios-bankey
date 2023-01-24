//
//  ViewController.swift
//  Udemy-Bankey
//
//  Created by jimi bird on 2023-01-16.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?
    
    private let titleLabelStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let loginView = LoginView()
    private let sighInButton = UIButton(type: .system)
    private let errorMessageLabel = UILabel()
    
    private var username: String? {
        loginView.usernameTextField.text
    }
    
    private var password: String? {
        loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}


// MARK: - View Style and Layout

extension LoginViewController {
    private func style() {
        setTitleLabelStackView()
        setSighInButton()
        setErrorMessageLabel()
    }
    
    private func layout() {
        view.addSubview(titleLabelStackView)
        view.addSubview(loginView)
        view.addSubview(sighInButton)
        view.addSubview(errorMessageLabel)
        
        addTitleLabelStackViewConstraints()
        addLoginViewConstraints()
        addSighInButtonConstraints()
        addErrorMessageLabelConstraints()
    }
    
   // MARK: - Setting Subviews
    
    private func setTitleLabelStackView() {
        titleLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabelStackView.axis = .vertical
        titleLabelStackView.spacing = 24
        
        setTitleLabel()
        setSubtitleLabel()
        
        titleLabelStackView.addArrangedSubview(titleLabel)
        titleLabelStackView.addArrangedSubview(subtitleLabel)
    }
    
    private func setTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Bankey"
    }
    
    private func setSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "Your premium source for all things banking!"
    }
    
    private func setSighInButton() {
        sighInButton.translatesAutoresizingMaskIntoConstraints = false
        sighInButton.configuration = .filled()
        sighInButton.configuration?.imagePadding = 8
        sighInButton.setTitle("Sigh In", for: [])
        sighInButton.addTarget(self, action: #selector(sighInTapped), for: .primaryActionTriggered)
    }
    
    private func setErrorMessageLabel() {
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
    }
    
    // MARK: - Adding Constraints
    
    private func addTitleLabelStackViewConstraints() {
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabelStackView.bottomAnchor, multiplier: 3),
            titleLabelStackView.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            titleLabelStackView.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
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
    
    private func addErrorMessageLabelConstraints() {
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: sighInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
    }
    
  
    
}

// MARK: - Actions

extension LoginViewController {
    @objc private func sighInTapped(_ sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Usernamer or password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username or password should not be blank")
            return
        }
        
        if username == "Kevin" && password == "Welcome" {
            sighInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username or password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}


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
    
    private var leadingEdgeOnScreen: CGFloat = 16
    private var leadingEdgeOffScreen: CGFloat = -1000
    
    private var titleLeadingAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        sighInButton.configuration?.showsActivityIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animate()
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
        titleLabel.alpha = 0
    }
    
    private func setSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "Your premium source for all things banking!"
        subtitleLabel.alpha = 0
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
            titleLabelStackView.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        titleLeadingAnchor = titleLabelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
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
//            configureView(withMessage: "Username or password should not be blank")
            sighInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
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

extension LoginViewController {
    private func animate() {
        let duration = 0.8
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        let animator2 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.titleLabel.alpha = 1
            self.subtitleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.2)
    }
}


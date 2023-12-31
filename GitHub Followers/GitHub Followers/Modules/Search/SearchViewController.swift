//
//  SearchViewController.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit

class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Username"
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .search
        textField.delegate = self
        textField.layer.cornerRadius = LayoutConstant.defaultCornerRadius
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(title: "Get Followers", font: .systemFont(ofSize: 18, weight: .semibold), titleColor: .white, shouldRounded: true)
        button.addTarget(self, action: #selector(handleSearchTapped), for: .touchUpInside)
        return button
    }()
    
    private let logoImageView = UIImageView(image: UIImage(named: "icon_github_followers"), tintColor: nil)
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Will show app tutorial for the first time.
        // Otherwise, make textfield active.
        if kUserDefaults.tutorialShown {
            usernameTextField.becomeFirstResponder()
        } else {
            let tutorialController = AppTutorialViewController(style: .grouped)
            present(tutorialController, animated: true)
            kUserDefaults.tutorialShown = true
        }
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        
        view.backgroundColor = .systemBackground
        
        let stackView = UIStackView([logoImageView, usernameTextField, searchButton],
                                    axis: .vertical,
                                    spacing: 40,
                                    distribution: .fill,
                                    alignment: .center)
        
        view.addSubviews(stackView)
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(LayoutConstant.defaultHeight)
            make.width.equalTo(LayoutConstant.defaultWidth)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(250)
        }
        
        searchButton.snp.makeConstraints { make in
            make.height.equalTo(LayoutConstant.defaultHeight)
            make.width.equalTo(LayoutConstant.defaultWidth)
        }
        
        searchButton.makeGradient(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: LayoutConstant.defaultWidth,
                                                   height: LayoutConstant.defaultHeight))
    }
    
    @objc private func handleSearchTapped() {
        guard let username = usernameTextField.text, username.isEmpty == false else { return }
        let listController = FollowerListViewController(username: username)
        navigationController?.pushViewController(listController, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

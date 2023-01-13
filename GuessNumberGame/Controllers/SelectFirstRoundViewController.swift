//
//  SelectFirstRoundViewController.swift
//  GuessNumberGame
//
//  Created by Mac on 10.01.2023.
//

import UIKit

final class SelectFirstRoundViewController: UIViewController {
    
    let factory: Factory
    
    private let firstRoundGuessButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Угадать число", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(firstRoundGuessButtonHandler), for: .touchUpInside)
        return button
    }()
    
    private let firstRoundEnterButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Загадать число", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(firstRoundEnterButtonHandler), for: .touchUpInside)
        return button
    }()
    
    init(factory: Factory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выберите первый раунд"
        view.backgroundColor = .white
        view.addSubview(firstRoundGuessButton)
        view.addSubview(firstRoundEnterButton)
        navigationItem.hidesBackButton = true
        NSLayoutConstraint.activate([
            firstRoundGuessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstRoundGuessButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            firstRoundEnterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstRoundEnterButton.topAnchor.constraint(equalTo: firstRoundGuessButton.bottomAnchor, constant: 10),
            firstRoundGuessButton.widthAnchor.constraint(equalToConstant: 200),
            firstRoundEnterButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc
    private func firstRoundGuessButtonHandler() {
        let viewController = factory.create(controller: .userGuessView(isFirstRound: true))
        navigationController?.pushViewController(viewController, animated: true)
    }
    @objc
    private func firstRoundEnterButtonHandler() {
        let viewController = factory.create(controller: .computerGuessView(isFirstRound: true))
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//
//  ResultViewController.swift
//  GuessNumberGame
//
//  Created by Mac on 12.01.2023.
//

import UIKit

final class ResultViewController: UIViewController {
    
    private let userAttempts: Int
    private let computerAttempts: Int
    
    init(userAttempts: Int, computerAttempts: Int) {
        self.userAttempts = userAttempts
        self.computerAttempts = computerAttempts
        super.init(nibName: nil, bundle: nil)
    }
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let newGameButoon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сыграть еще!", for: .normal)
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(newGameButtonHandler), for: .touchUpInside)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        if userAttempts < computerAttempts {
            resultLabel.text = "Вы победили со счетом \(userAttempts) : \(computerAttempts)"
        } else if computerAttempts < userAttempts {
            resultLabel.text = "Компьютер выиграл со счетом \(computerAttempts) : \(userAttempts)"
        } else {
            resultLabel.text = "Ничья"
        }
        
        setupViews()
    }
    private func setupViews() {
        view.addSubview(resultLabel)
        view.addSubview(newGameButoon)
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            newGameButoon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGameButoon.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 50),
            newGameButoon.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc
    private func newGameButtonHandler() {
        let viewController = GameStartViewController()
        navigationController?.pushViewController(viewController, animated: true)

    }
}

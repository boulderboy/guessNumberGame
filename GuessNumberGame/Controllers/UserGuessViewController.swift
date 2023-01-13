//
//  UserGuessViewController.swift
//  GuessNumberGame
//
//  Created by Mac on 10.01.2023.
//

import UIKit

final class UserGuessViewController: UIViewController {
    
    var game: GameModel
    let isFirstRound: Bool
    var factory: Factory
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Компьютер загадал число:"
        return label
    }()
    
    private let answersScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let guessTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите число"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let tryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Try!", for: .normal)
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tryButtonHandler), for: .touchUpInside)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Далее", for: .normal)
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextButtonHandler), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Загаданное число "
        label.isHidden = true
        return label
    }()
    
    private let hintText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(game: GameModel, isFirstRound: Bool, factory: Factory) {
        self.game = game
        self.isFirstRound = isFirstRound
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ваша очередь угадывать"
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        setupViews()
    }
    
    @objc
    private func tryButtonHandler() {
        hintLabel.isHidden = false
        game.userAttempts += 1
        guard let userAnswer = Int(guessTextField.text ?? "0") else { return }
        let hint = game.check(answer: userAnswer)
        if hint == .equal {
            guessTextField.isEnabled = false
            tryButton.isEnabled = false
            hintLabel.text = "Вы угадали с \(game.userAttempts) попыток!"
            hintText.isHidden = true
            tryButton.isHidden = true
            nextButton.isHidden = false
        } else {
            guessTextField.text = ""
            hintText.text = hint.rawValue
        }
        print(game.secretNumber.secretNumber)
    }
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(guessTextField)
        view.addSubview(tryButton)
        view.addSubview(hintLabel)
        view.addSubview(hintText)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            guessTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guessTextField.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 50),
            guessTextField.widthAnchor.constraint(equalToConstant: 150),
            tryButton.topAnchor.constraint(equalTo: guessTextField.bottomAnchor, constant: 20),
            tryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tryButton.widthAnchor.constraint(equalToConstant: 100),
            hintLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            hintLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hintText.leadingAnchor.constraint(equalTo: hintLabel.trailingAnchor),
            hintText.topAnchor.constraint(equalTo: hintLabel.topAnchor),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc
    private func nextButtonHandler() {
        let viewController = isFirstRound
            ? factory.create(controller: .computerGuessView(isFirstRound: false))
            : factory.create(controller: .resultView)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

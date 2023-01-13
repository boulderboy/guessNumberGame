//
//  ComputerGuessViewController.swift
//  GuessNumberGame
//
//  Created by Mac on 10.01.2023.
//

import UIKit

final class ComputerGuessViewController: UIViewController {
    
 //   private let secretNumber = SecretNumber(secretNumber: Int.random(in: 0...10000))
    let game: GameModel
    let isFirstRound: Bool
    let factory: Factory
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Угадывает компьютер!"
        return label
    }()
    
    private let guessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Вы загадали число: "
        return label
    }()
    
    private let randomNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(Int.random(in: 0...10000))
        return label
    }()
    
    private let lessButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("<", for: .normal)
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(lessButtonHandler), for: .touchUpInside)
        return button
    }()
    
    private let equalButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("=", for: .normal)
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(equalButtonHandler), for: .touchUpInside)
        return button
    }()
    
    private let greaterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(">", for: .normal)
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(greaterButtonHandler), for: .touchUpInside)
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
    
    private let winningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Компьютер потратил "
        label.isHidden = true
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
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(guessLabel)
        view.addSubview(randomNumberLabel)
        view.addSubview(lessButton)
        view.addSubview(equalButton)
        view.addSubview(greaterButton)
        view.addSubview(winningLabel)
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            guessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guessLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            randomNumberLabel.leadingAnchor.constraint(equalTo: guessLabel.trailingAnchor),
            randomNumberLabel.topAnchor.constraint(equalTo: guessLabel.topAnchor),
            lessButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            lessButton.trailingAnchor.constraint(equalTo: equalButton.leadingAnchor, constant: -8),
            lessButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3 - 16),
            equalButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            equalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            equalButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3 - 16),
            greaterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            greaterButton.leadingAnchor.constraint(equalTo: equalButton.trailingAnchor, constant: 8),
            greaterButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3 - 16),
            winningLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            winningLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: winningLabel.bottomAnchor, constant: 20),
            nextButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc
    private func lessButtonHandler() {
        game.secretNumber.max = Int(randomNumberLabel.text ?? "10000") ?? 10000
        randomNumberLabel.text = String(Int.random(in: game.secretNumber.min...game.secretNumber.max))
        game.computerAttempts += 1
    }
    
    @objc
    private func greaterButtonHandler() {
        game.secretNumber.min = Int(randomNumberLabel.text ?? "0") ?? 0
        randomNumberLabel.text = String(Int.random(in: game.secretNumber.min...game.secretNumber.max))
        game.computerAttempts += 1
    }
    
    @objc
    private func equalButtonHandler() {
        winningLabel.isHidden = false
        let attempts = self.game.computerAttempts
        winningLabel.text! += "\(attempts) попыток"
        greaterButton.isEnabled = false
        equalButton.isEnabled = false
        lessButton.isEnabled = false
        nextButton.isHidden = false
    }
    @objc
    private func nextButtonHandler() {
        let viewController = isFirstRound
            ? factory.create(controller: .userGuessView(isFirstRound: false))
            : factory.create(controller: .resultView)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

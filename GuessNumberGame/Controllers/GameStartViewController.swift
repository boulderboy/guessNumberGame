//
//  ViewController.swift
//  GuessNumberGame
//
//  Created by Mac on 10.01.2023.
//

import UIKit

class GameStartViewController: UIViewController {

    private lazy var startNewGameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Начать игру", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(startButtonHandler), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Игра угадай число"
        view.addSubview(startNewGameButton)
        navigationItem.hidesBackButton = true
        NSLayoutConstraint.activate([
            startNewGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startNewGameButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startNewGameButton.widthAnchor.constraint(equalToConstant: 200),
            startNewGameButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc
    private func startButtonHandler() {
        let factory = Factory()
        let viewController = factory.create(controller: .selectView)
        navigationController?.pushViewController(viewController, animated: true)
    }

}

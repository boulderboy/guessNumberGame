//
//  Factory.swift
//  GuessNumberGame
//
//  Created by Mac on 12.01.2023.
//

import UIKit

enum ViewType {
    case gameStartView
    case selectView
    case computerGuessView(isFirstRound: Bool)
    case userGuessView(isFirstRound: Bool)
    case resultView
}

final class Factory {
    
    let game = GameModel(secretNumber: SecretNumber(secretNumber: Int.random(in: 0...100)))
    
    func create(controller: ViewType) -> UIViewController {
        var resultController: UIViewController
        switch controller {
        case .gameStartView:
            resultController = GameStartViewController()
        case .selectView:
            resultController = SelectFirstRoundViewController(factory: self)
        case .computerGuessView(let isFirstRound):
            resultController = ComputerGuessViewController(game: game, isFirstRound: isFirstRound, factory: self)
        case .userGuessView(let isFirstRound):
            resultController = UserGuessViewController(game: game, isFirstRound: isFirstRound, factory: self)
        case .resultView:
            resultController = ResultViewController(userAttempts: game.userAttempts, computerAttempts: game.computerAttempts)
        }
        return resultController
    }
}

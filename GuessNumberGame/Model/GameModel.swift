//
//  GameModel.swift
//  GuessNumberGame
//
//  Created by Mac on 10.01.2023.
//

import Foundation

final class GameModel {
    var secretNumber: SecretNumber
    var currentRound = 1
    var computerAttempts: Int = 1
    var userAttempts: Int = 0
    init(secretNumber: SecretNumber, currentRound: Int = 1, computerAttempts: Int = 1, userAttempts: Int = 0) {
        self.secretNumber = secretNumber
        self.currentRound = currentRound
        self.computerAttempts = computerAttempts
        self.userAttempts = userAttempts
    }
    
    func check(answer: Int) -> Answers {
        if answer == secretNumber.secretNumber {
            return .equal
        } else if answer < secretNumber.secretNumber {
            return .greater
        } else {
            return .less
        }
    }
}

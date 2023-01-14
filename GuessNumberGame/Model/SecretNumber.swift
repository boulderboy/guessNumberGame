//
//  SecretNumber.swift
//  GuessNumberGame
//
//  Created by Mac on 10.01.2023.
//

import Foundation

enum Answers: String {
    case greater = "больше"
    case less = "меньше"
    case equal = "равно"
}

final class SecretNumber {

    var secretNumber: Int
    var max: Int = 10000
    var min: Int = 0

    init(secretNumber: Int) {
        self.secretNumber = secretNumber
    }

    func isNumberCorrect(number: Int) -> Answers {
        if number > secretNumber {
            return .less
        } else if number < secretNumber {
            return .greater
        }
        return .equal
    }
}

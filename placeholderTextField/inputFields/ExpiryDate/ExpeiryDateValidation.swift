//
//  ExpeiryDateValidation.swift
//  placeholderTextField
//
//  Created by Mahmoud Fares on 18/05/2021.
//

import Foundation
enum ExpiryValidation {
    case valid, invalidInput, expired
}

func validateCreditCardExpiry(_ input: String) -> ExpiryValidation {

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMyy"

    guard let enteredDate = dateFormatter.date(from: input) else {
        return .invalidInput
    }
    let calendar = Calendar.current
    let components = Set([Calendar.Component.month, Calendar.Component.year])
    let currentDateComponents = calendar.dateComponents(components, from: Date())
    let enteredDateComponents = calendar.dateComponents(components, from: enteredDate)

    guard let eMonth = enteredDateComponents.month, let eYear = enteredDateComponents.year, let cMonth = currentDateComponents.month, let cYear = currentDateComponents.year, eMonth >= cMonth, eYear >= cYear else {
        return .expired
    }
    return .valid
}

let invalidInput = validateCreditCardExpiry("hello")
let validInput = validateCreditCardExpiry("092020")
let expiredInput = validateCreditCardExpiry("042010")

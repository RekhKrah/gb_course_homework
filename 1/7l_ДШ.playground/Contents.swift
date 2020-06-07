//1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.
//2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.
import Foundation

extension String {
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._-]+@[A-Z0-9a-z._-]+\\.[A-Za-z]{2,64}"
        let emailPrediacate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        
        return emailPrediacate.evaluate(with: self)
    }
}

class LoginController {
    
    var loginData: String
    var passwordData: String
    
    let minimalPassworLength = 8
    
    enum LoginErrors: Error {
        case emptyFields
        case invalidEmail
        case incorrectPassword
    }
    
    init(loginData: String, passwordData: String) {
        self.loginData = loginData
        self.passwordData = passwordData
    }
    
    func loginButtonTapped() -> String {
        do {
            try login()
            return "Hi, \(self.loginData)"
        } catch LoginErrors.emptyFields {
            return "Please fill out both email and password fields"
        } catch LoginErrors.incorrectPassword {
            return "Password should be at least \(minimalPassworLength) characters"
        } catch LoginErrors.invalidEmail {
            return "Plaese make sure you format your email corectly"
        } catch {
            return "Unable to login. There was an error when attempting to login"
        }
    }
    
    func login() throws {
        if self.loginData.isEmpty || self.passwordData.isEmpty {
            throw LoginErrors.emptyFields
        }
        
        if !self.loginData.isValidEmail {
            throw LoginErrors.invalidEmail
        }
        
        if self.passwordData.count < minimalPassworLength {
            throw LoginErrors.incorrectPassword
        }
    }
}

// tests
let correctLogin = LoginController(loginData: "joe@gmail.com", passwordData: "qwerty123")
correctLogin.loginButtonTapped() == "Hi, joe@gmail.com"

let emptyData = LoginController(loginData: "", passwordData: "")
emptyData.loginButtonTapped() == "Please fill out both email and password fields"

let invalidEmail = LoginController(loginData: "ertwe", passwordData: "12345678")
invalidEmail.loginButtonTapped() == "Plaese make sure you format your email corectly"

let shortPawwsor = LoginController(loginData: "ertwe@ewq.com", passwordData: "123")
shortPawwsor.loginButtonTapped() == "Password should be at least 8 characters"

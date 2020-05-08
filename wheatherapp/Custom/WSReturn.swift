//
//  Error.swift
//  wheatherapp
//
//  Created by Leonardo Leffa on 08/05/20.
//  Copyright © 2020 Leonardo Leffa. All rights reserved.
//

enum WSReturn: String, Swift.Error {
    case success
    case error
    case locationError
    
    var code: Int {
        switch self {
            case .success:
                return 200
            case .error:
                return 400
            case .locationError:
                return -1
        }
    }
    
    var success: Bool {
        switch self {
            case .success:
                return true
            case .error:
                return false
            case .locationError:
                return false
        }
    }
    
    var message: String {
        switch self {
            case .success:
                return ""
            case .error:
                return "Houve um erro na requisição!"
            case .locationError:
                return "Você precisa aceitar as permissões de localização para o correto funcionamento do aplicativo!"
        }
    }
}

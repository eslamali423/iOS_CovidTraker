//
//  StateViewModel.swift
//  CovidTraker
//
//  Created by Eslam Ali  on 29/03/2022.
//

import Foundation

class StateViewModel {
    
    func fetchDate (scope : APICaller.DataScope) {
        APICaller.shared.getCovidData(for: scope) { (result) in
            switch result {
            case .success(let data) :
                break
            case .failure(let error) :
                print(error)
             }
        }
    }
    
    
}

//
//  StateViewModel.swift
//  CovidTraker
//
//  Created by Eslam Ali  on 29/03/2022.
//

import Foundation

class StateViewModel {
    
    
    var dayData : [DayData] = []
    
    func fetchDate (scope : APICaller.DataScope, completion:  @escaping (Bool)->Void) {
        APICaller.shared.getCovidData(for: scope) { [weak self] (result) in
            switch result {
            case .success(let dayData) :
                self?.dayData = dayData
                completion(true)
            case .failure(let error) :
                print(error)
                completion(false)
             }
        }
    }
    
    
}

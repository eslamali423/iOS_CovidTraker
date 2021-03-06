//
//  StateViewModel.swift
//  CovidTraker
//
//  Created by Eslam Ali  on 29/03/2022.
//

import Foundation

class AllStatesViewModel {
    
    //MARK:- Vars
    var states : [State] = [] 
    
    
    //MARK:- Fetch All States Data From API
    func fetchState(completion : @escaping (Bool)->Void)  {
        APICaller.shared.getStateList {  [weak self] (result) in
            switch result {
            case .success (let states):
                self?.states =  states
                completion(true)
                break
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    
    
}

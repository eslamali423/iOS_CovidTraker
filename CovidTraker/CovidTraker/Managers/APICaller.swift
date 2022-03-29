//
//  APICaller.swift
//  CovidTraker
//
//  Created by Eslam Ali  on 29/03/2022.
//

import Foundation

class APICaller {
    
    static let shared  =  APICaller()
    
    private init () {}
    
    enum DataScope {
        case national
        case state(State)
    }
    
    struct Constatns  {
        static let allSatetesUrl = URL(string: "https://api.covidtracking.com/v2/states.json")
    }
    
    
    func getCovidData(for scope :  DataScope, completion:  @escaping ((Result<String,Error>))->Void) {
        
    }
    
    func getStateList(completion :  @escaping (Result<[State], Error>)->Void)  {
        guard let url = Constatns.allSatetesUrl else {return}
        
        let task  = URLSession.shared.dataTask(with: url) { (data, _ , error) in
            
            guard let data =  data , error == nil else  {return}
            
            do {
                let result = try JSONDecoder().decode(StateListResponse.self, from: data)
                let states =  result.data
                completion(.success(states))
            }catch {
                completion(.failure(error))
            }
            
        }
        task.resume() 
        
    }
}




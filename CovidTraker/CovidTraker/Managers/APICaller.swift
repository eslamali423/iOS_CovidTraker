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
    
    
    //MARK:- URLs
    struct Constatns  {
        static let allSatetesUrl = URL(string: "https://api.covidtracking.com/v2/states.json")
       
    }
    
    
    
    
    //MARK:- Fetch National Data From API
    func getCovidData(for scope :  DataScope, completion:  @escaping ((Result<[DayData],Error>))->Void) {
       
        let urlString : String
        switch scope {
        case .national :
            urlString = "https://api.covidtracking.com/v2/us/daily.json"
        case .state(let state):
        urlString = "https://api.covidtracking.com/v2/states/\(state.state_code.lowercased())/daily.json"
        }
        
        
        guard let url = URL(string: urlString) else {return}
        
        let task  = URLSession.shared.dataTask(with: url) { (data, _ , error) in
            
            guard let data =  data , error == nil else  {return}
            
            do {
                let result = try JSONDecoder().decode(CovidDataResponse.self, from: data)
                let models : [DayData] =  result.data.compactMap {
                    guard let value =  $0.cases?.total.value,
                        let date = DateFormatter.dayFormatter.date(from: $0.date) else {return nil}
                
                    return DayData(date: date, count: value)
                
                }
               
                completion(.success(models))
               
            }catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    
    
    //MARK:- Fetch All Stats Data From API

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



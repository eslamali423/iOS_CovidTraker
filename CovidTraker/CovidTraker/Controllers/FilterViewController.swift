//
//  FilterViewController.swift
//  CovidTraker
//
//  Created by Eslam Ali  on 29/03/2022.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK:- Vars
    
    public var completion : ((State) -> Void)?
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    
    
    var stateViewModel = AllStatesViewModel()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select State"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        configureCancelButton()
       fetchData()
       
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

    
    
    //MARK:- Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateViewModel.states.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let state = stateViewModel.states[indexPath.row]
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = state.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let state =  stateViewModel.states[indexPath.row]
        completion?(state)
        dismiss(animated: true)
    }
    
    //MARK:- Configure Cancel Button
    func configureCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
    
    @objc func didTapClose () {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Get Data Form View Model
    func fetchData()  {
        stateViewModel.fetchState { (isSuccess) in
            if isSuccess {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }


}

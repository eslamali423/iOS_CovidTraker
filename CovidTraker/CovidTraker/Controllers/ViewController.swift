//
//  ViewController.swift
//  CovidTraker
//
//  Created by Eslam Ali  on 29/03/2022.
//

import UIKit
import Charts

class ViewController: UIViewController, UITableViewDataSource {

    //MARK:- Vars
    private var scope : APICaller.DataScope = .national
  
    var stateViewModel = StateViewModel()
    
   public  let tableView : UITableView = {
        let table =  UITableView(frame: .zero)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        
        return table
    }()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Covid Cases"
        configureTableView()
        createFilterButton()
        fetchData()
       

    }
    
   
   //MARK:- Configure TableView
    func configureTableView()  {
        view.addSubview(tableView)
        tableView.dataSource = self
        
       
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stateViewModel.dayData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data =  stateViewModel.dayData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = createText(with: data)
    return cell
    }
    
    func createText(with data : DayData) -> String?    {
        let dateString = DateFormatter.prettyFormatter.string(from: data.date)
       
        return "\(dateString); \(data.count)"
    }
    
    
    
    //MARK:- Configure Filtter Button
    func createFilterButton()  {
        let buttonTitle : String  = {
            switch scope {
            case .national : return "National"
            case .state(let state) : return state.name
            }
        }()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(didTapFilter))
    }
    
    @objc func didTapFilter () {
        let vc = FilterViewController()
        vc.completion = { [weak self] state in
            self?.scope = .state(state)
            self?.fetchData()
            self?.createFilterButton()
            
        }
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
        
    }
    
    
    //MARK:- Configure Graph
    func createGraph () {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width / 1.5))
        headerView.clipsToBounds = true
      
        
        let set = stateViewModel.dayData.prefix(30)
        var entries : [BarChartDataEntry] = []
      
        for index in 0..<set.count {
            let data = set[index]
            entries.append(.init(x: Double(index), y: Double(data.count)))
        }
        
        let dataSet = BarChartDataSet (entries: entries)
        dataSet.colors = ChartColorTemplates.joyful()
        
        let data : BarChartData = BarChartData(dataSet: dataSet)
        
        let chart =  BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width / 1.5))
        headerView.addSubview(chart)
        chart.data = data
        
        tableView.tableHeaderView = headerView
    }
    
    //MARK:- Get Data Form View Model
    func fetchData()  {
        stateViewModel.fetchDate(scope: scope) { (isSuccess) in
            if isSuccess {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.createGraph()
                }
            }
        }
       
        

    }
    
    
   
    
   

}


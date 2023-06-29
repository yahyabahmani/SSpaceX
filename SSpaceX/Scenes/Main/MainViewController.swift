//
//  MainViewController.swift
//  SSpaceX
//
//  Created by yahya on 6/27/23.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    var viewModel: MainViewModel!
    @IBOutlet weak var tableView: UITableView!
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        bindView()
        self.viewModel.fetchData()
        // Do any additional setup after loading the view.
    }
    func bindView(){
        
   
        
//        self.viewModel.reloadRows = {[weak self] indexTemp in
//            guard let self = self else {return}
//            DispatchQueue.main.async {
//
//                self.tableView.beginUpdates()
//                               self.tableView.insertRows(at: indexTemp, with: .bottom)
//                               self.tableView.endUpdates()
//            }
//
//        }
        
//        self.viewModel.indexMission.sink {[unowned self] (str) in
//
//
//            print(str.count)
//        } receiveValue: { [unowned self] (str) in
//            DispatchQueue.main.async {
//                self.tableView.beginUpdates()
//                self.tableView.insertRows(at: str, with: .bottom)
//                self.tableView.endUpdates()
//            }
//        }.store(in: &subscriptions)
        
//        self.viewModel.indexMission.sink { [unowned self] (value) in
//            print("missions.sink\(value.count)")
//            if value.count > 0{
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//
//        }.store(in: &subscriptions)
        self.viewModel.missions.sink { [unowned self] (value) in
            print("missions.sink\(value.count)")
            if value.count > 0{
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
            }
    
        }.store(in: &subscriptions)
    }
    func setupView() {
        self.tableView.delegate  = self
        self.tableView.dataSource = self
        self.tableView.registerCell(MainTableViewCell.nibName)
        self.tableView.registerCell(MainIndicatorTableViewCell.nibName)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LoadingCell")

        navigationItem.title = Constants.missionOFSpaceX
//      searchController.obscuresBackgroundDuringPresentation = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
           return 2
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if section == 0 {
               return self.viewModel.missions.value.count
           } else {
               return self.viewModel.isLoading ? 1 : 0
           }
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           if indexPath.section == 0 {
               let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.nibName, for: indexPath) as! MainTableViewCell

               let missions = self.viewModel.missions.value[indexPath.row]
               cell.fillData(model: missions)
               return cell
           } else {
               
               let cell = tableView.dequeueReusableCell(withIdentifier: MainIndicatorTableViewCell.nibName, for: indexPath) as! MainIndicatorTableViewCell
               return cell

//               let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
//               cell.textLabel?.text = "Loading..."
//               return cell
           }
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.showDetails(self.viewModel.missions.value[indexPath.row])
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == self.viewModel.missions.value.count - 1,!self.viewModel.isLastPage {
              viewModel.fetchData()
          }
    }
    
}
extension MainViewController: InstantiateViewControllerType {
  static var storyboardName: StoryBoardName {
    .main
  }
}

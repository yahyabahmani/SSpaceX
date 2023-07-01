//
//  MainViewController.swift
//  SSpaceX
//
//  Created by yahya on 6/27/23.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    var viewModel: MainViewModel!
    @IBOutlet weak var tableView: UITableView!
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.bindView()
        self.viewModel.fetchData()
        self.bindFooterView(isLoading: true)

        // Do any additional setup after loading the view.
    }
    private func bindView(){
         self.viewModel.indexMission.sink { [weak self] value in
             DispatchQueue.main.async {
                 self?.tableView.beginUpdates()
                 self?.tableView.insertRows(at: value, with: .bottom)
                 self?.tableView.endUpdates()
                 self?.bindFooterView(isLoading: false)
             }
        }.store(in: &subscriptions)

    }
    private func setupView() {
        self.tableView.delegate  = self
        self.tableView.dataSource = self
        self.tableView.registerCell(MainTableViewCell.nibName)
        navigationItem.title = Constants.missionOFSpaceX
    }

    private func bindFooterView(isLoading: Bool) {
        func footerView() -> UIView {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
            let indicator = UIActivityIndicatorView()
            indicator.startAnimating()
            indicator.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(indicator)
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            return view
        }
        
        self.tableView.tableFooterView = isLoading ? footerView() : nil
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.missions.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.nibName, for: indexPath) as! MainTableViewCell
        
        let missions = self.viewModel.missions.value[indexPath.row]
        cell.fillData(model: missions)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.showDetails(self.viewModel.missions.value[indexPath.row])
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == self.viewModel.missions.value.count - 1,!self.viewModel.isLastPage {
            self.bindFooterView(isLoading: true)
            viewModel.fetchData()
        }
    }
    
}
extension MainViewController: InstantiateViewControllerType {
  static var storyboardName: StoryBoardName {
    .main
  }
}

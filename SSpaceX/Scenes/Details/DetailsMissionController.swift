//
//  DetailsMissionCoordinatorViewController.swift
//  SSpaceX
//
//  Created by yahya on 6/28/23.
//

import UIKit

final class DetailsMissionController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: DetailsMissionViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.bind()
        // Do any additional setup after loading the view.
    }
    private  func bind(){
        self.viewModel.reload = {[weak self] index in
            self?.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
    private func setupView(){
        self.viewModel.initialCell()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerCell(DetailsImageTableViewCell.nibName)
        self.tableView.registerCell(DetailsTextTableViewCell.nibName)
        self.tableView.registerCell(DetailsSelectTableViewCell.nibName)

        
    }

}
extension DetailsMissionController: InstantiateViewControllerType {
  static var storyboardName: StoryBoardName {
    .details
  }
}
extension DetailsMissionController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.viewModel.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.viewModel.dataSource[indexPath.row]
        switch item{
        case .image(let url,let id):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsImageTableViewCell.nibName, for: indexPath) as! DetailsImageTableViewCell
            cell.fillData(img: url,id:id)
            cell.delegate = self
            
           return cell
        case .title(let title):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTextTableViewCell.nibName, for: indexPath) as! DetailsTextTableViewCell
            cell.fillData(txt: title)
           return cell
            
        case .wikipedia(let url):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsSelectTableViewCell.nibName, for: indexPath) as! DetailsSelectTableViewCell
            cell.fillData(url: url)
           return cell
            
        }
        
        
    }
    
    
}
extension DetailsMissionController:DetailsImageTableViewCellDelegate{
    func bookmarkSelect() {
        self.viewModel.selectBookmark()
    }
    
    
}

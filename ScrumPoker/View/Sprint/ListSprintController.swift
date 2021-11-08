//
//  ListSprintViewController.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxRelay

protocol ListSprintToPresenter: AnyObject {
    var sprintsObserver: Observable<[Sprint]> { get }
    func setLoading(_ loading: Bool)
}

class ListSprintController: UIViewController, UITableViewDataSource {
    
    var sprintsBehavior = BehaviorRelay<[Sprint]?>(value: nil)
    var presenter: SprintPresenterToView!
    let disposeBag = DisposeBag()
    
    private var sprints = [Sprint]()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onAddSprint(_ sender: UIBarButtonItem) {
        presenter.showViewAddSprint()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultUserCell")
        presenter.viewDidLoad()
        loadDataBind()
    }
    
    private func loadDataBind() {
        presenter.sprintListed.bind { [weak self] sprints in
            self?.sprints = sprints
        }
        .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sprints.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultUserCell", for: indexPath)
        let sprint = sprints[indexPath.row]
           
        cell.textLabel?.text = sprint.nome
        cell.detailTextLabel?.text = sprint.link
           
        return cell
    }
}

extension ListSprintController: ListSprintToPresenter {
    var sprintsObserver: Observable<[Sprint]> {
        return sprintsBehavior.unwrap().asObservable()
    }
    
    func setLoading(_ loading: Bool) {
        if loading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
}

extension ListSprintController: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let response = dataTask.response as? HTTPURLResponse,
           response.statusCode >= 200, response.statusCode < 300 {
            
            if let sprints = try? JSONDecoder().decode([Sprint].self, from: data) {
                self.sprints = sprints
                self.tableView.reloadData()
            }
        }
    }
}

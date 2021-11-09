//
//  ListSprintTableViewController.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 08/11/21.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxRelay

protocol ListSprintToPresenter: AnyObject {
    var sprintsObserver: Observable<[Sprint]> { get }
    func setLoading(_ loading: Bool)
}

class ListSprintController: UITableViewController {
    
    var sprintsBehavior = BehaviorRelay<[Sprint]?>(value: nil)
    var presenter: SprintPresenterToView!
    let disposeBag = DisposeBag()
    
    private var sprints = [Sprint]()
        
    @objc func onAddSprint(_ sender: UIBarButtonItem) {
        presenter.showViewAddSprint()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setUpTableView()
        presenter.viewDidLoad()
        loadDataBind()
        tableView.reloadData()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Sprints"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemBlue]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddSprint(_:)))
    }
    
    private func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
   }
    
    private func loadDataBind() {
        presenter.sprintListed.bind { [weak self] sprints in
            self?.sprints = sprints
            self?.tableView.reloadData()
        }
        .disposed(by: disposeBag)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sprints.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sprint = sprints[indexPath.row]
           
        cell.textLabel?.text = sprint.nome
        cell.detailTextLabel?.text = sprint.link

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       return true
    }
       
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let delete = UIContextualAction(style: .destructive, title: "Excluir") { action, view, success in
           success(true)
       }
       
       let view = UIContextualAction(style: .normal, title: "Visualizar") { action, view, success in
           success(true)
       }
       
       return UISwipeActionsConfiguration(actions: [delete, view])
    }
       
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let viewStories = UIContextualAction(style: .normal, title: "Ver estórias") { action, view, success in
            success(true)
        }
       return UISwipeActionsConfiguration(actions: [viewStories])
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
       return .none
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
           sprints.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
       }
    }
}

extension ListSprintController: ListSprintToPresenter {
    var sprintsObserver: Observable<[Sprint]> {
        return sprintsBehavior.unwrap().asObservable()
    }
    
    func setLoading(_ loading: Bool) {
    }
}

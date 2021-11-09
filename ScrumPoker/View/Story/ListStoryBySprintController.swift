//
//  ListStoryBySprintController.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 08/11/21.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxRelay

protocol ListStoryToPresenter: AnyObject {
    var storiesObserver: Observable<[Story]> { get }
    func setLoading(_ loading: Bool)
}

class ListStoryBySprintController: UITableViewController {
    
    var storiesBehavior = BehaviorRelay<[Story]?>(value: nil)
    var presenter: StoryPresenterToView!
    let disposeBag = DisposeBag()
    
    private var stories = [Story]()
    
    @objc func onAddStory(_ sender: UIBarButtonItem) {
        presenter.showViewAddStory()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        presenter.viewDidLoad()
        loadDataBind()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Estórias"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemBlue]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddStory(_:)))
    }
    
    private func loadDataBind() {
        presenter.recoveredStoriesBySprint.bind { [weak self] stories in
            self?.stories = stories
            self?.tableView.reloadData()
        }
        .disposed(by: disposeBag)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let story = stories[indexPath.row]
           
        cell.textLabel?.text = story.nome
        cell.detailTextLabel?.text = story.link

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       return true
    }
       
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let delete = UIContextualAction(style: .destructive, title: "Excluir") { action, view, success in
           success(true)
       }
       
       let edit = UIContextualAction(style: .normal, title: "Editar") { action, view, success in
           success(true)
       }
       
       return UISwipeActionsConfiguration(actions: [delete, edit])
    }
       
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let view = UIContextualAction(style: .normal, title: "Visualizar") { action, view, success in
            success(true)
        }
       return UISwipeActionsConfiguration(actions: [view])
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
       return .none
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
           stories.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
       }
    }
}

extension ListStoryBySprintController: ListStoryToPresenter {
    var storiesObserver: Observable<[Story]> {
        return storiesBehavior.unwrap().asObservable()
    }
    
    func setLoading(_ loading: Bool) {
    }
}

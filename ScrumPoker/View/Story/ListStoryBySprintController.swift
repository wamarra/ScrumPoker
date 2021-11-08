//
//  ListStoryBySprintController.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 07/11/21.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxRelay

protocol ListStoryToPresenter: AnyObject {
    var storiesObserver: Observable<Int> { get }
    func setLoading(_ loading: Bool)
}

class ListStoryBySprintController: UIViewController {
    
    var storiesBehavior = BehaviorRelay<Int?>(value: nil)
    var presenter: StoryPresenterToView!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sprintIdField: UITextField!
    
    @IBAction func onAddStory(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func findStories(_ sender: UIButton) {
        presenter.findStories(sprintId: Int(sprintIdField.text!)!)
    }
    
    private var stories = [Story]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultUserCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDataBind()
    }
    
    private func loadDataBind() {
        presenter.recoveredStoriesBySprint.bind { [weak self] stories in
            self?.stories = stories
        }
        .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultUserCell", for: indexPath)
        let story = stories[indexPath.row]
           
        cell.textLabel?.text = story.nome
        cell.detailTextLabel?.text = story.link
           
        return cell
    }
}

extension ListStoryBySprintController: ListStoryToPresenter {
    var storiesObserver: Observable<Int> {
        return storiesBehavior.unwrap().asObservable()
    }
    
    func setLoading(_ loading: Bool) {
        if loading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
}

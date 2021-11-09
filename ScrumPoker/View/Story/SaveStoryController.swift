//
//  SaveStoryController.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 08/11/21.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxRelay

protocol SaveStoryToPresenter: AnyObject {
    var storyObserver: Observable<Story> { get }
    func setLoading(_ loading: Bool)
}

class SaveStoryController: UIViewController {
    
    var storyBehavior = BehaviorRelay<Story?>(value: nil)
    var presenter: StoryPresenterToView!
    let disposeBag = DisposeBag()
    
    private var story: Story?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var sprintField: UITextField!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var linkField: UITextField!
    
    @IBAction func onAddStory(_ sender: UIButton) {
        guard let idSprint = sprintField.text, let name = nameField.text, let link = linkField.text else { return }
        storyBehavior.accept(Story(idSprint: Int(idSprint), nome: name, link: link))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.bindAddStory()
    }
}

extension SaveStoryController: SaveStoryToPresenter {
    var storyObserver: Observable<Story> {
        return storyBehavior.unwrap().asObservable()
    }
    
    func setLoading(_ loading: Bool) {
        if loading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
}

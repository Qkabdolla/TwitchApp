//
//  ViewController.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/3/20.
//

import UIKit
import RxSwift
import RxCocoa
import Swinject
import SwinjectAutoregistration

class MainViewController: MvvmViewController<MainViewModel> {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.localizable.mainVCTitle()
        
        viewModel.getData().bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: MainCell.self)) {
            index, game, cell in
            cell.bind(item: game)
        }.disposed(by: bag)
        
    }

}

//extension MainViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.reviews.value.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cell, for: indexPath)!.apply { $0.bind(item: viewModel.reviews.value[indexPath.row]) }
//    }
//}

struct GameListItem : ListItem {
    
    let games: Game
    
    init (from games: Game) {
        self.games = games
    }
}

public protocol ListItem { }

public protocol Applicable { }

public extension Applicable {
    func apply(_ closure:(Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject : Applicable { }
extension AnyHashable : Applicable { }
extension AnyCollection : Applicable { }
extension JSONEncoder : Applicable { }
extension JSONDecoder : Applicable { }
extension Array : Applicable where Element: Applicable { }
extension Optional : Applicable where Wrapped: Applicable { }

typealias DataList<T> = DataListProperty<T>

final class DataListProperty<T> {
    fileprivate let subject = BehaviorSubject<[T]>(value: [])

    init() {
    }
    
    init(_ defaultValue: [T]) {
        value = defaultValue
    }
    
    var value: [T] {
        get { try! subject.value() }
        set(v) { subject.onNext(v) }
    }
}

extension DataListProperty {
    func subscribe(to action: @escaping ([T]) -> Void) -> Disposable {
        self.subject.subscribe { action($0.element!) }
    }
}

extension MvvmController {
    func bind<T>(_ property: DataListProperty<T>, to action: @escaping ([T]) -> Void) {
        property.subject.subscribe { action($0.element!) }.disposed(by: bag)
    }
}

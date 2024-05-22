import Foundation
import UIKit
import Combine

class TableViewMain: UITableView {
    
    private var anyCancallables = Set<AnyCancellable>()
    
    var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, style: .plain)
        setDelegates()
        configure()
        bindViewModel()
        register(TableViewCellMain.self, forCellReuseIdentifier: TableViewCellMain.idTableViewCell)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegates() {
        dataSource = self
    }
    
    private func configure() {
        backgroundColor = .none
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func bindViewModel() {
        viewModel.$creations
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                reloadData()
                guard viewModel.creations.count > 0 else { return }
                let indexPath = IndexPath(row: viewModel.creations.count - 1, section: 0)
                scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
            .store(in: &anyCancallables)
        
        viewModel.deadAround
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                guard let index = viewModel.closestAlive?.index,
                      let cell = self.cellForRow(at: IndexPath(row: index, section: 0))
                        as? TableViewCellMain else { return }
                cell.kill()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
                }
                viewModel.closestAlive = nil
            }
            .store(in: &anyCancallables)
    }
}

extension TableViewMain: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.creations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellMain.idTableViewCell, for: indexPath) as? TableViewCellMain else {return UITableViewCell()}
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.configure(viewModel: cellViewModel)
        return cell
    }
}



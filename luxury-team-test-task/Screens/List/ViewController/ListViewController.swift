//
//  ListViewController.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import UIKit

enum ListFilter {

    case all
    case favorites

}

final class ListViewController: BaseViewController {

    // MARK: Properties

    typealias TableDataSource = UITableViewDiffableDataSource<ListTableSection, ListTableItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<ListTableSection, ListTableItem>

    var viewModel: ListViewModelProtocol?
    private lazy var searchBar: SearchBarView = {
        let view = SearchBarView()
        view.delegate = self
        return view
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: Sizes.screenWidth, bottom: 0, right: 0)
        tableView.register(cellType: SymbolTableViewCell.self)
        return tableView
    }()

    private lazy var dataSource = makeDataSource()

    private enum Contents {
        enum Height {
            static let cell: CGFloat = 76
        }
    }

    // MARK: BaseViewController

    override func setupSubviews() {
        view.addSubviews(
            searchBar,
            tableView
        )

        searchBar.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).inset(-20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
    }

    override func bindViewModel() {
        viewModel?.reloadItems = { [weak self] items in
            guard let self else { return }
            applySnapshot(items: items, animatingDifferences: false)
        }

        viewModel?.start(in: self)
    }

}

// MARK: - Data source

extension ListViewController {

    private func makeDataSource() -> TableDataSource {
        TableDataSource(tableView: tableView) { [weak self] _, indexPath, item -> UITableViewCell? in
            guard let self else { return nil }
            switch item {
            case .symbol(let viewData):
                return createSymbolCell(at: indexPath, viewData: viewData)
            }
        }
    }

    private func applySnapshot(items: [ListTableItem], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func createSymbolCell(at indexPath: IndexPath, viewData: ListItemViewData) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SymbolTableViewCell.self)
        cell.bind(viewData: viewData)
        return cell
    }

}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Contents.Height.cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didTapItem(at: indexPath.row)
    }

}

// MARK: - UITextFieldDelegate

extension ListViewController: SearchTextFieldDelegate {

    func searchField(didChange text: String?) {
        viewModel?.searchQuery = text
    }

    func searchFieldDidTapCancelButton() {
        viewModel?.searchQuery = nil
    }

}

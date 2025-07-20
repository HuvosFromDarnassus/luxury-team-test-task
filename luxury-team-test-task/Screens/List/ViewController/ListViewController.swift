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
        tableView.separatorStyle = .none
        tableView.register(cellType: SymbolTableViewCell.self)
        tableView.register(cellType: CollectionTableViewCell.self)
        return tableView
    }()

    private lazy var dataSource = makeDataSource()
    private lazy var dataSourceHelper = DiffableDataSourceHelperImplementation<
        ListTableSection,
        ListTableItem
    >(
        tableDataSource: dataSource
    )
    private lazy var cellFactory: ListTableCellFactory = ListTableCellFactoryImplementation(tableView: tableView)

    private enum Constants {
        enum Height {
            static let header: CGFloat = 35
            static let cell: CGFloat = 76
            static let collectionCell: CGFloat = 48
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
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).inset(-20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func bindViewModel() {
        viewModel?.reloadItems = { [weak self] sections, items in
            guard let self else { return }
            applySnapshot(
                sections: sections,
                items: items,
                animatingDifferences: false
            )
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
                return cellFactory.createSymbolCell(at: indexPath, viewData: viewData)
            case .cellectionRow(let viewData):
                return cellFactory.createCollectionCell(at: indexPath, viewData: viewData)
            }
        }
    }

    private func applySnapshot(
        sections: [ListTableSection],
        items: [ListTableItem],
        animatingDifferences: Bool = true
    ) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        append(items, to: &snapshot)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func append(_ items: [ListTableItem], to snapshot: inout Snapshot) {
        let containsSymbol = items.contains {
            if case .symbol = $0 {
                return true
            }
            return false
        }

        if containsSymbol {
            snapshot.appendItems(items, toSection: .main)
        }
        else {
            items.forEach {
                if case let .cellectionRow(viewData) = $0 {
                    snapshot.appendItems([$0], toSection: viewData.section)
                }
            }
        }
    }

}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {

    /// Headers
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionType = dataSourceHelper.getSectionType(for: section) else { return .zero }
        return shouldShowHeader(for: sectionType) ? Constants.Height.header : .zero
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let sectionType = dataSourceHelper.getSectionType(for: section),
            shouldShowHeader(for: sectionType) else {
            return nil
        }

        switch sectionType {
        case .main:
            return ListTableTitleHeaderView(
                title: Strings.List.Search.Section.title,
                rightButtonTitle: Strings.List.Search.Section.more
            )
        case .popular:
            return ListTableTitleHeaderView(title: Strings.List.Search.Empty.Section.popular)
        case .searched:
            return ListTableTitleHeaderView(title: Strings.List.Search.Empty.Section.searched)
        }
    }

    /// Cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSourceHelper.getItem(at: indexPath) {
        case .symbol:
            return Constants.Height.cell
        case .cellectionRow:
            return Constants.Height.collectionCell
        case .none:
            return .zero
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case .symbol = dataSourceHelper.getItem(at: indexPath) else { return }
        viewModel?.didTapItem(at: indexPath.row)
    }

    // MARK: Helpers

    private func shouldShowHeader(for section: ListTableSection) -> Bool {
        switch section {
        case .main:
            guard
                let viewModel,
                let query = viewModel.searchQuery,
                !query.isEmpty else {
                return false
            }
            return true
        default:
            return true
        }
    }

}

// MARK: - UITextFieldDelegate

extension ListViewController: SearchTextFieldDelegate {

    func searchField(didChange text: String?) {
        viewModel?.searchQuery = text
    }

    func searchFieldDidTapClearButton() {
        viewModel?.searchQuery = nil
    }

}

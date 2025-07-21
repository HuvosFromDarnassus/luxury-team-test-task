//
//  ListViewModel.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import UIKit

protocol ListViewModelProtocol: BaseViewModelProtocol {

    // MARK: Properties

    var searchQuery: String? { get set }

    // MARK: Delegates

    var coordinatorDelegate: ListViewModelCoordinatorDelegate? { get set }

    // MARK: Callbacks

    var reloadItems: (([ListTableSection], [ListTableItem]) -> Void)? { get set }
    var updateFilterVisibility: ((Bool) -> Void)? { get set }

    // MARK: Events

    func start(in viewController: UIViewController)
    func didChangeFilter(type: ListFilter)
    func didTapItem(at index: Int)

}

final class ListViewModel: BaseViewModel, ListViewModelProtocol {

    // MARK: Properties

    var searchQuery: String? {
        didSet {
            updateItems()
        }
    }

    /// Services
    private let apiService: APIService
    private let coreDataService: CoreDataService
    ///
    private var viewController: UIViewController?
    private var filterType: ListFilter = .all {
        didSet {
            updateItems()
        }
    }
    private var allStocks: [StockModel]? {
        didSet {
            updateItems()
        }
    }
    private var favoriteStocks: [StockModel]? {
        didSet {
            updateItems()
        }
    }
    private var items: ([ListTableSection], [ListTableItem]) = ([], []) {
        didSet {
            reloadItems?(items.0, items.1)
        }
    }
    private var searchStarted = false

    // MARK: Initializers

    init(
        apiService: APIService = APIServiceImplementation(),
        coreDataService: CoreDataService = CoreDataServiceImplementation()
    ) {
        self.apiService = apiService
        self.coreDataService = coreDataService
    }

    // MARK: Delegates

    weak var coordinatorDelegate: ListViewModelCoordinatorDelegate?

    // MARK: Callbacks

    var reloadItems: (([ListTableSection], [ListTableItem]) -> Void)?
    var updateFilterVisibility: ((Bool) -> Void)?

    // MARK: Events

    func start(in viewController: UIViewController) {
        self.viewController = viewController
        fetchStocks()
    }

    func didChangeFilter(type: ListFilter) {
        filterType = type
    }

    func didTapItem(at index: Int) {
        guard case let .symbol(viewData) = items.1[safe: index] else { return }

        let symbol = viewData.symbol

        if coreDataService.isFavorite(symbol: symbol) {
            coreDataService.removeFromFavorites(symbol: symbol)
        }
        else {
            if let model = allStocks?.first(where: { $0.symbol == symbol }) {
                coreDataService.addToFavorites(model)
            }
        }

        favoriteStocks = coreDataService.fetchFavoriteStocks()
    }

    // MARK: Private

    private func fetchStocks() {
        favoriteStocks = coreDataService.fetchFavoriteStocks()
        fetchAllStocks()
    }

    private func fetchAllStocks() {
        showLoader(in: viewController, coordinatorDelegate: coordinatorDelegate)
        apiService.fetchStocks(limit: 10000) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.coordinatorDelegate?.hideLoader()
            }
            switch result {
            case .success(let stockModels):
                allStocks = stockModels
            case .failure(let error):
                LogsService.error(error.localizedDescription)
                showErrorAlert("", in: viewController, coordinatorDelegate: coordinatorDelegate)
            }
        }
    }

    private func updateItems() {
        guard let allStocks else { return }

        updateFilterVisibility?(true)

        let favoritesSet = Set(favoriteStocks?.map { $0.symbol } ?? [])
        var filteredStocks = filterType == .favorites
            ? allStocks.filter { favoritesSet.contains($0.symbol) }
            : allStocks

        guard let trimmedQuery = searchQuery?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() else {
            fillWithSymbolItems(using: filteredStocks)
            return
        }

        if trimmedQuery.isEmpty {
            fillWithCollectionRows()
            updateFilterVisibility?(false)
        }
        else {
            filteredStocks = filteredStocks.filter {
                $0.symbol.lowercased().contains(trimmedQuery) ||
                $0.name.lowercased().contains(trimmedQuery)
            }
            fillWithSymbolItems(using: filteredStocks)
            updateFilterVisibility?(false)
        }
    }

    private func fillWithCollectionRows() {
        let items: [ListTableItem] = [
            .cellectionRow(items: .init(collectionItems: mockPopularRequestsItems[0], section: .popular)),
            .cellectionRow(items: .init(collectionItems: mockPopularRequestsItems[1], section: .popular)),
            .cellectionRow(items: .init(collectionItems: mockSearchedForThisItems[0], section: .searched)),
            .cellectionRow(items: .init(collectionItems: mockSearchedForThisItems[1], section: .searched))
        ]

        self.items = ([.popular, .searched], items)
    }

    private func fillWithSymbolItems(using filteredStocks: [StockModel]) {
        let favoritesSet = Set(favoriteStocks?.map { $0.symbol } ?? [])
        let items: [ListTableItem] = filteredStocks.enumerated().compactMap { index, model in
            return .symbol(viewData: .init(
                imageURL: apiService.imageURL(for: model.symbol),
                symbol: model.symbol,
                isFavorite: favoritesSet.contains(model.symbol),
                name: model.name,
                price: "$\(model.price)",
                change: model.changeInfo().text,
                changeColor: model.changeInfo().color,
                cellBackgroundColor: index % 2 == 0 ? .clear : Colors.Common.commonBackground.color
            ))
        }

        self.items = ([.main], items)
    }

}

// MARK: - Mock data

fileprivate let mockPopularRequestsItems: [[String]] = [
    ["Apple", "Amazon", "Google", "Tesla", "Microsoft"],
    ["First Solar", "Alibaba", "Facebook", "Mastercard"]
]

fileprivate let mockSearchedForThisItems: [[String]] = [
    ["Nvidia", "Nokia", "Yandex", "GM", "Microsoft"],
    ["Baidu", "Intel", "AMD", "Visa"]
]

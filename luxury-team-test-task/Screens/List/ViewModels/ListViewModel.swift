//
//  ListViewModel.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import UIKit

protocol ListViewModelProtocol: BaseViewModelProtocol {

    // MARK: Properties

    var searchQuery: String { get set }

    // MARK: Delegates

    var coordinatorDelegate: ListViewModelCoordinatorDelegate? { get set }

    // MARK: Callbacks

    var reloadItems: (([ListTableItem]) -> Void)? { get set }

    // MARK: Events

    func start(in viewController: UIViewController)
    func didChangeFilter(type: ListFilter)
    func didTapItem(at index: Int)

}

final class ListViewModel: BaseViewModel, ListViewModelProtocol {

    // MARK: Properties

    var searchQuery: String = "" {
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
    private var items: [ListTableItem] = [] {
        didSet {
            reloadItems?(items)
        }
    }

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

    var reloadItems: (([ListTableItem]) -> Void)?

    // MARK: Events

    func start(in viewController: UIViewController) {
        self.viewController = viewController
        fetchStocks()
    }

    func didChangeFilter(type: ListFilter) {
        filterType = type
    }

    func didTapItem(at index: Int) {
        guard case let .symbol(viewData) = items[safe: index] else { return }

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
        apiService.fetchStocks { [weak self] result in
            guard let self else { return }
            coordinatorDelegate?.hideLoader()
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

        let favoritesSet = Set(favoriteStocks?.map { $0.symbol } ?? [])
        var filteredStocks = filterType == .favorites
            ? allStocks.filter { favoritesSet.contains($0.symbol) }
            : allStocks

        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if !query.isEmpty {
            filteredStocks = filteredStocks.filter {
                $0.symbol.lowercased().contains(query) ||
                $0.name.lowercased().contains(query)
            }
        }

        let items: [ListTableItem] = filteredStocks.enumerated().compactMap { index, model in
            return .symbol(viewData: .init(
                imageURLString: model.logo,
                symbol: model.symbol,
                isFavorite: favoritesSet.contains(model.symbol),
                name: model.name,
                price: "$\(model.price)",
                change: model.changeInfo().text,
                changeColor: model.changeInfo().color,
                cellBackgroundColor: index % 2 == 0 ? .clear : Colors.Common.commonBackground.color
            ))
        }

        self.items = items
    }

}

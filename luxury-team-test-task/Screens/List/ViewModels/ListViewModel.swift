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
            // TODO: Implementation
        }
    }

    /// Services
    private let apiService: APIService
    private let coreDataService: CoreDataService

    private var viewController: UIViewController?
    private var stockModels: [StockModel]? {
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
        // TODO: Implementation
    }

    func didTapItem(at index: Int) {
        // TODO: Implementation
    }

    // MARK: Private

    private func fetchStocks() {
        showLoader(in: viewController, coordinatorDelegate: coordinatorDelegate)
        apiService.fetchStocks { [weak self] result in
            guard let self else { return }
            coordinatorDelegate?.hideLoader()
            switch result {
            case .success(let stockModels):
                self.stockModels = stockModels
            case .failure(let error):
                LogsService.error(error.localizedDescription)
                showErrorAlert("", in: viewController, coordinatorDelegate: coordinatorDelegate)
            }
        }
    }

    private func updateItems() {
        guard let stockModels else { return }
        let items: [ListTableItem] = stockModels.enumerated().compactMap { index, model in
            return .symbol(viewData: .init(
                imageURLString: model.logo,
                symbol: model.symbol,
                isFavorite: false,
                name: model.name,
                price: "$\(model.price)",
                change: model.changeInfo().text,
                changeColor: model.changeInfo().color,
                cellBackgroundColor: index % 2 == 0 ? .clear : Colors.Common.commonBackground.color)
            )
        }

        self.items = items
    }

}

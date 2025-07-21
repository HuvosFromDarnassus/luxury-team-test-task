//
//  ListFilterTabsView.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 20/07/2025.
//

import UIKit

enum ListFilter: CaseIterable {

    case all
    case favorites

    var title: String {
        switch self {
        case .all:          Strings.List.Tab.stocks
        case .favorites:    Strings.List.Tab.favourite
        }
    }

}

protocol ListFilterDelegate: AnyObject {

    func listFilter(didChange filter: ListFilter)

}

final class ListFilterTabsView: UIView {

    // MARK: Properties

    weak var delegate: ListFilterDelegate?
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    private let stackSpacerView: UIView = {
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacerView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return spacerView
    }()
    private var tabButtons: [UIButton] = []
    private var selectedTab: ListFilter = .all {
        didSet {
            updateTabsButtons()
            delegate?.listFilter(didChange: selectedTab)
        }
    }

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialization() {
        backgroundColor = .clear
        setupTabs()
        addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        selectedTab = .all
    }

    // MARK: Actions

    @objc
    private func didTapFilterButton(_ sender: UIButton) {
        guard sender.tag < ListFilter.allCases.count else { return }
        selectedTab = ListFilter.allCases[sender.tag]
    }

    // MARK: Private

    private func setupTabs() {
        ListFilter.allCases.forEach { filter in
            let button = UIButton(type: .system)
            button.setTitle(filter.title, for: .normal)
            button.setTitleColor(Colors.Common.commonGray.color, for: .normal)
            button.titleLabel?.font = Fonts.Montserrat.bold.font(size: 18)
            button.tag = tabButtons.count
            button.addTarget(self, action: #selector(didTapFilterButton(_:)), for: .touchUpInside)
            tabButtons.append(button)
            stackView.addArrangedSubview(button)
        }

        stackView.addArrangedSubview(stackSpacerView)
    }

    private func updateTabsButtons() {
        for (index, button) in tabButtons.enumerated() {
            let filter = ListFilter.allCases[index]
            let isSelected = filter == selectedTab
            button.setTitleColor(isSelected ? Colors.Common.commonBlack.color : Colors.Common.commonGray.color, for: .normal)
            button.titleLabel?.font = Fonts.Montserrat.bold.font(size: isSelected ? 28 : 18)
        }
    }

}

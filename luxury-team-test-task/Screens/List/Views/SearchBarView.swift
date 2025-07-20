//
//  SearchBarView.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 20/07/2025.
//

import UIKit

protocol SearchTextFieldDelegate: AnyObject {

    func searchField(didChange text: String?)
    func searchFieldDidTapCancelButton()

}

final class SearchBarView: UIView {

    // MARK: Properties

    weak var delegate: SearchTextFieldDelegate?
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.Icons.searchIcon.image, for: .normal)
        button.tintColor = Colors.Common.commonBlack.color
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        return button
    }()
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.font = Fonts.Montserrat.semiBold.font(size: 16)
        textField.textColor = Colors.Common.commonBlack.color
        textField.backgroundColor = Colors.Common.commonWhite.color
        textField.returnKeyType = .search
        let placeholderText = Strings.List.Search.placeholder
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.Common.commonBlack.color,
            .font: Fonts.Montserrat.semiBold.font(size: 16)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        return textField
    }()
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.Icons.closeIcon.image, for: .normal)
        button.tintColor = Colors.Common.commonBlack.color
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialization() {
        backgroundColor = Colors.Common.commonWhite.color
        layer.cornerRadius = 24
        layer.borderColor = Colors.Common.commonBlack.color.cgColor
        layer.borderWidth = 1

        addSubviews(
            leftButton,
            searchTextField,
            rightButton
        )

        leftButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        searchTextField.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(leftButton.snp.trailing).inset(-8)
            $0.trailing.equalTo(rightButton.snp.leading).inset(-8)
        }
        rightButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: Actions

    @objc
    private func didTapLeftButton() {
        clearTextField()
    }

    @objc
    private func didTapRightButton() {
        clearTextField()
    }

    // MARK: Private

    private func clearTextField() {
        endEditing(true)
        searchTextField.text = nil
        leftButton.setImage(Images.Icons.searchIcon.image, for: .normal)
        rightButton.isHidden = true
        delegate?.searchFieldDidTapCancelButton()
    }

}

// MARK: - UITextFieldDelegate

extension SearchBarView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        leftButton.setImage(Images.Icons.backIcon.image, for: .normal)
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard
            let currentText = textField.text,
            let textRange = Range(range, in: currentText) else {
            return true
        }

        let updatedText = currentText.replacingCharacters(in: textRange, with: string)

        rightButton.isHidden = updatedText.isEmpty
        delegate?.searchField(didChange: updatedText)

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        leftButton.setImage(Images.Icons.searchIcon.image, for: .normal)
    }

}

//
//  OnboardingView.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 11.09.2022.
//

import UIKit

final class OnboardingView: UIView {
    //MARK: -Properties
    ///Основное изображение
    private lazy var mainImageView: UIImageView = {
        let mainView = UIImageView()
        mainView.contentMode = .scaleAspectFit
        mainView.toAutoLayout()
        return mainView
    }()
    ///Заголовок
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .center
        titleLabel.toAutoLayout()
        return titleLabel
    }()
    ///Первый Label
    private lazy var firstTextLabel: UILabel = {
        let firstTextLabel = UILabel()
        firstTextLabel.numberOfLines = 2
        firstTextLabel.textAlignment = .center
        firstTextLabel.toAutoLayout()
        return firstTextLabel
    }()
    ///Второй Label
    private lazy var secondTextLabel: UILabel = {
        let secondTextLabel = UILabel()
        secondTextLabel.numberOfLines = 2
        secondTextLabel.textAlignment = .center
        secondTextLabel.toAutoLayout()
        return secondTextLabel
    }()
    ///Кнопка зазрешить доступ
    private lazy var accessButton: UIButton = {
        let accessButton = UIButton(type: .system)
        accessButton.layer.cornerRadius = 10
        accessButton.addTarget(self, action: #selector(accessButtonTapped), for: .touchUpInside)
        accessButton.toAutoLayout()
        return accessButton
    }()
    ///Кнопка запретить доступ
    private lazy var declineButton: UIButton = {
        let declineButton = UIButton(type: .system)
        declineButton.toAutoLayout()
        declineButton.addTarget(self, action: #selector(declineButtonTapped), for: .touchUpInside)
        return declineButton
    }()
    //MARK: - Objc Methods
    ///Действие по нажатию accessButton
    @objc private func accessButtonTapped(_ sender: UIButton) {
        accessIsAllowed?()
    }
    ///Действие по нажатию declineButton
    @objc private func declineButtonTapped(_ sender: UIButton) {
        accessNotAllowed?()
    }
    //MARK: - Methods
    private func setupConstraints() {
        [
            mainImageView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 16.0
            ),
            mainImageView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 16.0
            ),
            mainImageView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -16.0
            ),
            mainImageView.heightAnchor.constraint(
                equalToConstant: 200.0
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 26.0
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -26.0
            ),
            titleLabel.topAnchor.constraint(
                equalTo: mainImageView.bottomAnchor,
                constant: 26.0
            ),
            firstTextLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 26.0
            ),
            firstTextLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -26.0
            ),
            firstTextLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 36.0
            ),
            secondTextLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 26.0
            ),
            secondTextLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -26.0
            ),
            secondTextLabel.topAnchor.constraint(
                equalTo: firstTextLabel.bottomAnchor,
                constant: 14.0
            ),
            accessButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 18.0
            ),
            accessButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -18.0
            ),
            accessButton.topAnchor.constraint(
                equalTo: secondTextLabel.bottomAnchor,
                constant: 44.0
            ),
            accessButton.heightAnchor.constraint(
                equalToConstant: 40.0
            ),
            declineButton.topAnchor.constraint(
                equalTo: accessButton.bottomAnchor,
                constant: 26.0
            ),
            declineButton.trailingAnchor.constraint(
                equalTo: accessButton.trailingAnchor
            ),
//            declineButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ].forEach { $0.isActive = true }
    }
    ///Настройка UI
    private func setupUI() {
        backgroundColor = Colors.blue.color
        addSubviews(
            mainImageView,
            titleLabel,
            firstTextLabel,
            secondTextLabel,
            accessButton,
            declineButton
        )
    }
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Interface
    ///Доступ получен
    var accessIsAllowed: (() -> Void)?
    ///Доступ не получен
    var accessNotAllowed: (()-> Void)?
}
//MARK: - Extension
extension OnboardingView: Setupable {
    func setup(withModel model: ModelProtocol) {
        guard let model = model as? OnboardingModel.ViewModel else { return }
        ///mainImageView
        mainImageView.image = model.mainViewImage
        ///titleLabel
        titleLabel.font = model.titleLabelFont
        titleLabel.textColor = model.titleLabelTextColor
        titleLabel.attributedText = NSMutableAttributedString(
            string: model.titleLabelText,
            attributes: model.titleLabelAttributes
        )
        ///firstTextLabel
        firstTextLabel.font = model.firstTextLabelFont
        firstTextLabel.textColor = model.firstTextLabelTextColor
        firstTextLabel.attributedText = NSMutableAttributedString(
            string: model.firstTextLabelText,
            attributes: model.firstTextLabelAttributes
        )
        ///secondTextLabel
        secondTextLabel.font = model.secondTextLabelFont
        secondTextLabel.textColor = model.secondTextLabelTextColor
        secondTextLabel.attributedText = NSMutableAttributedString(
            string: model.secondTextLabelText,
            attributes: model.secondTextLabelAttributes
        )
        ///accessButton
        accessButton.titleLabel?.font = model.accessButtonTitleFont
        let titleAccessButton = NSMutableAttributedString(
            string: model.accessButtonText,
            attributes: model.accessButtonAttributes
        )
        accessButton.setAttributedTitle(titleAccessButton, for: .normal)
        accessButton.setTitleColor(model.accessButtonTitleColor, for: .normal)
        accessButton.backgroundColor = model.accessButtonBackgroundColor
        ///declineButton
        declineButton.titleLabel?.font = model.declineButtonTitleFont
        let titleDeclineButton = NSMutableAttributedString(
            string: model.declineButtonText,
            attributes: model.declineButtonAttributes
        )
        declineButton.setAttributedTitle(titleDeclineButton, for: .normal)
        declineButton.setTitleColor(model.declineButtonTitleColor, for: .normal)
    }
}

//
//  SettingView.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 21.12.2022.
//

import Foundation
import UIKit

final class SettingView: UIView {
    //MARK: -Properties
    ///Иконка первого обалака
    private lazy var cloudOneImageView: UIImageView = {
        let cloudOneImageView = UIImageView()
        cloudOneImageView.alpha = 0.3
        cloudOneImageView.toAutoLayout()
        return cloudOneImageView
    }()
    ///Иконка второго обалака
    private lazy var cloudTwoImageView: UIImageView = {
        let cloudTwoImageView = UIImageView()
        cloudTwoImageView.contentMode = .scaleAspectFit
        cloudTwoImageView.toAutoLayout()
        return cloudTwoImageView
    }()
    ///Иконка третьего обалака
    private lazy var cloudThreeImageView: UIImageView = {
        let cloudThreeImageView = UIImageView()
        cloudThreeImageView.toAutoLayout()
        return cloudThreeImageView
    }()
    ///View для расположения настроек
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = 10.0
        contentView.toAutoLayout()
        return contentView
    }()
    ///Заголовок
    private lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.toAutoLayout()
        return titleLable
    }()
    ///Label тепературы
    private lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.toAutoLayout()
        return temperatureLabel
    }()
    ///Label скорости ветра
    private lazy var windSpeedLabel: UILabel = {
        let windSpeedLabel = UILabel()
        windSpeedLabel.toAutoLayout()
        return windSpeedLabel
    }()
    ///Label формата времени
    private lazy var timeFormatLabel: UILabel = {
        let timeFormat = UILabel()
        timeFormat.toAutoLayout()
        return timeFormat
    }()
    ///Label уведомлений
    private lazy var notificationLabel: UILabel = {
        let notificationLabel = UILabel()
        notificationLabel.toAutoLayout()
        return notificationLabel
    }()
    ///Кнопка устанавливающая настройки
    private lazy var setupButton: UIButton = {
        let setupButton = UIButton(type: .system)
        setupButton.addTarget(self, action: #selector(setupButtonDidTapped), for: .touchUpInside)
        setupButton.layer.cornerRadius = 10.0
        setupButton.toAutoLayout()
        return setupButton
    }()
    ///Переключатель температуры
    private lazy var temperatureSegmentedControl: UISegmentedControl = {
        let items = ["C", "F"]
        let temperatureSegmentedControll = UISegmentedControl(items: items)
        temperatureSegmentedControll.addTarget(
            self,
            action: #selector(tempSegmentDidTapped),
            for: .valueChanged
        )
        temperatureSegmentedControll.toAutoLayout()
        return temperatureSegmentedControll
    }()
    ///Переключатель скорости ветра
    private lazy var windSpeedSegmentedControl: UISegmentedControl = {
        let options = ["М/С", "Я/С"]
        let windSpeedSegmentedControll = UISegmentedControl(items: options)
        windSpeedSegmentedControll.addTarget(
            self,
            action: #selector(windSpeedSegmentDidTapped),
            for: .valueChanged
        )
        windSpeedSegmentedControll.toAutoLayout()
        return windSpeedSegmentedControll
    }()
    ///Переключатель формата времени
    private lazy var timeFormatSegmentedControl: UISegmentedControl = {
        let options = ["24", "12"]
        let timeFormatSegmentedControll = UISegmentedControl(items: options)
        timeFormatSegmentedControll.addTarget(
            self,
            action: #selector(timeFormatSegmentDidTapped),
            for: .valueChanged
        )
        timeFormatSegmentedControll.toAutoLayout()
        return timeFormatSegmentedControll
    }()
    ///Переключатель уведомлений
    private lazy var notificationSegmentedControl: UISegmentedControl = {
        let options = ["On", "Off"]
        let notificationSegmentedControll = UISegmentedControl(items: options)
        notificationSegmentedControll.isEnabled = false
        notificationSegmentedControll.addTarget(
            self,
            action: #selector(notificationSegmentDidTapped),
            for: .valueChanged
        )
        notificationSegmentedControll.toAutoLayout()
        return notificationSegmentedControll
    }()
    //MARK: - Objc Methods
    ///Действие по нажатию на setupButton
    @objc private func setupButtonDidTapped() {
        setupButtonAction?()
    }
    ///Действие при изменении формата температуры
    @objc private func tempSegmentDidTapped(sender: UISegmentedControl) {
        tempSegmentAction?(sender.selectedSegmentIndex)
    }
    ///Действие при изменении формата скорости
    @objc private func windSpeedSegmentDidTapped(sender: UISegmentedControl) {
        windSpeedSegmentAction?(sender.selectedSegmentIndex)
    }
    ///Действие при изменении формата времени
    @objc private func timeFormatSegmentDidTapped(sender: UISegmentedControl) {
        timeFormatSegmentAction?(sender.selectedSegmentIndex)
    }
    ///Действие по нажатию на сегментед контрол нотификаций
    @objc private func notificationSegmentDidTapped(sender: UISegmentedControl) {
        notificationSegmentAction?(sender.selectedSegmentIndex)
    }
    //MARK: - Methods
    ///Настройка UI
    private func setupUI() {
        backgroundColor = Colors.blue.color
        addSubviews(cloudOneImageView, cloudTwoImageView, cloudThreeImageView, contentView)
        contentView.addSubviews(
            titleLable,
            temperatureLabel,
            windSpeedLabel,
            timeFormatLabel,
            notificationLabel,
            setupButton,
            temperatureSegmentedControl,
            windSpeedSegmentedControl,
            timeFormatSegmentedControl,
            notificationSegmentedControl
        )
    }
    ///Настройка констрейнтов
    private func setupConstraints() {
        [
            contentView.centerXAnchor.constraint(
                equalTo: centerXAnchor
            ),
            contentView.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
            contentView.heightAnchor.constraint(
                equalToConstant: 330.0
            ),
            contentView.widthAnchor.constraint(
                equalToConstant: 320.0
            ),
            cloudOneImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 36.0
            ),
            cloudOneImageView.heightAnchor.constraint(
                equalToConstant: 58.1
            ),
            cloudOneImageView.widthAnchor.constraint(
                equalToConstant: 300.4
            ),
            cloudTwoImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 120.0
            ),
            cloudTwoImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            cloudTwoImageView.heightAnchor.constraint(
                equalToConstant: 94.0
            ),
            cloudTwoImageView.widthAnchor.constraint(
                equalToConstant: 182.0
            ),
            cloudThreeImageView.centerXAnchor.constraint(
                equalTo: centerXAnchor
            ),
            cloudThreeImageView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -120.0
            ),
            cloudThreeImageView.heightAnchor.constraint(
                equalToConstant: 66.0
            ),
            cloudThreeImageView.widthAnchor.constraint(
                equalToConstant: 216.0
            ),
            titleLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20.0
            ),
            titleLable.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 28.0
            ),
            temperatureLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20.0
            ),
            temperatureLabel.topAnchor.constraint(
                equalTo: titleLable.bottomAnchor,
                constant: 20.0
            ),
            windSpeedLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20.0
            ),
            windSpeedLabel.topAnchor.constraint(
                equalTo: temperatureLabel.bottomAnchor,
                constant: 30.0
            ),
            timeFormatLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20.0
            ),
            timeFormatLabel.topAnchor.constraint(
                equalTo: windSpeedLabel.bottomAnchor,
                constant: 30.0
            ),
            notificationLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20.0
            ),
            notificationLabel.topAnchor.constraint(
                equalTo: timeFormatLabel.bottomAnchor,
                constant: 30.0
            ),
            setupButton.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            setupButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16.0
            ),
            setupButton.heightAnchor.constraint(
                equalToConstant: 40.0
            ),
            setupButton.widthAnchor.constraint(
                equalToConstant: 250.0
            ),
            temperatureSegmentedControl.centerYAnchor.constraint(
                equalTo: temperatureLabel.centerYAnchor
            ),
            temperatureSegmentedControl.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -30.0
            ),
            temperatureSegmentedControl.heightAnchor.constraint(
                equalToConstant: 30.0
            ),
            temperatureSegmentedControl.widthAnchor.constraint(
                equalToConstant: 80.0
            ),
            windSpeedSegmentedControl.centerYAnchor.constraint(
                equalTo: windSpeedLabel.centerYAnchor
            ),
            windSpeedSegmentedControl.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -30.0
            ),
            windSpeedSegmentedControl.heightAnchor.constraint(
                equalToConstant: 30.0
            ),
            windSpeedSegmentedControl.widthAnchor.constraint(
                equalToConstant: 80.0
            ),
            timeFormatSegmentedControl.centerYAnchor.constraint(
                equalTo: timeFormatLabel.centerYAnchor
            ),
            timeFormatSegmentedControl.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -30.0
            ),
            timeFormatSegmentedControl.heightAnchor.constraint(
                equalToConstant: 30.0
            ),
            timeFormatSegmentedControl.widthAnchor.constraint(
                equalToConstant: 80.0
            ),
            notificationSegmentedControl.centerYAnchor.constraint(
                equalTo: notificationLabel.centerYAnchor
            ),
            notificationSegmentedControl.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -30.0
            ),
            notificationSegmentedControl.heightAnchor.constraint(
                equalToConstant: 30.0
            ),
            notificationSegmentedControl.widthAnchor.constraint(
                equalToConstant: 80.0
            ),
        ].forEach { $0.isActive = true }
    }
    //MARK: - Init
    init() {
        super.init(frame: .zero)
//        setupView()
        setupUI()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Interface
    var setupButtonAction: (() -> Void)?
    var tempSegmentAction: ((Int) -> Void)?
    var windSpeedSegmentAction: ((Int) -> Void)?
    var timeFormatSegmentAction: ((Int) -> Void)?
    var notificationSegmentAction: ((Int) -> Void)?

    lazy var setupTemp: ((Int) -> Void) = { [weak self] index in
        guard let self = self else { return }
        if index == 1 {
            self.temperatureSegmentedControl.selectedSegmentIndex = 0
        } else if index == 2 {
            self.temperatureSegmentedControl.selectedSegmentIndex = 1
        }
    }

    lazy var setupWindSpeed: ((Int) -> Void) = { [weak self] index in
        guard let self = self else { return }
        if index == 1 {
            self.windSpeedSegmentedControl.selectedSegmentIndex = 0
        } else if index == 2 {
            self.windSpeedSegmentedControl.selectedSegmentIndex = 1
        }
    }

    lazy var setupTimeFormat: ((Int) -> Void) = { [weak self] index in
        guard let self = self else { return }
        if index == 2 {
            self.timeFormatSegmentedControl.selectedSegmentIndex = 0
        } else if index == 1 {
            self.timeFormatSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    lazy var setupNotification: ((Int) -> Void) = { [weak self] index in
        guard let self = self else { return }
        if index == 1 {
            self.notificationSegmentedControl.selectedSegmentIndex = 0
        } else {
            self.notificationSegmentedControl.selectedSegmentIndex = 1
        }
    }
}
//MARK: - Extention Setupable
extension SettingView: Setupable {
    func setup(withModel model: ModelProtocol) {
        guard let model = model as? SettingModel.ViewModel else { return }
        cloudOneImageView.image = model.cloudOneImage
        cloudTwoImageView.image = model.cloudTwoImage
        cloudThreeImageView.image = model.cloudThreeImage
        contentView.backgroundColor = model.contentViewBackgroundColor

        titleLable.font = model.titleLableFont
        titleLable.textColor = model.titleLableTextColor
        titleLable.attributedText = NSMutableAttributedString(
            string: model.titleLableText,
            attributes: model.titleLableAttributes
        )

        temperatureLabel.font = model.temperatureLabelFont
        temperatureLabel.textColor = model.temperatureLabelTextColor
        temperatureLabel.attributedText = NSMutableAttributedString(
            string: model.temperatureLabelText,
            attributes: model.temperatureLabelAttributes
        )

        windSpeedLabel.font = model.windSpeedLabelFont
        windSpeedLabel.textColor = model.windSpeedLabelTextColor
        windSpeedLabel.attributedText = NSMutableAttributedString(
            string: model.windSpeedLabelText,
            attributes: model.windSpeedLabelAttributes
        )

        timeFormatLabel.font = model.timeFormatLabelFont
        timeFormatLabel.textColor = model.timeFormatLabelTextColor
        timeFormatLabel.attributedText = NSMutableAttributedString(
            string: model.timeFormatLabelText,
            attributes: model.timeFormatLabelAttributes
        )

        let buttonTitle = NSMutableAttributedString(
            string: model.setupButtonTitleText,
            attributes: model.setupButtonTitleAttributes
        )
        setupButton.setAttributedTitle(buttonTitle, for: .normal)
        setupButton.titleLabel?.font = model.setupButtonTitleLabelFont
        setupButton.setTitleColor(model.setupButtonTitleColor, for: .normal)
        setupButton.backgroundColor = model.setupButtonBackgroundColor

        notificationLabel.font = model.notificationLabelFont
        notificationLabel.textColor = model.notificationLabelTextColor
        notificationLabel.attributedText = NSMutableAttributedString(
            string: model.notificationLabelText,
            attributes: model.notificationLabelAttributes
        )

        temperatureSegmentedControl.backgroundColor = model.temperatureSegmentedControlBackgroundColor
        temperatureSegmentedControl.selectedSegmentTintColor = model.temperatureSegmentedControlSelectedTintColor
        temperatureSegmentedControl.setTitleTextAttributes(
            [.foregroundColor: model.temperatureSegmentedControlTitleTextColor],
            for: .selected
        )

        windSpeedSegmentedControl.backgroundColor = model.windSpeedSegmentedControlBackgroundColor
        windSpeedSegmentedControl.selectedSegmentTintColor = model.windSpeedSegmentedControlSelectedTintColor
        windSpeedSegmentedControl.setTitleTextAttributes(
            [.foregroundColor: model.windSpeedSegmentedControlTitleTextColor],
            for: .selected
        )

        timeFormatSegmentedControl.backgroundColor = model.timeFormatSegmentedControlBackgroundColor
        timeFormatSegmentedControl.selectedSegmentTintColor = model.timeFormatSegmentedControlSelectedTintColor
        timeFormatSegmentedControl.setTitleTextAttributes(
            [.foregroundColor: model.timeFormatSegmentedControlTitleTextColor],
            for: .selected
        )

        notificationSegmentedControl.backgroundColor = model.notificationSegmentedControlBackgroundColor
        notificationSegmentedControl.selectedSegmentTintColor = model.notificationSegmentedControlSelectedTintColor
        notificationSegmentedControl.setTitleTextAttributes(
            [.foregroundColor: model.timeFormatSegmentedControlTitleTextColor],
            for: .selected
        )
    }
}

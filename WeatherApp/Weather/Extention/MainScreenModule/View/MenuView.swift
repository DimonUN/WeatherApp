//
//  MenuView.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 30.08.2022.
//

import UIKit

protocol MenuDelegate {
    func setSettings()
}
///Боковое меню в mainScreenModule
final class MenuView: UIView {
    //MARK: - Properties
    ///Констрейнты
    private var contentViewLeadingConstraints: NSLayoutConstraint?
    private var contentViewTrailingConstraints: NSLayoutConstraint?
    private var navigationController: UINavigationController?
    private var mainScreenDelegate: MainScreenDelegate

    private var changeblePropertiesModel: MainScreenModel.ChangebleModel?

    private lazy var swipeGesture: UISwipeGestureRecognizer = {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(tappedAction))
        swipeGesture.direction = .left
        return swipeGesture
    }()
    ///View открывается на весь экран
    private lazy var mainContentView: UIView = {
        let scrollView = UIView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    ///View в котором находится весь контент меню
    private lazy var contentView: UIView = {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: 300.0, height: frame.height))
        contentView.toAutoLayout()
        return contentView
    }()
    
    private lazy var weatherTitleLabel: UILabel = {
        let weatherTitleLabel = UILabel()
        weatherTitleLabel.toAutoLayout()
        return weatherTitleLabel
    }()

    private lazy var weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.toAutoLayout()
        return weatherImageView
    }()

    private lazy var separationLine: UIView = {
        let separationLine = UIView()
        separationLine.toAutoLayout()
        return separationLine
    }()

    private lazy var editLabel: UILabel = {
        let editLabel = UILabel()
        editLabel.numberOfLines = 0
        editLabel.toAutoLayout()
        return editLabel
    }()

    private lazy var editImageButton: UIButton = {
        let editImageView = UIButton(type: .system)
        editImageView.addTarget(self, action: #selector(editDidTapped), for: .touchUpInside)
        editImageView.toAutoLayout()
        return editImageView
    }()

    private lazy var geoLabel: UILabel = {
        let geoLabel = UILabel()
        geoLabel.numberOfLines = 0
        geoLabel.toAutoLayout()
        return geoLabel
    }()

    private lazy var geoImageButton: UIButton = {
        let geoImageView = UIButton(type: .system)
        geoImageView.addTarget(self, action: #selector(geoDidTapped), for: .touchUpInside)
        geoImageView.toAutoLayout()
        return geoImageView
    }()

    private lazy var notificationLabel: UILabel = {
        let notificationLabel = UILabel()
        notificationLabel.toAutoLayout()
        return notificationLabel
    }()

    private lazy var notificationImageView: UIImageView = {
        let notificationImageView = UIImageView()
        notificationImageView.toAutoLayout()
        return notificationImageView
    }()

    private lazy var daytimeWeatherLabel: UILabel = {
        let daytimeWeatherLabel = UILabel()
        daytimeWeatherLabel.toAutoLayout()
        return daytimeWeatherLabel
    }()

    private lazy var daytimeWeatherImageView: UIImageView = {
        let daytimeWeatherImageView = UIImageView()
        daytimeWeatherImageView.toAutoLayout()
        return daytimeWeatherImageView
    }()

    private lazy var temperatureTitleLabel: UILabel = {
        let temperatureTitleLabel = UILabel()
        temperatureTitleLabel.toAutoLayout()
        return temperatureTitleLabel
    }()

    private lazy var temperatureImageView: UIImageView = {
        let temperatureImageView = UIImageView()
        temperatureImageView.toAutoLayout()
        return temperatureImageView
    }()

    private lazy var windSpeedTitleLabel: UILabel = {
        let windSpeedTitleLabel = UILabel()
        windSpeedTitleLabel.toAutoLayout()
        return windSpeedTitleLabel
    }()

    private lazy var windSpeedImageView: UIImageView = {
        let windSpeedUnitImageView = UIImageView()
        windSpeedUnitImageView.toAutoLayout()
        return windSpeedUnitImageView
    }()

    private lazy var visibilityTitleLabel: UILabel = {
        let visibilityTitleLabel = UILabel()
        visibilityTitleLabel.toAutoLayout()
        return visibilityTitleLabel
    }()

    private lazy var visibilityImageView: UIImageView = {
        let visibilityImageView = UIImageView()
        visibilityImageView.toAutoLayout()
        return visibilityImageView
    }()

    private lazy var timeFormatLabel: UILabel = {
        let timeFormatLabel = UILabel()
        timeFormatLabel.toAutoLayout()
        return timeFormatLabel
    }()

    private lazy var timeFormatImageView: UIImageView = {
        let timeFormatImageView = UIImageView()
        timeFormatImageView.toAutoLayout()
        return timeFormatImageView
    }()

    private lazy var dateFormatLabel: UILabel = {
        let dateFormatLabel = UILabel()
        dateFormatLabel.toAutoLayout()
        return dateFormatLabel
    }()

    private lazy var dateFormatImageView: UIImageView = {
        let dateFormatImageView = UIImageView()
        dateFormatImageView.toAutoLayout()
        return dateFormatImageView
    }()

    private lazy var dottedContentView: UIView = {
        let dottedContentView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: contentView.frame.width,
                height: 1.0
            )
        )
        dottedContentView.toAutoLayout()
        return dottedContentView
    }()

    private lazy var temperatureUnitLabel: UILabel = {
        let temperatureUnitLabel = UILabel()
        temperatureUnitLabel.toAutoLayout()
        return temperatureUnitLabel
    }()

    private lazy var windSpeedUnitLabel: UILabel = {
        let windSpeedUnitLabel = UILabel()
        windSpeedUnitLabel.toAutoLayout()
        return windSpeedUnitLabel
    }()

    private lazy var visibilityUnitLabel: UILabel = {
        let visibilityUnitLabel = UILabel()
        visibilityUnitLabel.toAutoLayout()
        return visibilityUnitLabel
    }()

    private lazy var timeFormatUnitLabel: UILabel = {
        let timeFormatUnitLabel = UILabel()
        timeFormatUnitLabel.toAutoLayout()
        return timeFormatUnitLabel
    }()

    private lazy var dateFormatUnitLabel: UILabel = {
        let dateFormatUnitLabel = UILabel()
        dateFormatUnitLabel.toAutoLayout()
        return dateFormatUnitLabel
    }()
    private lazy var switchNotification: UISwitch = {
        let switchNotification = UISwitch()
        switchNotification.set(width: 25, height: 15)
        switchNotification.toAutoLayout()
        return switchNotification
    }()

    private lazy var switchDaytimeWeather: UISwitch = {
        let switchNotification = UISwitch()
        switchNotification.set(width: 25, height: 15)
        switchNotification.toAutoLayout()
        return switchNotification
    }()
    //MARK: - Methods
    private func setupUI() {
        addSubviews(mainContentView)
        mainContentView.addSubviews(contentView)
        contentView.addSubviews(
            dottedContentView,
            weatherImageView,
            weatherTitleLabel,
            separationLine,
            editImageButton,
            editLabel,
            geoImageButton,
            geoLabel,
            notificationImageView,
            notificationLabel,
            daytimeWeatherLabel,
            daytimeWeatherImageView,
            temperatureTitleLabel,
            temperatureImageView,
            windSpeedTitleLabel,
            windSpeedImageView,
            visibilityTitleLabel,
            visibilityImageView,
            timeFormatLabel,
            timeFormatImageView,
            dateFormatLabel,
            dateFormatImageView,
            switchNotification,
            switchDaytimeWeather,
            temperatureUnitLabel,
            windSpeedUnitLabel,
            visibilityUnitLabel,
            timeFormatUnitLabel,
            dateFormatUnitLabel
        )
    }
    ///Нарисовать пунктирную линию
    private func drawDottedLine(onView view: UIView) {
        let startPoint = CGPoint(x: dottedContentView.frame.minX, y: dottedContentView.frame.minY)
        let endPoint = CGPoint(x: dottedContentView.frame.maxX - 20.0, y: dottedContentView.frame.minY)

        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = Colors.white.color.cgColor
        shapeLayer.lineWidth = 0.5
        shapeLayer.lineDashPattern = [7, 3]
        let path = CGMutablePath()
        path.addLines(between: [startPoint, endPoint])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }

    private func setupConstraints() {
        contentViewLeadingConstraints = mainContentView.leadingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.leadingAnchor
        )
        contentViewLeadingConstraints?.isActive = true
        contentViewTrailingConstraints = mainContentView.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor
        )
        contentViewTrailingConstraints?.isActive = true
        let leading: CGFloat = 16.0
        [
            mainContentView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            mainContentView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            ),

            contentView.leadingAnchor.constraint(
                equalTo: mainContentView.leadingAnchor
            ),
            contentView.topAnchor.constraint(
                equalTo: mainContentView.topAnchor
            ),
            contentView.bottomAnchor.constraint(
                equalTo: mainContentView.bottomAnchor
            ),
            contentView.widthAnchor.constraint(
                equalToConstant: 300.0
            ),

            weatherImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: leading
            ),
            weatherImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 20.0
            ),
            weatherImageView.widthAnchor.constraint(
                equalToConstant: 25.0
            ),
            weatherImageView.heightAnchor.constraint(
                equalToConstant: 22.0
            ),

            weatherTitleLabel.leadingAnchor.constraint(
                equalTo: weatherImageView.trailingAnchor,
                constant: 16.0
            ),
            weatherTitleLabel.centerYAnchor.constraint(
                equalTo: weatherImageView.centerYAnchor
            ),

            separationLine.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            separationLine.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -18.0
            ),
            separationLine.topAnchor.constraint(
                equalTo: weatherImageView.bottomAnchor,
                constant: 26.0
            ),
            separationLine.heightAnchor.constraint(
                equalToConstant: 0.5
            ),

            editImageButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: leading
            ),
            editImageButton.topAnchor.constraint(
                equalTo: separationLine.bottomAnchor,
                constant: 26.0
            ),
            editImageButton.heightAnchor.constraint(
                equalToConstant: 25.0
            ),
            editImageButton.widthAnchor.constraint(
                equalToConstant: 25.0
            ),

            editLabel.leadingAnchor.constraint(
                equalTo: editImageButton.trailingAnchor,
                constant: 16.0
            ),
            editLabel.centerYAnchor.constraint(
                equalTo: editImageButton.centerYAnchor
            ),
            editLabel.heightAnchor.constraint(
                equalToConstant: 19.0
            ),
            editLabel.widthAnchor.constraint(
                equalToConstant: 106.0
            ),

            geoImageButton.centerXAnchor.constraint(
                equalTo: editImageButton.centerXAnchor
            ),
            geoImageButton.topAnchor.constraint(
                equalTo: editImageButton.bottomAnchor,
                constant: 32.0
            ),
            geoImageButton.heightAnchor.constraint(
                equalToConstant: 25.0
            ),
            geoImageButton.widthAnchor.constraint(
                equalToConstant: 18.0
            ),

            geoLabel.leadingAnchor.constraint(
                equalTo: editLabel.leadingAnchor
            ),
            geoLabel.centerYAnchor.constraint(
                equalTo: geoImageButton.centerYAnchor
            ),
            geoLabel.heightAnchor.constraint(
                equalToConstant: 19.0
            ),

            dottedContentView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            dottedContentView.topAnchor.constraint(
                equalTo: geoImageButton.bottomAnchor,
                constant: 26.0
            ),
            dottedContentView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            dottedContentView.heightAnchor.constraint(
                equalToConstant: 1.0
            ),

            notificationImageView.centerXAnchor.constraint(
                equalTo: editImageButton.centerXAnchor
            ),
            notificationImageView.topAnchor.constraint(
                equalTo: dottedContentView.bottomAnchor,
                constant: 46.0
            ),
            notificationImageView.heightAnchor.constraint(
                equalToConstant: 15.0
            ),
            notificationImageView.widthAnchor.constraint(
                equalToConstant: 15.0
            ),

            notificationLabel.leadingAnchor.constraint(
                equalTo: editLabel.leadingAnchor
            ),
            notificationLabel.centerYAnchor.constraint(
                equalTo: notificationImageView.centerYAnchor
            ),
            notificationLabel.heightAnchor.constraint(
                equalToConstant: 19.0
            ),

            switchNotification.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -28.0
            ),
            switchNotification.centerYAnchor.constraint(
                equalTo: notificationLabel.centerYAnchor
            ),
            switchNotification.heightAnchor.constraint(
                equalToConstant: 16.0
            ),
            switchNotification.widthAnchor.constraint(
                equalToConstant: 36.0
            ),

            daytimeWeatherImageView.centerXAnchor.constraint(
                equalTo: editImageButton.centerXAnchor
            ),
            daytimeWeatherImageView.topAnchor.constraint(
                equalTo: notificationImageView.bottomAnchor,
                constant: 24.0
            ),
            daytimeWeatherImageView.heightAnchor.constraint(
                equalToConstant: 15.0
            ),
            daytimeWeatherImageView.widthAnchor.constraint(
                equalToConstant: 15.0
            ),

            daytimeWeatherLabel.leadingAnchor.constraint(
                equalTo: editLabel.leadingAnchor
            ),
            daytimeWeatherLabel.centerYAnchor.constraint(
                equalTo: daytimeWeatherImageView.centerYAnchor
            ),
            daytimeWeatherLabel.heightAnchor.constraint(
                equalToConstant: 19.0
            ),

            switchDaytimeWeather.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -28.0
            ),
            switchDaytimeWeather.centerYAnchor.constraint(
                equalTo: daytimeWeatherLabel.centerYAnchor
            ),
            switchDaytimeWeather.heightAnchor.constraint(
                equalToConstant: 16.0
            ),
            switchDaytimeWeather.widthAnchor.constraint(
                equalToConstant: 36.0
            ),

            temperatureImageView.centerXAnchor.constraint(
                equalTo: editImageButton.centerXAnchor
            ),
            temperatureImageView.topAnchor.constraint(
                equalTo: daytimeWeatherImageView.bottomAnchor,
                constant: 24.0
            ),
            temperatureImageView.heightAnchor.constraint(
                equalToConstant: 15.0
            ),
            temperatureImageView.widthAnchor.constraint(
                equalToConstant: 15.0
            ),

            temperatureTitleLabel.leadingAnchor.constraint(
                equalTo: editLabel.leadingAnchor
            ),
            temperatureTitleLabel.centerYAnchor.constraint(
                equalTo: temperatureImageView.centerYAnchor
            ),

            windSpeedImageView.centerXAnchor.constraint(
                equalTo: editImageButton.centerXAnchor
            ),
            windSpeedImageView.topAnchor.constraint(
                equalTo: temperatureImageView.bottomAnchor,
                constant: 24.0
            ),
            windSpeedImageView.heightAnchor.constraint(
                equalToConstant: 15.0
            ),
            windSpeedImageView.widthAnchor.constraint(
                equalToConstant: 15.0
            ),

            windSpeedTitleLabel.leadingAnchor.constraint(
                equalTo: editLabel.leadingAnchor
            ),
            windSpeedTitleLabel.centerYAnchor.constraint(
                equalTo: windSpeedImageView.centerYAnchor
            ),
            windSpeedTitleLabel.heightAnchor.constraint(
                equalToConstant: 19.0
            ),

            visibilityImageView.centerXAnchor.constraint(
                equalTo: editImageButton.centerXAnchor
            ),
            visibilityImageView.topAnchor.constraint(
                equalTo: windSpeedImageView.bottomAnchor,
                constant: 24.0
            ),
            visibilityImageView.heightAnchor.constraint(
                equalToConstant: 15.0
            ),
            visibilityImageView.widthAnchor.constraint(
                equalToConstant: 15.0
            ),

            visibilityTitleLabel.leadingAnchor.constraint(
                equalTo: editLabel.leadingAnchor
            ),
            visibilityTitleLabel.centerYAnchor.constraint(
                equalTo: visibilityImageView.centerYAnchor
            ),
            visibilityTitleLabel.heightAnchor.constraint(
                equalToConstant: 19.0
            ),

            timeFormatImageView.centerXAnchor.constraint(
                equalTo: editImageButton.centerXAnchor
            ),
            timeFormatImageView.topAnchor.constraint(
                equalTo: visibilityImageView.bottomAnchor,
                constant: 24.0
            ),
            timeFormatImageView.heightAnchor.constraint(
                equalToConstant: 15.0
            ),
            timeFormatImageView.widthAnchor.constraint(
                equalToConstant: 15.0
            ),

            timeFormatLabel.leadingAnchor.constraint(
                equalTo: editLabel.leadingAnchor
            ),
            timeFormatLabel.centerYAnchor.constraint(
                equalTo: timeFormatImageView.centerYAnchor
            ),
            timeFormatLabel.heightAnchor.constraint(
                equalToConstant: 19.0
            ),

            dateFormatImageView.centerXAnchor.constraint(
                equalTo: editImageButton.centerXAnchor
            ),
            dateFormatImageView.topAnchor.constraint(
                equalTo: timeFormatImageView.bottomAnchor,
                constant: 24.0
            ),
            dateFormatImageView.heightAnchor.constraint(
                equalToConstant: 15.0
            ),
            dateFormatImageView.widthAnchor.constraint(
                equalToConstant: 15.0
            ),

            dateFormatLabel.leadingAnchor.constraint(
                equalTo: editLabel.leadingAnchor
            ),
            dateFormatLabel.centerYAnchor.constraint(
                equalTo: dateFormatImageView.centerYAnchor
            ),
            dateFormatLabel.heightAnchor.constraint(
                equalToConstant: 19.0
            ),

            temperatureUnitLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -28.0
            ),
            temperatureUnitLabel.centerYAnchor.constraint(
                equalTo: temperatureTitleLabel.centerYAnchor
            ),

            windSpeedUnitLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -28.0
            ),
            windSpeedUnitLabel.centerYAnchor.constraint(
                equalTo: windSpeedTitleLabel.centerYAnchor
            ),

            visibilityUnitLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -28.0
            ),
            visibilityUnitLabel.centerYAnchor.constraint(
                equalTo: visibilityTitleLabel.centerYAnchor
            ),

            timeFormatUnitLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -28.0
            ),
            timeFormatUnitLabel.centerYAnchor.constraint(
                equalTo: timeFormatLabel.centerYAnchor
            ),

            dateFormatUnitLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -28.0
            ),
            dateFormatUnitLabel.centerYAnchor.constraint(
                equalTo: dateFormatLabel.centerYAnchor
            ),
        ].forEach { $0.isActive = true }
    }
    ///Добавить к mainContentView рекогнайзеры
    private func addRecognizeersToMainContentView() {
        mainContentView.addGestureRecognizer(swipeGesture)
    }
    ///Настройка изменяемых свойств
    private func setupChangebleProperties() {
        guard let model = changeblePropertiesModel else { return }
        let temp = Defaults.tempCalculationSystem
        var tempValue = ""
        switch temp {
        case .celsius:
            tempValue = model.celsiusTempText
        case .fahrenheit:
            tempValue = model.fahrenheitTempText
        }
        temperatureUnitLabel.attributedText = NSMutableAttributedString(
            string: tempValue, attributes: model.temperatureUnitLabelAttributes
        )
        let windSpeed = Defaults.windSpeedSystem
        var windValue = ""
        switch windSpeed {
        case .metersPerSecond:
            windValue = model.metersPerSecondWindText
        case .yardPerSecond:
            windValue = model.yardPerSecondWindText
        }
        windSpeedUnitLabel.attributedText = NSMutableAttributedString(
            string: windValue,
            attributes: model.windSpeedUnitLabelAttributes
        )

        visibilityUnitLabel.attributedText = NSMutableAttributedString(
            string: model.visibilityUnitLabelText,
            attributes: model.visibilityUnitLabelAttributes
        )
        let timeFormat = Defaults.timeFormat
        var timeValue = ""
        switch timeFormat {
        case ._12h:
            timeValue = model.timeFormatText12
        case ._24h:
            timeValue = model.timeFormatText24
        }
        timeFormatUnitLabel.attributedText = NSMutableAttributedString(
            string: timeValue,
            attributes: model.timeFormatUnitLabelAttributes
        )
    }
    //MARK: - @objc Methods
    ///Реакция на нажатие кнопки Edit - Открытие SettingsViewController
    @objc private func editDidTapped() {
        guard let navigationController = navigationController else {
            return
        }
        let model = SettingModel()
        let settingsViewController = SettingsViewController(
            model: model,
            menuDelegate: self,
            mainScreenDelegate: mainScreenDelegate
        )
        let navController = UINavigationController(rootViewController: settingsViewController)
        navController.modalPresentationStyle = .fullScreen
        navigationController.present(navController, animated: true)
    }
    ///Нажатие на geoButton
    @objc private func geoDidTapped() {
        mainScreenDelegate.changeLocation()
    }
    ///Скрытие меню жестом
    @objc private func tappedAction(_ sender: UITapGestureRecognizer) {
        mainScreenDelegate.hideMenu()
    }
    //MARK: - Init
    init(mainScreenDelegate: MainScreenDelegate, navigationController: UINavigationController?) {
        self.navigationController = navigationController
        self.mainScreenDelegate = mainScreenDelegate
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        drawDottedLine(onView: dottedContentView)
        addRecognizeersToMainContentView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Interface
    ///Установка локации при открытии меню
    lazy var setLocation: ((String) -> Void) = { [weak self] location in
        guard let self = self else { return }
        self.geoLabel.text = location
    }
}
//MARK: - Ext MenuDelegate
extension MenuView: MenuDelegate {
    func setSettings() {
        self.setupChangebleProperties()
    }
}

extension MenuView: Setupable {
    func setup(withModel model: ModelProtocol) {
        guard let model = model as? MainScreenModel.MenuUIModel else { return }
        changeblePropertiesModel = model.changebleModel
        contentView.backgroundColor = model.contentViewBackgroundColor
        separationLine.backgroundColor = model.separationLineBackgroundColor
        weatherImageView.image = model.weatherImage

        weatherTitleLabel.attributedText = NSMutableAttributedString(
            string: model.weatherTitleLabelText,
            attributes: model.weatherTitleLabelAttributes
        )
        weatherTitleLabel.font = model.weatherTitleLabelFont
        weatherTitleLabel.textColor = model.weatherTitleLabelTextColor

        editLabel.font = model.editLabelFont
        editLabel.textColor = model.editLabelTextColor
        editLabel.text = model.editLabelText

        let editImage = model.editImage
        let editColorImage = editImage.withTintColor(model.editImageColor, renderingMode: .alwaysOriginal)
        editImageButton.setImage(editColorImage, for: .normal)

        geoLabel.font = model.geoLabelFont
        geoLabel.textColor = model.geoLabelTextColor

        let geoImage = model.geoImage
        let geoColorImage = geoImage.withTintColor(model.geoImageColor, renderingMode: .alwaysOriginal)
        geoImageButton.setImage(geoColorImage, for: .normal)

        notificationLabel.font = model.notificationLabelFont
        notificationLabel.textColor = model.notificationLabelTextColor
        notificationLabel.attributedText = NSMutableAttributedString(
            string: model.notificationLabelText,
            attributes: model.notificationLabelAttributes
        )

        notificationImageView.image = Icons.bell.icon
        notificationImageView.setImageColor(color: Colors.white.color)

        daytimeWeatherLabel.font = model.daytimeWeatherLabelFont
        daytimeWeatherLabel.textColor = model.daytimeWeatherLabelTextColor
        daytimeWeatherLabel.attributedText = NSMutableAttributedString(
            string: model.daytimeWeatherLabelText,
            attributes: model.daytimeWeatherLabelTextAttributes
        )

        daytimeWeatherImageView.image = model.daytimeWeatherImage
        daytimeWeatherImageView.setImageColor(color: model.daytimeWeatherImageColor)

        temperatureTitleLabel.font = model.temperatureUnitLabelFont
        temperatureTitleLabel.textColor = model.temperatureTitleLabelTextColor
        temperatureTitleLabel.attributedText = NSMutableAttributedString(
            string: model.temperatureTitleLabelText,
            attributes: model.temperatureTitleLabelAttributes
        )

        temperatureImageView.image = model.temperatureImage
        temperatureImageView.setImageColor(color: model.temperatureImageColor)

        windSpeedTitleLabel.font = model.windSpeedTitleLabelFont
        windSpeedTitleLabel.textColor = model.windSpeedTitleLabelTextColor
        windSpeedTitleLabel.attributedText = NSMutableAttributedString(
            string: model.windSpeedTitleLabelText,
            attributes: model.windSpeedTitleLabelAttributes
        )

        windSpeedImageView.image = model.windSpeedImage
        windSpeedImageView.setImageColor(color: model.windSpeedImageColor)

        visibilityTitleLabel.font = model.visibilityTitleLabelFont
        visibilityTitleLabel.textColor = model.visibilityTitleLabelTextColor
        visibilityTitleLabel.attributedText = NSMutableAttributedString(
            string: model.visibilityTitleLabelText,
            attributes: model.visibilityTitleLabelAttributes
        )

        visibilityImageView.image = model.visibilityImage
        visibilityImageView.setImageColor(color: model.visibilityImageColor)

        timeFormatLabel.font = model.timeFormatLabelFont
        timeFormatLabel.textColor = model.timeFormatLabelTextColor
        timeFormatLabel.attributedText = NSMutableAttributedString(
            string: model.timeFormatLabelText,
            attributes: model.timeFormatLabelTextAttributes
        )

        timeFormatImageView.image = model.timeFormatImage
        timeFormatImageView.setImageColor(color: model.timeFormatImageColor)

        dateFormatLabel.font = model.dateFormatLabelFont
        dateFormatLabel.textColor = model.dateFormatLabelTextColor
        dateFormatLabel.attributedText = NSMutableAttributedString(
            string: model.dateFormatLabelText,
            attributes: model.dateFormatLabelAttributes
        )

        dateFormatImageView.image = model.dateFormatImage
        dateFormatImageView.setImageColor(color: model.dateFormatImageColor)

        temperatureUnitLabel.font = model.temperatureUnitLabelFont
        temperatureUnitLabel.textColor = model.temperatureUnitLabelTextColor

        windSpeedUnitLabel.font = model.windSpeedUnitLabelFont
        windSpeedUnitLabel.textColor = model.windSpeedUnitLabelTextColor

        visibilityUnitLabel.font = model.visibilityUnitLabelFont
        visibilityUnitLabel.textColor = model.visibilityUnitLabelTextColor

        timeFormatUnitLabel.font = model.timeFormatUnitLabelFont
        timeFormatUnitLabel.textColor = model.timeFormatUnitLabelTextColor

        dateFormatUnitLabel.font = model.dateFormatLabelFont
        dateFormatUnitLabel.textColor = model.dateFormatUnitLabelTextColor
        dateFormatUnitLabel.attributedText = NSMutableAttributedString(
            string: model.dateFormatUnitLabelText,
            attributes: model.dateFormatUnitLabelAttributes
        )
        setupChangebleProperties()
    }
}

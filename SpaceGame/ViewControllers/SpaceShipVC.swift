//
//  SpaceShipVC.swift
//  SpaceGame
//
//  Created by Emre on 14.05.2022.
//

import UIKit

class SpaceShipVC: BaseVC {
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.bounces = false
        return scroll
    }()
    
    private let pointsTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Dağıtılacak Puan"
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    private let pointsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "12"
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let pointsHolderView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.5
        view.layer.borderColor = Colors.textColor.cgColor
        return view
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.textColor
        return view
    }()

    private let shipNameTF: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1.5
        tf.layer.borderColor = Colors.textColor.cgColor
        tf.font = UIFont.systemFont(ofSize: 15)
        tf.placeholder = "Gemi adı"
        return tf
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    private lazy var durabilitySlider: SliderView = {
        let view = SliderView()
        view.configure(title: "Dayanıklık", maxValue: 15, minValue: 0, startValue: 1)
        view.delegate = self
        view.tag = SpaceShipVM.SliderType.durability.rawValue
        return view
    }()
    
    private lazy var speedSlider: SliderView = {
        let view = SliderView()
        view.configure(title: "Hız", maxValue: 15, minValue: 0, startValue: 1)
        view.delegate = self
        view.tag = SpaceShipVM.SliderType.speed.rawValue
        return view
    }()
    
    private lazy var capacitySlider: SliderView = {
        let view = SliderView()
        view.configure(title: "Kapasite", maxValue: 15, minValue: 0, startValue: 1)
        view.delegate = self
        view.tag = SpaceShipVM.SliderType.capacity.rawValue
        return view
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Devam Et", for: .normal)
        button.backgroundColor = Colors.textColor.withAlphaComponent(0.3)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        return button
    }()
    
    private lazy var viewModel: SpaceShipVM = {
        let vm = SpaceShipVM()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        pointsHolderView.layer.borderColor = Colors.textColor.cgColor
        shipNameTF.layer.borderColor = Colors.textColor.cgColor
    }
    
    private func bind() {
        viewModel.binder  = { [weak self] (change) in
            guard let self = self else { return }
            switch change {
            case .setDurability(let value):
                self.durabilitySlider.setValue(value: value)
            case .setSpeed(let value):
                self.speedSlider.setValue(value: value)
            case .setCapacity(let value):
                self.capacitySlider.setValue(value: value)
            case .updateAvailablePoints(let avaiablePoints):
                self.pointsLabel.text = avaiablePoints
            case .setShipName(let name):
                self.shipNameTF.text = name
            case .shipSaved(let ship):
                print("go next page with \(ship)")
            }
        }
    }
    
    override func setupSubviews() {
        view.addSubview(scrollView)
        [pointsTitleLabel, pointsHolderView, dividerView, shipNameTF, stackView, doneButton].forEach{scrollView.addSubview($0)}
        [pointsLabel].forEach{pointsHolderView.addSubview($0)}
        [durabilitySlider, speedSlider, capacitySlider].forEach{stackView.addArrangedSubview($0)}
    }
    
    override func setupLayouts() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pointsHolderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(statusBarHeight() + 20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(60)
        }
        
        pointsTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(pointsHolderView)
            make.leading.equalTo(view.snp.leading).offset(20)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(pointsHolderView.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(2)
        }
        
        shipNameTF.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(shipNameTF.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    override func setupActions() {
        doneButton.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
        view.addTarget(self, action: #selector(handleCloseKeyboard))
    }
    
    @objc private func handleCloseKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func handleDoneButton() {
        handleCloseKeyboard()
        let name = shipNameTF.text
        if name != "" {
            viewModel.saveShip(with: name!)
        }else {
            shipNameTF.layer.borderColor = UIColor.red.cgColor
        }
    }

}


extension SpaceShipVC: SliderViewProtocol {
    func sliderValueUpdated(tag: Int, value: Float) {
        guard let type = SpaceShipVM.SliderType(rawValue: tag) else { return }
        viewModel.handleValueChange(for:  type, value: value)
    }
    
    
}

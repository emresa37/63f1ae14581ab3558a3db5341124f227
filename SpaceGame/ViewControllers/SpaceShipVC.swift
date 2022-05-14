//
//  SpaceShipVC.swift
//  SpaceGame
//
//  Created by Emre on 14.05.2022.
//

import UIKit

class SpaceShipVC: BaseVC {
    
    enum Sliders: Int {
        case durability = 0
        case speed = 1
        case capacity = 2
    }
    
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
        view.tag = Sliders.durability.rawValue
        return view
    }()
    
    private lazy var speedSlider: SliderView = {
        let view = SliderView()
        view.configure(title: "Hız", maxValue: 15, minValue: 0, startValue: 1)
        view.delegate = self
        view.tag = Sliders.speed.rawValue
        return view
    }()
    
    private lazy var capacitySlider: SliderView = {
        let view = SliderView()
        view.configure(title: "Kapasite", maxValue: 15, minValue: 0, startValue: 1)
        view.delegate = self
        view.tag = Sliders.capacity.rawValue
        return view
    }()
    
    private let minPoint: Float = 1
    private let totalPoints: Float = 15
    private var durability: Float = 1 {
        didSet {
            durabilitySlider.setValue(value: durability)
        }
    }
    private var speed: Float = 1 {
        didSet {
            speedSlider.setValue(value: speed)
        }
    }
    private var capacity: Float = 1 {
        didSet {
            capacitySlider.setValue(value: capacity)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        pointsHolderView.layer.borderColor = Colors.textColor.cgColor
        shipNameTF.layer.borderColor = Colors.textColor.cgColor
    }
    
    override func setupSubviews() {
        [pointsTitleLabel, pointsHolderView, dividerView, shipNameTF, stackView].forEach{view.addSubview($0)}
        [pointsLabel].forEach{pointsHolderView.addSubview($0)}
        [durabilitySlider, speedSlider, capacitySlider].forEach{stackView.addArrangedSubview($0)}
    }
    
    override func setupLayouts() {
        pointsHolderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(statusBarHeight() + 20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(60)
        }
        
        pointsTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(pointsHolderView)
            make.leading.equalToSuperview().offset(20)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(pointsHolderView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(2)
        }
        
        shipNameTF.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(shipNameTF.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
    private func configureTotalPoints() {
        let availablePoints = Int(totalPoints - (speed + capacity + durability))
        pointsLabel.text = String(availablePoints)
    }

}


extension SpaceShipVC: SliderViewProtocol {
    func sliderValueUpdated(tag: Int, value: Float) {
        switch tag {
        case Sliders.durability.rawValue:
            if value < minPoint {
                durability = minPoint
                return
            }
            let availablePoints = Float(totalPoints - (speed + capacity))
            let calculated = value < availablePoints ? value : availablePoints
            durability = calculated
            configureTotalPoints()
        case Sliders.speed.rawValue:
            if value < minPoint {
                speed = minPoint
                return
            }
            let availablePoints = Float(totalPoints - (durability + capacity))
            let calculated = value < availablePoints ? value : availablePoints
            speed = calculated
            configureTotalPoints()
        case Sliders.capacity.rawValue:
            if value < minPoint {
                capacity = minPoint
                return
            }
            let availablePoints = Float(totalPoints - (durability + speed))
            let calculated = value < availablePoints ? value : availablePoints
            capacity = calculated
            configureTotalPoints()
        default:
            print("unExpected Value")
        }
    }
    
    
}

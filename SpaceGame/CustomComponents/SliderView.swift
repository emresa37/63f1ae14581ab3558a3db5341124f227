//
//  Slider.swift
//  SpaceGame
//
//  Created by Emre on 14.05.2022.
//

import UIKit

protocol SliderViewProtocol: AnyObject {
    func sliderValueUpdated(tag: Int, value: Float)
}

class SliderView: UIView {
    
    private let textLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    private let sliderView: UISlider = {
        let view = UISlider()
        view.minimumTrackTintColor = Colors.textColor
        view.maximumTrackTintColor = Colors.textColor.withAlphaComponent(0.5)
        view.thumbTintColor = Colors.textColor
        return view
    }()
    
    weak var delegate: SliderViewProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
        setupLayouts()
        setupActions()
    }
    
    private func setupSubviews() {
        [textLabel, sliderView].forEach{addSubview($0)}
        
    }
    
    private func setupLayouts() {
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        sliderView.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupActions() {
        sliderView.addTarget(self, action: #selector(sliderUpdated), for: .valueChanged)
    }
    
    @objc private func sliderUpdated() {
        let value = round(sliderView.value)
        sliderView.value = value
        delegate.sliderValueUpdated(tag: tag, value: value)
    }
    
    func configure(title: String, maxValue: Float, minValue: Float, startValue: Float) {
        self.textLabel.text = title
        self.sliderView.maximumValue = maxValue
        self.sliderView.minimumValue = minValue
        self.sliderView.value = startValue
    }
    
    func setValue(value: Float) {
        sliderView.value = value
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

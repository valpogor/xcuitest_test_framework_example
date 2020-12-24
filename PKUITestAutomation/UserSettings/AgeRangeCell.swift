import UIKit


class AgeRangeCell: UITableViewCell {
    
    let minSlader: UISlider =  {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 99
        return slider
    }()
    
    let maxSlader: UISlider =  {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 99
        return slider
    }()
    
    let minLabel: UILabel = {
        let label = AgeRangeLabel()
        label.text = "Min"
        return label
    }()
    
    let maxLabel: UILabel = {
        let label = AgeRangeLabel()
        label.text = "Max"
        return label
    }()
    
    class AgeRangeLabel: UILabel {
        
        override var intrinsicContentSize: CGSize {
            return .init(width: 80, height: 0)
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //vertical stack view of sliders
        let sliderStackView = UIStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [minLabel, minSlader]),
            UIStackView(arrangedSubviews: [maxLabel, maxSlader])
            ])
        sliderStackView.axis = .vertical
        sliderStackView.spacing = 16
        contentView.addSubview(sliderStackView)
        sliderStackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 25, left: 25, bottom: 26, right: 25))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
 
}

import UIKit

class ConfirmationVC: UIViewController {
    
    let imageView = UIImageView(image: UIImage(systemName: "checkmark.shield.fill"))
    let label: UILabel = {
        let label = UILabel()
        label.text = "Success!!!"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let thumbsUpImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "hand.thumbsup.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.layer.cornerRadius = 20
        return imageView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        configureUI()
    }
    let gradientLayer = CAGradientLayer()
    fileprivate func setupGradientLayer() {
        let topColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        // make sure to user cgColor
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
    private func configureUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageAndLabelStack = UIStackView(arrangedSubviews: [thumbsUpImage, label])
        imageAndLabelStack.translatesAutoresizingMaskIntoConstraints = false
        imageAndLabelStack.axis = .horizontal
        imageAndLabelStack.spacing = 10
        let stackView = UIStackView(arrangedSubviews: [imageView, imageAndLabelStack])
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 300, right: 40))
        
    }
    
    

    

}

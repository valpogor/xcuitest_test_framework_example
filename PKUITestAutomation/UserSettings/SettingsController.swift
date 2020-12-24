import UIKit

class CustomImagePickerController: UIImagePickerController {
    
    var imageButton: UIButton?
    
}

class SettingsController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var image1Button = createButton(selector: #selector(handleSelectPhoto))
    lazy var image2Button = createButton(selector: #selector(handleSelectPhoto))
    lazy var image3Button = createButton(selector: #selector(handleSelectPhoto))
    
    @objc func handleSelectPhoto(button: UIButton) {
        print("Select photo with button:", button)
        let imagePicker = CustomImagePickerController()
        imagePicker.delegate = self
        imagePicker.imageButton = button
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        // how do i set the image on my buttons when I select a photo?
        let imageButton = (picker as? CustomImagePickerController)?.imageButton
        imageButton?.setImage(selectedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true)
       
        }
    
    func createButton(selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true

        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .interactive
    
    }
    
    lazy var header: UIView = {
        let header = UIView()
        header.addSubview(image1Button)
        let padding: CGFloat = 16
        image1Button.anchor(top: header.topAnchor, leading: header.leadingAnchor, bottom: header.bottomAnchor, trailing: nil, padding: .init(top: padding, left: padding, bottom: padding, right: 0))
        image1Button.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.45).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [image2Button, image3Button])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        
        header.addSubview(stackView)
        stackView.anchor(top: header.topAnchor, leading: image1Button.trailingAnchor, bottom: header.bottomAnchor, trailing: header.trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding))
        return header
    }()
    
    class HeaderLabel: UILabel {
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.insetBy(dx: 16, dy: 0))
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return header
        }
        let headerLabel = HeaderLabel()
        switch section {
        case 1:
            headerLabel.text = "Name"
        case 2:
            headerLabel.text = "Profession"
        case 3:
            headerLabel.text = "Age"
        case 4:
            headerLabel.text = "Bio"
        default:
            headerLabel.text = "Age range"
        }
        headerLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return headerLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 300
        }
        return 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : 1
    }
    
    @objc fileprivate func handleMinAgeChanged(slider: UISlider) {
        evaluateMinMax()
    }
    
    @objc fileprivate func handleMaxAgeChanged(slider: UISlider) {
        evaluateMinMax()
    }
    
    
    fileprivate func evaluateMinMax() {
        guard let ageRangeCell = tableView.cellForRow(at: [5, 0]) as? AgeRangeCell else { return }
        let minValue = Int(ageRangeCell.minSlader.value)
        var maxValue = Int(ageRangeCell.maxSlader.value)
        maxValue = max(minValue, maxValue)
        ageRangeCell.maxSlader.value = Float(maxValue)
        ageRangeCell.minLabel.text = "Min \(minValue)"
        ageRangeCell.maxLabel.text = "Max \(maxValue)"
    
    }
    
    static let defaultMinSeekingAge = 18
    static let defauitMaxSeekingAge = 99
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 5 {
            let ageRangeCell = AgeRangeCell(style: .default, reuseIdentifier: nil)
            ageRangeCell.minSlader.addTarget(self, action: #selector(handleMinAgeChanged), for: .valueChanged)
            ageRangeCell.maxSlader.addTarget(self, action: #selector(handleMaxAgeChanged), for: .valueChanged)
            let minAge = SettingsController.defaultMinSeekingAge
            let maxAge = SettingsController.defauitMaxSeekingAge
            
            ageRangeCell.minLabel.text = "Min \(minAge)"
            ageRangeCell.maxLabel.text = "Max \(maxAge)"
            ageRangeCell.minSlader.value = Float(minAge)
            ageRangeCell.maxSlader.value = Float(maxAge)
            ageRangeCell.maxSlader.accessibilityIdentifier = "MAX_SLIDER"
            ageRangeCell.minSlader.accessibilityIdentifier = "MIN_SLIDER"
            ageRangeCell.isUserInteractionEnabled = true
            return ageRangeCell
        }


        let cell = SettingsCell(style: .default, reuseIdentifier: nil)
        
        switch indexPath.section {
        case 1:
            cell.textField.placeholder = "Enter Name"
            cell.textField.text = cell.textField.text
            cell.textField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
            cell.isUserInteractionEnabled = true
            
        case 2:
            cell.textField.placeholder = "Enter Profession"
            cell.textField.text = cell.textField.text
            cell.textField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
            cell.isUserInteractionEnabled = true
        case 3:
            cell.textField.placeholder = "Enter Age"
            cell.textField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
            cell.isUserInteractionEnabled = true
            
        default:
            cell.textField.placeholder = "Enter Bio"
            cell.textField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
            cell.isUserInteractionEnabled = true
        }
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    @objc fileprivate func handleTextChanged(textField: UITextField) {
       
        navigationItem.rightBarButtonItem?.isEnabled = true
           
    }
    
   
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave)),
            UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogOut))
        ]
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc fileprivate func handleSave(_ sender: UIBarButtonItem) {
        let confirmationVC = ConfirmationVC()
        let navigationController = UINavigationController(rootViewController: confirmationVC)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleCancel() {
        
        dismiss(animated: true)
    }
    
    @objc fileprivate func handleLogOut() {
        
        dismiss(animated: true)
        
    }
    
}

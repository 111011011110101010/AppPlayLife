
import UIKit
import Combine

class ViewController: UIViewController {
    
    private var viewModel = MainViewModel()
    
    private lazy var tableView = TableViewMain(viewModel: viewModel)
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Клеточное наполнение"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()

    private lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сотворить", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 90/255, green: 52/255, blue: 115/255, alpha: 1.0)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(create), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeGradient()
        setUpViews()
        setUpConstraints()
    }
    
    func makeGradient() {
        let topColor = UIColor(red: 0x2E/255.0,
                               green: 0x00/255.0,
                               blue: 0x4B/255.0,
                               alpha: 1.0).cgColor
        let bottomColor = UIColor.black.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 1.0]
        view.layer.addSublayer(gradientLayer)
    }
    
    private func setUpViews() {
        view.addSubview(label)
        view.addSubview(tableView)
        view.addSubview(updateButton)
        setUpConstraints()
    }

    @objc func create() {
        viewModel.create()
    }
}

extension ViewController {
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 40),
            
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            updateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            updateButton.heightAnchor.constraint(equalToConstant: 50),
            updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: updateButton.topAnchor, constant: -16),
        ])
    }
}



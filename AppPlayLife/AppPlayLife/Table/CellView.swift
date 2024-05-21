import Foundation
import UIKit
import Combine

class TableViewCellMain: UITableViewCell {
    private var anyCancallables = Set<AnyCancellable>()
    
    static let idTableViewCell = "idTableViewCell"
    
    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let background: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backGroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 13
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var labelsStackView: UIStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(background)
        background.addSubview(name)
        background.addSubview(descriptionLabel)
        background.addSubview(backGroundImageView)
        backGroundImageView.addSubview(image)
    }
    
    func configure(viewModel: CellViewModel) {
        name.text = viewModel.creation.name
        descriptionLabel.text = viewModel.creation.description
        switch viewModel.creation.type {
        case .dead:
            image.image = UIImage(named: "AvatarDead")
            backGroundImageView.image = UIImage(named: "backroundDead")
        case .alive:
            image.image = UIImage(named: "AvatarAlive")
            backGroundImageView.image = UIImage(named: "backgroundAlive")
        case .life:
            image.image = UIImage(named: "AvatarLife")
            backGroundImageView.image = UIImage(named: "backgroundLife")
        }
        if viewModel.creation.diedRecently {
            name.text = viewModel.creation.name + " и умерла недавно :("
        }
    }
    
    override func prepareForReuse() {
        background.backgroundColor = UIColor.white
    }
    
    func kill() {
        background.backgroundColor = UIColor.red
    }
}


extension TableViewCellMain {
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            backGroundImageView.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            backGroundImageView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10),
            backGroundImageView.widthAnchor.constraint(equalToConstant: 40),
            backGroundImageView.heightAnchor.constraint(equalToConstant: 40),
            
            image.centerYAnchor.constraint(equalTo: backGroundImageView.centerYAnchor),
            image.centerXAnchor.constraint(equalTo: backGroundImageView.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 26),
            image.heightAnchor.constraint(equalToConstant: 26),
            
            name.topAnchor.constraint(equalTo: background.topAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: backGroundImageView.trailingAnchor, constant: 15),
            name.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: backGroundImageView.trailingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -20),
        ])
    }
}


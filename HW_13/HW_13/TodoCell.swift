import UIKit

class TodoCell: UITableViewCell {
    static let identifier = "TodoCell"
    
    private let titleLabel = UILabel()
    private let checkMarkImgaeView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkMarkImgaeView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        checkMarkImgaeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            checkMarkImgaeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkMarkImgaeView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkMarkImgaeView.widthAnchor.constraint(equalToConstant: 24),
            checkMarkImgaeView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        checkMarkImgaeView.image = UIImage(systemName: "checkmark.circle")
        checkMarkImgaeView.tintColor = .systemGreen
    }
    
    func configure(with todo: TodoItem) {
        titleLabel.text = todo.title
        checkMarkImgaeView.isHidden = !todo.isComleted
    }
}

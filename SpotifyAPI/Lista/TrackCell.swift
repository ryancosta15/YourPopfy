import UIKit

class TrackCell: UITableViewCell{
    
    private let horizontalStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()
    
    private let imageMovieView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 18
        image.layer.masksToBounds = true
        image.backgroundColor = .blue
        return image
    }()
    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .equalCentering
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
        addViewsInHierarchy()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(track: Track){
        nameLabel.text = track.track.name
        artistLabel.text = track.track.artists[0].name
        imageMovieView.download(path: track.track.album.images[0].url)
    }
    
    private func setupContentView(){
        selectionStyle = .none
    }
    
    private func addViewsInHierarchy(){
        contentView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(imageMovieView)
        horizontalStack.addArrangedSubview(verticalStack)
        verticalStack.addArrangedSubview(UIView())
        verticalStack.addArrangedSubview(nameLabel)
        verticalStack.addArrangedSubview(artistLabel)
        verticalStack.addArrangedSubview(UIView())
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageMovieView.widthAnchor.constraint(equalToConstant: 90),
            imageMovieView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
    

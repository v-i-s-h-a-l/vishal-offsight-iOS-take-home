//
//  PostTableViewCell.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var likesButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tagsStackView: UIStackView!
    
    private var viewModel: PostTableCellPresentable?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        reset()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        reset()
    }

    fileprivate func reset() {
        postImageView.image = nil
        postTextLabel.text = nil
        likesButton.setTitle("0", for: .normal)
        likesButton.isSelected = false
        dateLabel.text = ""
        tagsStackView.removeAllArrangedSubviews()
    }
    
    func configure(with viewModel: PostTableCellPresentable) {
        self.viewModel = viewModel
        viewModel.viewDelegate = self

        // TODO: Image
        if let url = viewModel.imageURL {
            postImageView.load(url: url, placeholder: UIImage(systemName: "photo"))
        } else {
            postImageView.image = UIImage(systemName: "xmark.icloud.fill")
        }
        postTextLabel.text = viewModel.text
        likesButton.setTitle("\(viewModel.numberOfLikes)", for: .normal)
        dateLabel.text = viewModel.dateText
        viewModel.tags.forEach {
            let button = UIButton.init(type: .roundedRect)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 5
            button.setTitle($0, for: .normal)
            button.sizeToFit()
            self.tagsStackView.addArrangedSubview(button)
        }
    }

    // MARK: - User actions -
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        viewModel?.handleLikeButtonTap()
    }

    @IBAction func detailDisclosureButtonTapped(_ sender: Any) {
        viewModel?.handleDetailDisclosureTap()
    }
}

extension PostTableViewCell: PostTableCellViewDelegate {

    func updateLike(count: Int, isLiked: Bool) {
        likesButton.setTitle("\(count)", for: .normal)
        likesButton.isSelected = isLiked
    }
}

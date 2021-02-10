//
//  CompactPostTableViewCell.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 11/02/21.
//

import UIKit

class CompactPostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var numberOfLikesButton: UIButton!
    @IBOutlet weak var textPreviewLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    
    fileprivate func reset() {
        postImageView.image = nil
        numberOfLikesButton.setTitle("0", for: .normal)
        numberOfLikesButton.isSelected = false
        textPreviewLabel.text = ""
        publisherLabel.text = ""
    }
    
    func configure(with viewModel: CompactPostCellViewModel) {
        if let url = viewModel.imageURL {
            postImageView.load(url: url, placeholder: UIImage(systemName: "photo"))
        } else {
            postImageView.image = UIImage(systemName: "xmark.icloud.fill")
        }
        textPreviewLabel.text = viewModel.text
        publisherLabel.text = viewModel.publisherText
        numberOfLikesButton.setTitle("\(viewModel.numberOfLikes)", for: .normal)
        numberOfLikesButton.isSelected = viewModel.isLiked
    }

}

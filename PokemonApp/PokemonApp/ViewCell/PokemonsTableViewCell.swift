//
//  PokemonsTableViewCell.swift
//  PokemonApp
//
//  Created by Dominik Maric on 19.02.2023..
//

import UIKit

class PokemonsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

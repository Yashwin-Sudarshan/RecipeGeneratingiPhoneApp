//
//  IngredientCell.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 20/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This class contains labels that constitute an ingredient cell in the main pantry scene.
// The labels are referenced from here in order to be updated with ingredient entry details from the
// PantryUpdateIngredViewController.

import UIKit

class IngredientCell:UITableViewCell{
    
    
    @IBOutlet weak var ingredientTitle: UILabel?
    
    
    @IBOutlet weak var qtyTitle: UILabel!
    
    
    @IBOutlet weak var expTitle: UILabel!
    
}

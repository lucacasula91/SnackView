//
//  SVSpacerItem.swift
//  SnackView
//
//  Created by Luca Casula on 04/06/2021.
//  Copyright © 2021 LucaCasula. All rights reserved.
//

import UIKit

/** SVSpacerItem is an item that show */
public class SVSpacerItem: SVItem {

    /** Enumerator describing the size of activity indicator item */
    public enum SpacerSize {
        /** The height of the spacer is of 12 pixels */
        case little
        /** The height of the spacer is of 36 pixels */
        case medium
        /** The height of the spacer is of 60 pixels */
        case large
        /** Allow to set a custom height value for the spacer*/
        case custom(height: CGFloat)
    }

    // MARK: - Initialization Method
    /**
     Initialization method for SVLoaderItem view. You can customize this item with size of the activity indicator view and a custom text message.
     - parameter size: The size of activity indicator view
     - parameter text: A text that can appear on top of activity indicator view
     */
    public init(withSize size: SpacerSize) {
        super.init()
        self.setMinimumHeightActive(active: false)

        let height: CGFloat = self.getHeight(for: size)
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Private Methods
    private func getHeight(for spacerSize: SpacerSize) -> CGFloat {
        switch spacerSize {
        case .little: return 12
        case .medium: return 36
        case .large: return 60
        case .custom(let height): return height
        }
    }
}


//
//  ThumbnailRouter.swift
//  AndesUI-demoapp
//
//  Created by Alejo Echeguia on 01/07/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

protocol ThumbnailRouter: NSObject {
	func route(from: UIViewController)
}

class ThumbnailAppRouter: NSObject {
	var view: AndesShowcasePageViewController!
}

extension ThumbnailAppRouter: ThumbnailRouter {
	func route(from: UIViewController) {
		view = AndesShowcasePageViewController(controllers: [ThumbnailViewController(), ThumbnailObjCViewController()])
		view.title = "AndesThumbnail"
		from.navigationController?.pushViewController(view, animated: true)
	}

}

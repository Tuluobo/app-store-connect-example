//
//  BundleIDController.swift
//  ASCApi
//
//  Created by Hao Wang on 2019/6/22.
//

import Foundation
import Vapor
import ASCApi

class BundleIDController: RouteCollection {
    let bundleIDApi = BundleIDApi()
    
    func boot(router: Router) throws {
        router.get("/bundle_ids", use: index)
        router.delete("/bundle_ids", String.parameter, use: delete)
    }
    
    func index(_ req: Request) throws -> Future<View> {
        return try bundleIDApi.getBundleIDList(on: req).flatMap {
            return try req.view().render("bundle_ids", $0)
        }
    }
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try bundleIDApi.delete(id: try req.parameters.next(String.self), on: req).transform(to: .ok)
    }
}

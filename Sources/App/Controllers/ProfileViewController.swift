//
//  ProfileViewController.swift
//  ASCApi
//
//  Created by Hao Wang on 2019/6/28.
//

import Foundation
import Vapor
import ASCApi

final class ProfileViewController: RouteCollection {
    let api = ProfileApi()
    
    func boot(router: Router) throws {
        router.get("/profiles", use: index)
    }
    
    
    func index(_ req: Request) throws -> Future<View> {
        return try api.getProfileList(on: req).flatMap {
            return try req.view().render("profiles", $0)
        }
    }
}

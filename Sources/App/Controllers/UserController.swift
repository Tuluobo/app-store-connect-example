//
//  UserController.swift
//  ASCApi
//
//  Created by Hao Wang on 2019/6/22.
//

import Foundation
import Vapor
import ASCApi

final class UserController: RouteCollection {
    let userApi = UserApi()

    func boot(router: Router) throws {
        router.get("users", use: index)
        router.get("users", String.parameter, use: getUserInfo)
    }

    func index(_ req: Request) throws -> Future<View> {
        return try userApi.getUserList(on: req).flatMap({
            return try req.view().render("users", $0)
        })
    }

    func getUserInfo(_ req: Request) throws -> Future<UserInfoResponse> {
        let uid = try req.parameters.next(String.self)
        return try userApi.getUserInfo(id: uid, on: req)
    }
}

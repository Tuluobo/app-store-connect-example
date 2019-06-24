//
//  AuthController.swift
//  App
//
//  Created by Hao Wang on 2019/6/17.
//

import Vapor
import ASCApi

final class AppController: RouteCollection {

    let appApi = AppApi()
    
    func boot(router: Router) throws {
        router.get(use: index)
        router.get("apps", String.parameter, use: appInfo)
    }
        
    func index(_ req: Request) throws -> Future<View> {
        return try appApi.getAppList(on: req).flatMap {
            return try req.view().render("index", $0)
        }
    }
    
    func appInfo(_ req: Request) throws -> Future<View> {
        let id = try req.parameters.next(String.self)
        return try appApi.getAppInfo(id: id, on: req).flatMap({
            return try req.view().render("app_detail", $0)
        })
    }
}

//
//  DeviceController.swift
//  ASCApi
//
//  Created by Hao Wang on 2019/6/24.
//

import Foundation
import Vapor
import ASCApi

final class DeviceController: RouteCollection {
    let deviceApi = DeviceApi()

    func boot(router: Router) throws {
        router.get("devices", use: index)
    }

    func index(_ req: Request) throws -> Future<View> {
        return try deviceApi.getDeviceList(on: req).flatMap { deviceList in
            return try req.view().render("devices", deviceList)
        }
    }
}

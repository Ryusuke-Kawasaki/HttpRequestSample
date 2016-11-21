//
//  JSONParserDelegate.swift
//  HttpRequestSample
//
//  Created by 川崎 隆介 on 2015/12/16.
//  Copyright (c) 2015年 川崎 隆介. All rights reserved.
//

import Foundation

protocol JSONParserDelegate : class {
    func didParse(_ person:Person)
}



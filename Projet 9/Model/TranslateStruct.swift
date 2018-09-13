//
//  TranslateStruct.swift
//  Projet 9
//
//  Created by Amg on 10/09/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

struct DataTranslate: Decodable {
    var data: Translations
}

struct Translations: Decodable {
    var translations: [Translated]
}

struct Translated: Decodable {
    var translatedText: String
}

struct LanguagesData: Decodable {
    var data: Languages
}

struct Languages: Decodable {
    var languages: [Language]
}

struct Language: Decodable {
    var language: String
}

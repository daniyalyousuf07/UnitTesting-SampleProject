//
//  Functions.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-06-28.
//

import Foundation

func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}

func parse(jsonData: Data) -> [CatBreedModel]? {
    do {
        let decodedData = try JSONDecoder().decode([CatBreedModel].self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}

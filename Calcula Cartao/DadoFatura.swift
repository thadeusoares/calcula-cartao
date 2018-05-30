//
//  DadoFatura.swift
//  Calcula Cartao
//
//  Created by Thadeu Soares on 29/01/18.
//  Copyright © 2018 Thadeu SA. All rights reserved.
//

import UIKit

class DadoFatura: Codable {
    
    var descricao: String!
    var valor: Double!
    
    init(descricao: String, valor: Double){
        self.descricao = descricao
        self.valor = valor
    }
    
    
    
}

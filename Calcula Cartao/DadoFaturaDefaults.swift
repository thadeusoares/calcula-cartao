//
//  DadoFaturaDefault.swift
//  Calcula Cartao
//
//  Created by Thadeu Soares on 29/01/18.
//  Copyright © 2018 Thadeu SA. All rights reserved.
//

import UIKit

class DadoFaturaDefaults {
    
    let chave = "dadosFaturaCartao"
    var dados: [DadoFatura] = []
    
    
    func salvar(dadoFatura: DadoFatura) {
        
        //Recupera tarefas salvas
        dados = listar()
        
        //Salvar na colecao interna
        dados.append(dadoFatura)
        
        //Persiste coleção
        try? UserDefaults.standard.set(PropertyListEncoder().encode(dados), forKey: chave)
        
    }
    func alterar(id: Int, dadoFatura: DadoFatura) {
        
        //Recupera tarefas salvas
        dados = listar()
        
        //Salvar tarefa
        dados.remove(at: id)
        dados.insert(dadoFatura, at: id)//append(tarefa)
        try? UserDefaults.standard.set(PropertyListEncoder().encode(dados), forKey: chave)
        
    }
    func listar() -> Array<DadoFatura> {
        if let data = UserDefaults.standard.object(forKey:chave) as? Data {
            if let dados = try? PropertyListDecoder().decode(Array<DadoFatura>.self, from: data) {
                self.dados = dados
            }
        }
        return dados
    }
    func remover(indice: Int) {
        dados = listar()
        dados.remove(at: indice)
        try? UserDefaults.standard.set(PropertyListEncoder().encode(dados), forKey: chave)
    }
    func totalFatura() -> Double {
        return dados.reduce(0) { (resultado, dado)  in
            return (resultado+dado.valor)
        }
    }
}


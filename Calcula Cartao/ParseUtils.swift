//
//  ParseUtils.swift
//  Calcula Cartao
//
//  Created by Thadeu Soares on 30/01/18.
//  Copyright © 2018 Thadeu SA. All rights reserved.
//

import UIKit
//  [0-9]{1,3}
class ParseUtils {
    func parseValorCartao(textoEntrada: String) -> Double {
        //let textoEntrada = "O VALOR DE SUA FATURA RS 1.000,22 é igual"
        let padrao = "RS (\\d{1,3}(\\.\\d{3})*|(\\d+))(\\,\\d{2})?"
        //let regex = try! NSRegularExpression(pattern: padrao, options: NSRegularExpression.Options.caseInsensitive)
        //let matches = regex.matches(in: textoEntrada, options: [], range: NSRange(location: 0, length: textoEntrada.utf16.count))
        
        if let range = textoEntrada.range(of:padrao, options: .regularExpression) {
            let numeroFormatoReal = String(textoEntrada[range])
            return numeroLimpo(txtNumero: numeroFormatoReal)
        }
        return 0
    }
    
    func converteParaReal(numero: Double) -> String {
        var numeroFormatoReal = String(numero)
        numeroFormatoReal = numeroFormatoReal.replacingOccurrences(of: ".", with: ",")
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        if let numeroFormatado = formatter.string(from: numero as NSNumber) {
            return numeroFormatado
        }
        
        return "R$ ---------"
    }
    
    func numeroLimpo(txtNumero: String) -> Double {
        var numeroFormatoDolar = txtNumero.replacingOccurrences(of: ".", with: "")
        numeroFormatoDolar = numeroFormatoDolar.replacingOccurrences(of: ",", with: ".")
        numeroFormatoDolar = numeroFormatoDolar.replacingOccurrences(of: "RS ", with: "")
        if let resultado = Double(numeroFormatoDolar) {
            return resultado
        }
        return 0
    }
}

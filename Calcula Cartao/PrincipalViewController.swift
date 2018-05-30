//
//  PrincipalTableViewController
//  Calcula Cartao
//
//  Created by Thadeu Soares on 29/01/18.
//  Copyright © 2018 Thadeu SA. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var txtTextoSMS: UITextView!
    @IBOutlet weak var lblSomaTotal: UILabel!
    

    var faturas: [DadoFatura] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        //Dados de Teste
        let fatura = DadoFaturaDefaults()
        var dado = DadoFatura(descricao: "Item 1", valor: 1.1)
        fatura.salvar(dadoFatura: dado)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faturas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celulaFatura = tableView.dequeueReusableCell(withIdentifier: "celulaReuso") as! CelulaFatura //1.
        
        let parseUtils = ParseUtils() //2.
        
        let fatura = faturas[indexPath.row] //2.
        
        //cell.textLabel?.text = parseUtils.converteParaReal(numero: fatura.valor) //3.
        celulaFatura.lblDescricao.text = fatura.descricao
        celulaFatura.lblValor.text = parseUtils.converteParaReal(numero: fatura.valor)
        
        return celulaFatura
    }
    func atualizarListaValores() {
        let fatura = DadoFaturaDefaults()
        faturas = fatura.listar()
        let parseUtils = ParseUtils()
        lblSomaTotal.text = parseUtils.converteParaReal(numero: fatura.totalFatura())
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //self.faturas.remove(at: indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: .fade)
            
            let fatura = DadoFaturaDefaults()
            fatura.remover(indice: indexPath.row)
            
            atualizarListaValores()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        atualizarListaValores()
    }
    
    //Sempre que pressionar a tela ele invoca essa tela
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Terminou de editar
        view.endEditing(true)
    }
   
    
    @IBAction func colarTexto(_ sender: Any) {
        txtTextoSMS.text = UIPasteboard.general.string
    }
    
    @IBAction func incluirValorLista(_ sender: Any) {
        //.alert - tela de alerta simples
        //.actionSheet - abre a tela de baixo para cima
        
        let parseUtils = ParseUtils()
        let valorTexto = parseUtils.parseValorCartao(textoEntrada: txtTextoSMS.text)
        
       
        let alerta = UIAlertController(title: "Adicionar valor", message: "O valor está de " + parseUtils.converteParaReal(numero: valorTexto) + " está correto? ", preferredStyle: .alert )
        
        //handler é uma ação após apertar o botão
        /*
        let confirmar = UIAlertAction(title: "Confirmar", style: .default) { (alertAction) in
            let fatura = DadoFaturaDefaults()
            fatura.salvar(dadoFatura: DadoFatura(descricao: "Estamos testando", valor: valorTexto))
            self.txtTextoSMS.text = ""
            self.atualizarListaValores()
        }
        */
        let cancelar = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        let confirmar = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            //Section 1
            let fDescricao = alerta.textFields![0] as UITextField
            
            if fDescricao.text != "" {
                let fatura = DadoFaturaDefaults()
                fatura.salvar(dadoFatura: DadoFatura(descricao: fDescricao.text!, valor: valorTexto))
                self.txtTextoSMS.text = ""
                self.atualizarListaValores()
            } else {
                //TODO: Add error handling
            }
        })
        
        alerta.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Descrição..."
            textField.textAlignment = .left
        })
        
        alerta.addAction(confirmar)
        alerta.addAction(cancelar)
        
        present(alerta, animated: true, completion: nil)
    }
}


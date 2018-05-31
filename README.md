# calcula-cartao
Projeto pessoal feito em SWIFT para controle de gastos / An app that provides financial control developed using Swift 4.1

A ideia principal do app é facilitar este controle inserindo valores manualmente ou copiando o texto de uma SMS, encaminhada por uma instituição bancária, e colando no app.
Após colar o texto, um <b>parse</b> é realizado para identificar aonde se encontram os valores e, em seguida, é solicitado ao usuário que coloque uma descrição.

Atualmente o aplicativo realiza o <b>parse</b> somente de mensagens vindas do banco ITAU, que possui o valor número precedido de RS. 

Exemplo de SMS:
Compra aprovada no PERSON MC BLACK p/ FULANO DA SILVA - LOJA 4 SPO-BRAS.S valor RS 277,59 em 30/05/2018 as 10h58.

Em versões futuras pretendo realizar o parse da data e hora também e abrir as possibilidade de parse de valores.

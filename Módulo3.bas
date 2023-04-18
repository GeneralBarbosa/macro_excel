Attribute VB_Name = "M�dulo3"
Sub ImprimirESalvarteste()

    ' Copia a data e hora atual
    dataHora = Now()

    ' Copia o nome do comprador
    comprador = Range("C14").Value

    ' Copia o valor da venda
    valor = Range("J39").Value

    ' Solicita o tipo de venda
    tipodevenda = InputBox("Informe o tipo de venda (venda ou doa��o):", "Tipo de Venda")

    ' Cola os dados na pr�xima linha vazia da Plan3
    Sheets("Plan3").Range("A" & Rows.Count).End(xlUp).Offset(1, 0).Value = dataHora
    Sheets("Plan3").Range("B" & Rows.Count).End(xlUp).Offset(1, 0).Value = comprador
    Sheets("Plan3").Range("C" & Rows.Count).End(xlUp).Offset(1, 0).Value = valor
    Sheets("Plan3").Range("D" & Rows.Count).End(xlUp).Offset(1, 0).Value = tipodevenda

    ' Salva a folha 3 da Plan1 como PDF com o nome do comprador
    Sheets("Plan1").Select
    ActiveSheet.ExportAsFixedFormat Type:=xlTypePDF, Filename:= _
        ThisWorkbook.Path & "\" & comprador & ".pdf", Quality:=xlQualityStandard, _
        IncludeDocProperties:=True, IgnorePrintAreas:=False, OpenAfterPublish:= _
        False, From:=3, To:=3

    ' Cria o objeto e-mail
    Dim objOutlook As Object
    Set objOutlook = CreateObject("Outlook.Application")
    Dim objEmail As Object
    Set objEmail = objOutlook.CreateItem(olMailItem)

    ' Define o destinat�rio
    objEmail.To = "tiago@rota9.com.br"

    ' Define o assunto do e-mail
    objEmail.Subject = "Folha 3 da Plan1 da venda de " & comprador

    ' Anexa o PDF criado anteriormente
    objEmail.Attachments.Add ThisWorkbook.Path & "\" & comprador & ".pdf"

    ' Define o corpo do e-mail
    objEmail.Body = "Segue em anexo a folha 3 da Plan1 da venda de " & comprador

    ' Envia o e-mail
    objEmail.Send

    ' Apaga o arquivo PDF criado
    Kill ThisWorkbook.Path & "\" & comprador & ".pdf"


    ' Mensagem de confirma��o
    MsgBox "Venda registrada com sucesso!"
    
    ' Pergunta se deseja imprimir as vias
    Dim imprimir As Variant
    Dim folha As Integer
    Dim mensagem As String
    
    imprimir = MsgBox("Deseja imprimir as vias?", vbYesNo, "Impress�o")
    
    If imprimir = vbYes Then
        For folha = 1 To 4
            mensagem = "Deseja imprimir a folha " & folha & " da Plan1?"
            If MsgBox(mensagem, vbYesNo, "Impress�o") = vbYes Then
                Sheets("Plan1").Activate
                Sheets("Plan1").PrintOut From:=folha, To:=folha, Copies:=1, Preview:=False, ActivePrinter:="RICOH SP 3710SF PCL 6"
            End If
        Next folha
        MsgBox "Impress�o conclu�da!"
    End If
End Sub

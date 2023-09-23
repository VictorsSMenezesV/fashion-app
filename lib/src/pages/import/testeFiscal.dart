
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/src/database/entities/item_local.dart';
import 'package:my_app/src/database/entities/produto_local.dart';
import 'package:my_app/src/pages/import/adm/barsAdmLayout.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'dart:typed_data';

import 'package:printing/printing.dart';


class FiscalPage extends StatefulWidget {
  dynamic valorTotal;
  dynamic quantidadeTotal;
  dynamic formaDePagamento;
  List<ItemLocal> itensVendas;

   FiscalPage({super.key,required this.valorTotal,required this.quantidadeTotal,required this.formaDePagamento, required this.itensVendas});

  @override
  State<FiscalPage> createState() => _FiscalPageState();
}

class _FiscalPageState extends State<FiscalPage> {



@override
  void initState() {
    teste = widget.itensVendas;
  }

  String title = 'PRINT DEMO';
  List<ItemLocal> teste= [];
   
     DateTime data = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.black87,
          title: Text("EMISSÃO DO CUPOM"),centerTitle: true,actions: [IconButton(onPressed: (){
             Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const BarsAdmPage()));
        }, icon: Icon(Icons.home))],),
        body: PdfPreview(
            canChangePageFormat: false,
          build: (format) => _generatePdf(format,title),
        ),
      ),
    );
  }
Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
          
            children: [
              pw.Container(
               
               child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [pw.Text("       UNLOCK CLOTHES", style: pw.TextStyle(fontSize: 15))]) ),
                pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
             pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
      
                pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
             pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
             pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
    pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start,
      children:[ pw.Text("Rua Álvaro Alvim 1419 -São Bernardo do Campo - SP", style: pw.TextStyle(fontSize: 8)),
      ]),
         pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
             pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
             pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [  pw.Text("                 Telefone/WhatsApp: (11) 2669-5526                    ", style: pw.TextStyle(fontSize: 8)),]),
              
                    pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
             pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
             pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
  pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [   pw.Text(DateFormat("'                      Data da Compra:' dd/MM/yyyy").format(data), style: pw.TextStyle(fontSize: 8))])
            ,
pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [     pw.Text("-------------------------------------------", style: pw.TextStyle(fontSize: 20)),])
  
             
               ,pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [    pw.Text("Valor  Itens                          Descrição                                ....................................................................................................", style: pw.TextStyle(fontSize: 8)),
           ]),
             for(int x = 0; x<teste.length;x++)...[
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [ pw.Text("   ${teste[x].valor}      ${teste[x].quantidade}            ${teste[x].descricao}", style: pw.TextStyle(fontSize: 7)),
                   
                ])
                 
                       

                    // you can add widget here as well
                 ],
                 
             pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [     pw.Text("-------------------------------------------", style: pw.TextStyle(fontSize: 20)),])
  
  
              ,pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [  pw.Text("Aviso: a partir da data da compra você tera 15 dias para   ", style: pw.TextStyle(fontSize: 8)),]),
             pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [  pw.Text("enfetuar a troca junto desse comprovante", style: pw.TextStyle(fontSize: 8))]),
           
          
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [     pw.Text("-------------------------------------------", style: pw.TextStyle(fontSize: 20)),])
  
  
 ,pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [  pw.Text("Total da Compra:                                        ${widget.valorTotal}                    ....................................................................................................", style: pw.TextStyle(fontSize: 8)),
           ]),
             pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
             pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
             pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [   pw.Text("Total de Itens:                                                ${widget.quantidadeTotal}                    ....................................................................................................", style: pw.TextStyle(fontSize: 8))
           ]),
               pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
             pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
             pw.Text(".                                                                         .", style: pw.TextStyle(fontSize: 1)),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [   pw.Text("Forma de Pagamento:                                 ${widget.formaDePagamento}                      ....................................................................................................", style: pw.TextStyle(fontSize: 8))
           ]),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [     pw.Text("-------------------------------------------", style: pw.TextStyle(fontSize: 20)),])
  
  
          
            
              
              
                 
                
             ,pw.SizedBox(height: 20),
              
            ],
          );
        },
      ),
    );

    return pdf.save();
  }


 
}
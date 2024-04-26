import 'dart:io';
import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:open_document/my_files/init.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';

class PdfGeneratingService {
  Future<Uint8List> createHelloWorld() {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(child: pw.Text("hello world"));
    }));

    return pdf.save();
  }

  Future<Uint8List> createPdf(List<ProductSale> sales) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
          child: pw.Column(children: [
        pw.Center(
            child: pw.Text("Board Inventory Report",
                style: pw.TextStyle(fontSize: 25))),
        pw.SizedBox(height: 10),
        pw.Center(
            child: pw.Text("Product sales report per year",
                style: pw.TextStyle(fontSize: 20))),
        pw.SizedBox(height: 10),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Container(width: 100, child: pw.Text("Buyer name")),
          pw.Container(width: 80, child: pw.Text("Product name")),
          pw.Container(width: 80, child: pw.Text("Amount")),
          pw.Container(width: 70, child: pw.Text("Unpayed amount"))
        ]),
        pw.SizedBox(height: 5),
        pw.ListView.builder(
            direction: pw.Axis.vertical,
            itemBuilder: (context, index) {
              final sale = sales[index];
              return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                        height: 15, width: 100, child: pw.Text(sale.buyerName)),
                    pw.Container(
                        height: 15, width: 80, child: pw.Text(sale.productName)),
                    pw.Container(
                        height: 15,
                        width: 80,
                        child: pw.Text(sale.amount.toString())),
                    pw.Container(
                        height: 15,
                        width: 80,
                        child: pw.Text(sale.unPaidAmount.toString())),
                  ]);
            },
            itemCount: sales.length)
      ]));
    }));
    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getApplicationDocumentsDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    print("file path :$filePath");
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenDocument.openDocument(filePath: filePath);
  }
}

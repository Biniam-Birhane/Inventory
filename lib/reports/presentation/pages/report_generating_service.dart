import 'dart:io';
import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:open_document/my_files/init.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';

class PdfGeneratingService {
  Future<Uint8List> createHelloWorld() {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(child: pw.Text("hello world"));
    }));

    return pdf.save();
  }

  Future<Uint8List> createProductSalePdf(
      List<ProductSale> sales, String text, String date) async {
    final pdf = pw.Document();
    double totalUnpaid = sales.fold(
        0, (previousValue, sale) => previousValue + sale.unPaidAmount);
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw
          .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Center(
            child: pw.Text("Board Inventory Report",
                style: pw.TextStyle(fontSize: 25))),
        pw.SizedBox(height: 10),
        pw.Center(
            child: pw.Text("$text $date", style: pw.TextStyle(fontSize: 20))),
        pw.SizedBox(height: 10),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Container(width: 100, child: pw.Text("Buyer name")),
          pw.Container(width: 100, child: pw.Text("Product name")),
          pw.Container(width: 45, child: pw.Text("Amount")),
          pw.Container(width: 100, child: pw.Text("Unpayed amount")),
          pw.Container(width: 80, child: pw.Text("CreatedAt"))
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
                        height: 15,
                        width: 80,
                        child: pw.Text(sale.productName)),
                    pw.Container(
                        height: 15,
                        width: 80,
                        child: pw.Text(sale.amount.toString())),
                    pw.Container(
                        height: 15,
                        width: 80,
                        child: pw.Text(sale.unPaidAmount.toString())),
                    pw.Container(
                        height: 15,
                        width: 200,
                        child: pw.Text(sale.createdAt.toString())),
                  ]);
            },
            itemCount: sales.length),
        pw.SizedBox(height: 20),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(width: 100),
            pw.Container(width: 100),
            pw.Container(width: 45),
            pw.Container(
              width: 100,
              child: pw.Text(
                "Total Unpaid:",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Container(
              width: 80,
              child: pw.Text(
                totalUnpaid.toString(),
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),
          ],
        ),
      ]);
    }));
    return pdf.save();
  }

  Future<Uint8List> createProductPdf(
      List<ProductEntity> product, String text, String date) async {
    final pdf = pw.Document();
    double totalAmount =
        product.fold(0, (previousValue, sale) => previousValue + sale.amount);
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
          child: pw.Column(children: [
        pw.Center(
            child: pw.Text("Board Inventory Report",
                style: pw.TextStyle(fontSize: 25))),
        pw.SizedBox(height: 10),
        pw.Center(
            child: pw.Text("$text $date ", style: pw.TextStyle(fontSize: 20))),
        pw.SizedBox(height: 10),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Container(width: 80, child: pw.Text("Product name")),
          pw.Container(width: 80, child: pw.Text("Amount")),
          pw.Container(width: 70, child: pw.Text("Unit Price")),
          pw.Container(width: 70, child: pw.Text("CreatedAt"))
        ]),
        pw.SizedBox(height: 5),
        pw.ListView.builder(
            direction: pw.Axis.vertical,
            itemBuilder: (context, index) {
              final sale = product[index];
              return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                        height: 15,
                        width: 80,
                        child: pw.Text(sale.productName)),
                    pw.Container(
                        height: 15,
                        width: 80,
                        child: pw.Text(sale.amount.toString())),
                    pw.Container(
                        height: 15,
                        width: 80,
                        child: pw.Text(sale.unitPrice.toString())),
                    pw.Container(
                        height: 15,
                        width: 150,
                        child: pw.Text(sale.createdAt!.toLocal().toString())),
                  ]);
            },
            itemCount: product.length),
        pw.SizedBox(height: 20),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(width: 100),
            pw.Container(width: 100),
            pw.Container(width: 45),
            pw.Container(
              width: 100,
              child: pw.Text(
                "Total Amount:",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Container(
              width: 80,
              child: pw.Text(
                totalAmount.toString(),
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),
          ],
        ),
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

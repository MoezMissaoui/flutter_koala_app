// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:koala/src/components/nav_bar.dart';
import 'package:koala/src/config/theme_colors.dart';
import 'package:koala/src/helpers/auth_firebase.dart';
import 'package:koala/src/pdfs/ticket_generator.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              '🤗',
              style: TextStyle(
                fontSize: 70,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Hello you are logged in',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              AuthFirebase.currentUserName(),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: ThemeColors.secondColor,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: () async {
                  final pdfFile = await TicketGenerator().generateReceiptPdf(
                    receiptNumber: '12345',
                    date: '2024-07-03',
                    customerName: AuthFirebase.currentUserName(),
                    amount: 99.99,
                  );
                  print("Path - ${pdfFile.path}");
                  Printing.layoutPdf(
                    onLayout: (PdfPageFormat format) async =>
                        pdfFile.readAsBytes(),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border:
                        Border.all(width: 2, color: ThemeColors.secondColor),
                  ),
                  child: Icon(
                    Icons.print,
                    size: 40,
                    color: ThemeColors.secondColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: ThemeColors.mainColor,
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

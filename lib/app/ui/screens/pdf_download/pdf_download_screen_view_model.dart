import 'dart:io';
import 'package:dictionary/data/dto/eng_uzb.dart';
import 'package:dictionary/data/repositories/local_db_repository.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class PDFGenerator {
  static Future<File> generatePDF() async {
    final pdf = pw.Document();

    final List<EngUzb> engUzbWords =
        await LocalDBRepository.instance.getAllEngUzbWords(limit: 10);

    final List<List<String>> data = [
      ['Id', 'Eng', 'Pron', 'Uzb', 'IsFav', 'IsHistory'],
      ...engUzbWords.map(
        (word) => [
          // word.id.toString(),
          word.eng,
          word.pron,
          word.uzb,
          word.isFav.toString(),
          word.isHistory.toString()
        ],
      )
    ];

    final table = pw.Table.fromTextArray(
      headers: data[0],
      data: data.sublist(1),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      cellAlignment: pw.Alignment.centerLeft,
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Center(
              child: pw.Text(
                'English-Uzbek Dictionary',
                style: const pw.TextStyle(fontSize: 24),
              ),
            ),
            pw.SizedBox(height: 24),
            table,
          ];
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/enguzbdictionary.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}

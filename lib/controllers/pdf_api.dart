import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:projecto_licenciatura/views/Documentos/PDF_view.dart';
import 'dart:io';



class PDFApi {

  PDFViewerPage  pvp;
  ///Dio dio;

    static Future<File> loadAsset(String path) async {
//      final pdfController = PdfController(
//        document: PdfDocument.openAsset(path)
//      );
       //  final AssetBundle rootBundle = _initRootBundle();
         final data = await rootBundle.load(path);
          final bytes = data.buffer.asUint8List();
               return _storeFile(path, bytes);

           }





       static Future<File> loadFirebase(String url) async {
            try {
              final refPDF = FirebaseStorage.instance.ref().child(url);
              final bytes = await refPDF.getData();
                return _storeFile(url, bytes);
                } catch (e) {
                      return null;
                }
             }
    static Future<File> pickFile() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) return null;
      return File(result.paths.first);
    }

static Future<File> _storeFile(String url, List<int> bytes) async {
final filename = path.basename(url);
final dir = await getApplicationDocumentsDirectory();

final file = File('${dir.path}/$filename');
await file.writeAsBytes(bytes, flush: true);
return file;
}


}
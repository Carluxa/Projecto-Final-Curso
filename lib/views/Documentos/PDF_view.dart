
import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:projecto_licenciatura/controllers/pdf_api.dart';



typedef StringValue = String Function(String);
class PDFViewerPage extends StatefulWidget {
   final File file;


          PDFViewerPage({Key key, @required this.file,}) : super(key: key);

        @override
       _PDFViewerPageState createState() => _PDFViewerPageState();

}
class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFViewController controller;
  PDFApi api;
  int pages = 0;
  int indexPage = 0;



//download  pdf
  /*Dio dio;
  String process = "0";
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future _onReceiveProcess(int count, int total) {
    if (total != 1) {
      setState(() {
        process = (count / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }
  Future _onselectedNotification(String json) async {
    final obj = jsonDecode(json);
    if (obj['isSuccess']) {
      OpenFile.open('filePath');
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text('Error'),
                content: Text(obj['error']),
              )
      );
    }
  }
*/
  @override
  void initState() {
    // TODO: implement initState
    getPermission();
    super.initState();
  }
  void getPermission ()async
  {
    print("getPermission");
    await Permission.accessMediaLocation.request();

  }

/*
  Future<bool> reguestPermission() async {
    await Permission.notification.request();
    var permissionStatus = await Permission.notification.status;
    if (permissionStatus.isGranted) {

    }
  }

  Future<Directory> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPathProvider.downloadsDirectory;
    }
    return getApplicationDocumentsDirectory();
  }

  Future startDownload(String savePath, String urlPath) async {
    Map<String, dynamic> result = {
      "isSuccess": false,
      "filePath": null,
      "error": null,
    };
    try {
      var response = await dio.download(
          urlPath,
          savePath,
          onReceiveProgress: _onReceiveProcess
      );
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (e) {
      result['error'] = e.toString();
    } finally {
      showNotification(result);
    }
  }

  Future showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails(
        "channel  Id",
        "carla Manjate",
        "channelDescription",
        priority: Priority.high,
        importance: Importance.max,
    );
    final notificationDetails = NotificationDetails(android: android);
    final json = jsonDecode(downloadStatus as String);
    final isSuccess = downloadStatus['IsSuccess'];
    await FlutterLocalNotificationsPlugin().show(0, isSuccess?"Success":"error",
        isSuccess?"File Download Success":"File Download Faild", notificationDetails,
    payload: json);
  }



  Future download(String fileUrl, String fileName) async {
    final dir = await getDownloadDirectory();
    final permissionStatus = await Permission.notification.request();

    if (permissionStatus.isGranted) {
      final savePath = path.join(dir.path, fileName);
      await startDownload(savePath, fileUrl);
    }
    {
      print("Permission Denied");
    }
  }

*/
  @override
  Widget build(BuildContext context) {
    final name = path.basename(widget.file.path);
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        title: Text(name),
        actions: pages >= 2
            ? [
          Center(child: Text(text)),
          IconButton(
            icon: Icon(Icons.chevron_left, size: 32),
            onPressed: () {
              final page = indexPage == 0 ? pages : indexPage - 1;
              controller.setPage(page);
            },
          ),
     IconButton(
             icon: Icon(Icons.chevron_right, size: 32),
             onPressed: () {
               final page = indexPage == pages - 1 ? 0 : indexPage + 1;
               controller.setPage(page);
             },),
           IconButton(
             icon: Icon(Icons.file_download, size: 32, color: Colors.transparent),
             onPressed: () async {
             //  String path=
             //  await ExtStorage.getExternalStoragePublicDirectory(
             //           ExtStorage.DIRECTORY_DOWNLOADS );
            //   String fullPath = "$path/Document1.pdf";
               //download2(dio,imgUrl)
             },),

        ] : null,
      ),
      body: PDFView(
        filePath: widget.file.path,
        // autoSpacing: false,
// swipeHorizontal: true,
// pageSnap: false,
// pageFling: false,
        onRender: (pages) => setState(() => this.pages = pages),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage),
      ),);
  }





}
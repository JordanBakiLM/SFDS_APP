// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRScanPage extends StatefulWidget {
//   @override
//   _QRScanPageState createState() => _QRScanPageState();
// }

// class _QRScanPageState extends State<QRScanPage> {
//   final GlobalKey<QRViewController> _qrKey = GlobalKey<QRViewController>();
//   Barcode? result;
//   QRViewController? _controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scanner QR Code'),
//       ),
//       body: Stack(
//         children: [
//           QRView(
//             key: _qrKey,
//             onQRViewCreated: _onQRViewCreated,
//             overlay: QrScannerOverlayShape(
//               borderColor: Colors.red,
//               borderRadius: 10,
//               borderLength: 30,
//               borderWidth: 10,
//               cutOutSize: MediaQuery.of(context).size.width * 0.8,
//             ),
//           ),
//           if (result != null)
//             Positioned(
//               bottom: 20,
//               left: 20,
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 color: Colors.white,
//                 child: Text(
//                   'Result: ${result!.code}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       _controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
// }

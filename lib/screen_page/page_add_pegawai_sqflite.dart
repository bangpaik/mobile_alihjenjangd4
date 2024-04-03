// import 'package:flutter/material.dart';
// import 'package:mobile_alihjenjangd4/helpe/db_helper_sqflite.dart';
// import 'package:mobile_alihjenjangd4/models/model_pegawai_sqflite.dart';
// import 'package:mobile_alihjenjangd4/screen_page/screen_list_pegawai_sqflite.dart';
//
// class PageAddPegawaiSqflite extends StatefulWidget {
//   final ModelPegawai? data;
//
//   const PageAddPegawaiSqflite({super.key, this.data});
//
//   @override
//   State<PageAddPegawaiSqflite> createState() => _PageAddPegawaiSqfliteState();
// }
//
// class _PageAddPegawaiSqfliteState extends State<PageAddPegawaiSqflite> {
//
//   DatabaseHelperSqflite db = DatabaseHelperSqflite();
//
//   TextEditingController etFirstName = new TextEditingController();
//   TextEditingController etLastName = new TextEditingController();
//   TextEditingController etMobileNo = new TextEditingController();
//   TextEditingController etEmailId = new TextEditingController();
//
//   //proses do in background
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     etFirstName = TextEditingController(text: widget.data?.firstName);
//     etLastName = TextEditingController(text: widget.data?.lastName);
//     etMobileNo = TextEditingController(text: widget.data?.mobileNo);
//     etEmailId = TextEditingController(text: widget.data?.emailId);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.data?.id != null ? "Update Pegawai" : "Add Pegawai"),
//         backgroundColor: Colors.green,
//         titleTextStyle: TextStyle(
//           color: Colors.white, fontSize: 14
//         ),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//
//       body: Padding(
//         padding: EdgeInsets.all(30),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: etFirstName,
//                 decoration: InputDecoration(
//                   hintText: "Firstname"
//                 ),
//               ),
//               SizedBox(height: 8,),
//
//               TextFormField(
//                 controller: etLastName,
//                 decoration: InputDecoration(
//                     hintText: "Lastname"
//                 ),
//               ),
//               SizedBox(height: 8,),
//
//               TextFormField(
//                 controller: etMobileNo,
//                 decoration: InputDecoration(
//                     hintText: "Mobile No"
//                 ),
//               ),
//               SizedBox(height: 8,),
//
//               TextFormField(
//                 controller: etEmailId,
//                 decoration: InputDecoration(
//                     hintText: "Email"
//                 ),
//               ),
//               SizedBox(height: 20,),
//
//               MaterialButton(onPressed: (){
//                 if(widget.data?.id != null){
//                   db.updatePegawai(ModelPegawai.fromMap({
//                     "id": widget.data?.id,
//                     "firstname": etFirstName.text,
//                     "lastname": etLastName.text,
//                     "mobileno": etMobileNo.text,
//                     "emailid": etEmailId.text,
//
//                   })).then((value){
//                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)
//                         => PageListPegawaiSqflite()
//                       ), (route) => false);
//                   });
//                 }else{
//                   db.savePegawai(ModelPegawai(
//                     etFirstName.text, etLastName.text,
//                     etMobileNo.text, etEmailId.text
//                   )).then((value) {
//                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)
//                     => PageListPegawaiSqflite()
//                     ), (route) => false);
//                   });
//                 }
//
//               },
//                 minWidth: 200,
//                 color: Colors.green,
//                 height: 45,
//                 child: Text(widget.data?.id != null ? "EDIT" : "SIMPAN" ),
//
//               )
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

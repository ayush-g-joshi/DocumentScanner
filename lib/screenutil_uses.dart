import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsesOfScreenUtil extends StatefulWidget {
  const UsesOfScreenUtil({Key? key}) : super(key: key);

  @override
  State<UsesOfScreenUtil> createState() => _UsesOfScreenUtilState();
}

class _UsesOfScreenUtilState extends State<UsesOfScreenUtil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Ayush Joshi",style: TextStyle(fontSize: 20.spMin,color: Colors.amber),),
                Container(color: Colors.amber,height: 200.r,width: 200.r,),

              ]),
        ),
      ),

    );
  }
}

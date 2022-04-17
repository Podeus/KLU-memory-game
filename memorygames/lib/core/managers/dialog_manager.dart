import 'package:flutter/material.dart';
import 'package:flutter_base/core/locator.dart';
import 'package:flutter_base/core/services/model/dialog_models.dart';
import 'package:flutter_base/core/services/view/dialog_service.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    showDialog(
        barrierDismissible: request.customWidget!=null ? true : false,
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,

        // title: request.customWidget!=null ? Container():request.title == "unlem" ? Image.asset("asset/image/unlem1.png",height: 75,)
        //     : request.title == "warning" ? Image.asset("asset/image/warning1.png",height: 75,)
        //     : request.title =="check" ? Image.asset("asset/image/check.png",height: 75,)
        //     : request.title =="close" ? Image.asset("asset/image/close.png",height: 75,)
        //     : Image.asset("asset/image/info1.png",height: 75,),
        content: new Container(
          width: request.customWidget!=null ? MediaQuery.of(context).size.width * 0.95 :MediaQuery.of(context).size.width * 0.80,
          padding: EdgeInsets.all(10),
          // height: request.title == "unlem" ? MediaQuery.of(context).size.height * 0.90 : null,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          ),
          child: request.customWidget!=null ? ListView(
            shrinkWrap: true,
            children: <Widget>[
              request.customWidget
            ])
              :ListView(
            shrinkWrap: true,
            children: <Widget>[
              request.image != null ? Image.network(request.image) : SizedBox(height: 25,),
              SizedBox(height: 10,),
              Text(request.description !=null ? request.description : " ",
                style: TextStyle(color:Color(0xFF666666),fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Container(
                      // width: MediaQuery.of(context).size.width * 0.20,
                      constraints: BoxConstraints(
                          minWidth: 100),
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //     color: Colors.orange,
                        //     width: 1.0
                        // ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(60.0),
                        ),
                        color: Color(0xffe6e6e6),
                      ),
                      child: Column(
                        children: [
                          Text(request.buttonTitle,style: TextStyle(fontSize: 12),),
                        ],
                      ),
                    ),
                    onPressed: (){
                      _dialogService
                          .dialogComplete(DialogResponse(confirmed: true));
                    },
                  ),
                  isConfirmationDialog ?
                  FlatButton(
                    child: Container(
                      // width: MediaQuery.of(context).size.width * 0.20,
                      constraints: BoxConstraints(
                          minWidth: 100),
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //     color: Color,
                        //     width: 1.0
                        // ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(60.0),
                        ),
                        color: Color(0xffe6e6e6),
                      ),
                      child: Column(
                        children: [
                          Text(request.cancelTitle,style: TextStyle(fontSize: 12),),
                        ],
                      ),
                    ),
                    onPressed: (){
                      _dialogService
                          .dialogComplete(DialogResponse(confirmed: false));
                    },
                  ) : Container(),
                ],
              ),
              SizedBox(height: 25,),

              ],
        ),
              // title: Text(request.title !=null ? request.title : " "),
              // content: Text(request.description !=null ? request.description : " "),
              // actions: <Widget>[
              //   if (isConfirmationDialog)
              //     FlatButton(
              //       child: Text(request.cancelTitle),
              //       onPressed: () {
              //         _dialogService
              //             .dialogComplete(DialogResponse(confirmed: false));
              //       },
              //     ),
              //   FlatButton(
              //     child: Text(request.buttonTitle),
              //     onPressed: () {
              //       _dialogService
              //           .dialogComplete(DialogResponse(confirmed: true));
              //     },
              //   ),
              // ],
            )
        )
    );
  }
}

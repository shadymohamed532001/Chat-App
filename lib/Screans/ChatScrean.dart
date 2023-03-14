import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholor_chat/Widget/CustomAppBar.dart';
import 'package:scholor_chat/Widget/CustomMassageChat.dart';
import 'package:scholor_chat/Widget/CustomMassageFrinedChat.dart';
import 'package:scholor_chat/constans.dart';
import 'package:scholor_chat/models/MassageModeal.dart';

class ChatScrean extends StatelessWidget {
   ChatScrean({Key? key}) : super(key: key);

   CollectionReference Massages = FirebaseFirestore.instance.collection(KMassageCollection);
   TextEditingController massagecontroller = TextEditingController();
   final Controller = ScrollController();
   String? massage ;
   final FocusNode focusNode = FocusNode();
   @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
     return StreamBuilder<QuerySnapshot>(
      stream: Massages.orderBy(KDate,descending: true).snapshots(),
      builder: (context,snapshot)
      {
        if(snapshot.hasData)
          {
            List<MassageModel> MassageList = [];
            for(int i =0 ; i < snapshot.data!.docs.length ; i++)
              {
                MassageList.add(MassageModel.FromJson(snapshot.data!.docs[i]));
              }
            print(MassageList);
            return  Scaffold(
              appBar: const ChatAppBar(
                name: 'shady steha',
                Status: 'Online',

              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: Controller,
                      itemBuilder: (context, index) {
                        return MassageList[index].Id == email ? CustomMassageChat(
                          massage: MassageList[index],
                        ):CustomMassageFrinedChat(massage: MassageList[index]);
                      },
                      itemCount: MassageList.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: TextFormField(
                      focusNode: focusNode,
                      onFieldSubmitted: (value) {
                        massage = value;
                        Massages.add(
                            {
                              Kmassage: massage,
                              KDate: DateTime.now(),
                              'id': email,
                            }
                        );
                        Controller.animateTo(
                          Controller.position.minScrollExtent,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn
                        );
                        massagecontroller.clear();
                      },
                      controller: massagecontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'Sent a message',
                          suffixIcon: IconButton(
                            onPressed: () {},
                            // {
                            //   if (massage!=null)
                            //     {
                            //       Massages.add(
                            //           {
                            //             KMassage : massage
                            //           }
                            //       );
                            //       massagecontroller.clear();
                            //     }
                            //   focusNode.unfocus() ;
                            // },
                            icon: const Icon(
                              Icons.send_rounded,
                            ),
                          )
                      ),
                    ),
                  )
                ],
              ),
            );
          }else
            {
              return const Scaffold(
                body: Center(
                  child: Text(
                    'Loading ......',
                    style: TextStyle(
                      fontSize: 25,
                      color: KPrimaryColor
                    ),
                  ),
                ),
              );
            }

      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:herewego2/model/post_model.dart';
import 'package:herewego2/services/prefs_service.dart';
import 'package:herewego2/services/rtdb_service.dart';
class DetailPage extends StatefulWidget {
  static final String id = "detail_page";

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  _addPost () async {
  String content = contentController.text.toString();
  String firstName = firstNameController.text.toString();
  String lastName = lastNameController.text.toString();
  String date = dateController.text.toString();
  if (content.isEmpty || firstName.isEmpty|| lastName.isEmpty||date.isEmpty ) return;
  _apiAddPost (content, firstName, lastName, date);
  }

  _apiAddPost (String content, String firstName, String lastName, String date) async {
    var id = await Prefs.loadUserId();
    RTDBService.addPost(new Post(id, content, firstName, lastName, date)).then((response) => {
      _resAddPost(),
    });
  }
  _resAddPost () {
  Navigator.of(context).pop({'data' : 'done'});
  }
  var contentController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Add Post", style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TextField(
                controller: firstNameController,
                onTap: () {},
                decoration: InputDecoration(
                  hintText: "FirstName",
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: lastNameController,
                onTap: () {},
                decoration: InputDecoration(
                  hintText: "LastName",
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: contentController,
                onTap: () {},
                decoration: InputDecoration(
                  hintText: "Content",
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: dateController,
                onTap: () {},
                decoration: InputDecoration(
                  hintText: "Date",
                ),
              ),
              SizedBox(height: 20,),
              Container(
              height: 45,
                width: double.infinity,
                child: FlatButton(
                  onPressed: _addPost,
                  color: Colors.red,
                  child: Text("ADD", style: TextStyle(color: Colors.white),),
                ),

              ),
            ],
          ),
        ),
      )
    );
  }
}

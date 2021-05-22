import 'package:flutter/material.dart';
import 'package:herewego2/model/post_model.dart';
import 'package:herewego2/pages/detail_page.dart';
import 'package:herewego2/pages/signin_page.dart';
import 'package:herewego2/services/auth_service.dart';
import 'package:herewego2/services/prefs_service.dart';
import 'package:herewego2/services/rtdb_service.dart';
class HomePage extends StatefulWidget {
  static final String id = "home_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Post> items = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiGetPosts();
  }

  _openDetail () async {
  Map results = await Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return new DetailPage();
      }
    ));
    if (results != null && results.containsKey("data")) {
      print (results ['data']);
      _apiGetPosts();
    }
  }

  _apiGetPosts() async {
  var id = await Prefs.loadUserId();
  RTDBService.getPosts(id).then((posts) => {
    _resPosts (posts),
  });
  }
  _resPosts (List <Post> posts) {
    setState(() {
      items = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Home Page"),
        actions: [
          IconButton(
            onPressed: (){
              AuthService.signOutUser(context);
              Navigator.pushReplacementNamed(context, SignInPage.id);
            },
            icon: Icon(Icons.exit_to_app, color: Colors.white,),

          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          return itemOfList (items [i]);
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDetail,
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),

    );
  }
  Widget itemOfList (Post post) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(post.firstName, style: TextStyle(color: Colors.black, fontSize: 20)),
             SizedBox(width: 5,),
             Text(post.lastName, style: TextStyle(color: Colors.black, fontSize: 20)),
            ],
          ),
          SizedBox(height: 5,),
          Text(post.date, style: TextStyle(color: Colors.black, fontSize: 16),),
          SizedBox(height: 5,),
          Text(post.content, style: TextStyle(color: Colors.black, fontSize: 16),),
        ],
      ),
    );
  }
}

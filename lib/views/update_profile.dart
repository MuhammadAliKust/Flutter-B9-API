import 'package:flutter/material.dart';
import 'package:flutter_b9_api/providers/token.dart';
import 'package:flutter_b9_api/providers/user.dart';
import 'package:flutter_b9_api/services/auth.dart';
import 'package:provider/provider.dart';

class UpdateProfileView extends StatefulWidget {
  UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    nameController = TextEditingController(
        text: userProvider.getUser()!.user!.name.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          SizedBox(
            height: 20,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    isLoading = true;
                    setState(() {});
                    try {
                      await AuthServices()
                          .updateProfile(
                              token: tokenProvider.getToken().toString(),
                              name: nameController.text)
                          .then((val) async {
                        await AuthServices()
                            .getProfile(tokenProvider.getToken().toString())
                            .then((user) {
                          userProvider.setUser(user);
                          isLoading = false;
                          setState(() {});
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text("Profile updated successfully"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Okay"))
                                  ],
                                );
                              });
                        });
                      });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Update Profile"))
        ],
      ),
    );
  }
}

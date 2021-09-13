part of '../pages.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage(this.user);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File profilePictureFile;
  String profilePicturePath;

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    profilePicturePath = widget.user.profilePicture;
  }

  void showModalPhoto() {
    showModalBottomSheet(
        context: context,
        backgroundColor: mainColor,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                Text("Profile Picture",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        profilePictureFile = await galleryPhoto();
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt, color: Colors.white),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Gallery",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        profilePictureFile = await cameraPhoto();
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Camera", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              MaterialCommunityIcons.menu,
              color: Colors.black,
            ),
            onPressed: () => ZoomDrawer.of(context).open(),
          ),
          title: Text(
            "My Profile",
            style: themeFont,
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 40, defaultMargin, 40),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.only(bottom: 40),
                    child: Stack(
                      children: [
                        Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: (profilePictureFile != null)
                                        ? FileImage(profilePictureFile)
                                        : (profilePicturePath != "")
                                            ? NetworkImage(
                                                BaseUrl.getUserImages +
                                                    widget.user.profilePicture)
                                            : AssetImage("assets/avatar.png"),
                                    fit: BoxFit.cover))),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              if (profilePicturePath == "" &&
                                  profilePictureFile == null) {
                                showModalPhoto();
                                if (profilePictureFile != null) {
                                  profilePicturePath =
                                      path.basename(profilePictureFile.path);
                                }
                              } else {
                                profilePicturePath = "";
                                profilePictureFile = null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              // width: 30,
                              // height: 30,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: (profilePicturePath == "" &&
                                          profilePictureFile == null)
                                      ? mainColor
                                      : Colors.redAccent,
                                  shape: BoxShape.circle),
                              child: Icon(
                                (profilePicturePath == "" &&
                                        profilePictureFile == null)
                                    ? MaterialCommunityIcons.camera
                                    : MaterialCommunityIcons.delete,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Basic Detail",
                        style: themeFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Full Name:",
                      style: themeFont.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: TextEditingController(text: widget.user.name),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Contact Detail",
                        style: themeFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Email:",
                      style: themeFont.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller:
                          TextEditingController(text: widget.user.email),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Phone Number:",
                      style: themeFont.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: TextEditingController(text: widget.user.hp),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: mainColor),
                        onPressed: () {},
                        child: Text(
                          "Save",
                          style: themeFont.copyWith(
                              letterSpacing: 2,
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

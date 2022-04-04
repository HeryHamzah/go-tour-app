part of '../pages.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage(this.user);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController hpController = TextEditingController();

  File profilePictureFile;
  String profilePicturePath;
  bool isEdited = false;

  final _key = GlobalKey<FormState>();

  void validate(String picture, {String name, String hp}) {
    setState(() {
      isEdited = (picture != widget.user.profilePicture ||
              (name ?? nameController.text).trim() != widget.user.name ||
              (hp ?? hpController.text).trim() != widget.user.hp) &&
          (name ?? nameController.text).trim() != '' &&
          (hp ?? hpController.text).trim() != '';
    });
  }

  @override
  void initState() {
    super.initState();
    profilePicturePath = widget.user.profilePicture;
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    hpController = TextEditingController(text: widget.user.hp);
  }

  void checkForm() {
    final form = _key.currentState;
    if (form.validate()) {
      if (profilePictureFile != null) {
        imageToUpload = profilePictureFile;
      }
      context.bloc<UserBloc>().add(UpdateUser(widget.user.copyWith(
          email: emailController.text,
          name: nameController.text,
          hp: hpController.text,
          profilePicture: profilePicturePath)));

      context.bloc<NavdrawerBloc>().add(ChangePage(1));
    }
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
                Text("Foto Profil",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        await galleryPhoto().then((value) {
                          if (value != null) {
                            setState(() {
                              profilePictureFile = value;
                              profilePicturePath = path.basename(value.path);
                            });
                          }
                        });

                        validate(profilePicturePath);
                        Get.back();
                      },
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt, color: Colors.white),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Galeri", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        await cameraPhoto().then((value) {
                          if (value != null) {
                            setState(() {
                              profilePictureFile = value;
                              profilePicturePath = path.basename(value.path);
                            });
                          }
                        });

                        validate(profilePicturePath);
                        Get.back();
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
                          Text("Kamera", style: TextStyle(color: Colors.white))
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
            "Profil User",
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
                            onTap: () async {
                              if (profilePicturePath == "") {
                                showModalPhoto();
                              } else {
                                profilePicturePath = "";
                                profilePictureFile = null;
                                validate(profilePicturePath);
                              }
                            },
                            child: Container(
                              // width: 30,
                              // height: 30,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: (profilePicturePath == "")
                                      ? mainColor
                                      : Colors.redAccent,
                                  shape: BoxShape.circle),
                              child: Icon(
                                (profilePicturePath == "")
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
                      "Nama Lengkap:",
                      style: themeFont.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: nameController,
                      validator: (val) {
                        if (val.trim().isEmpty) {
                          return "Masukkan nama Anda";
                        }
                        return null;
                      },
                      onChanged: (name) {
                        validate(profilePicturePath, name: name);
                      },
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
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Hp:",
                      style: themeFont.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: hpController,
                      onChanged: (hp) {
                        validate(profilePicturePath, hp: hp);
                      },
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
                        onPressed: (isEdited)
                            ? () async {
                                checkForm();
                              }
                            : null,
                        child: Text(
                          "Simpan",
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

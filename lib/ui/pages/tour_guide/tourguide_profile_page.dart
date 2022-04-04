part of '../pages.dart';

class TourGuideProfilePage extends StatefulWidget {
  @override
  State<TourGuideProfilePage> createState() => _TourGuideProfilePageState();
}

class _TourGuideProfilePageState extends State<TourGuideProfilePage> {
  TourGuide tourGuide = Get.arguments;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  File imageFile;
  String profilePath;
  bool isValid = false;

  void validate(String picture, {String name, String email, String contact}) {
    setState(() {
      isValid = (picture != tourGuide.profilePicture ||
              (name ?? nameController.text).trim() != tourGuide.name ||
              (email ?? emailController.text).trim() != tourGuide.email ||
              (contact ?? contactController.text).trim() != tourGuide.hp) &&
          ((name ?? nameController.text).trim() != '' &&
              (email ?? emailController.text).trim() != '' &&
              (contact ?? contactController.text).trim() != '' &&
              EmailValidator.validate(email ?? emailController.text));
    });
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
                              imageFile = value;
                              profilePath = path.basename(value.path);
                            });
                          }
                        });
                        validate(profilePath);
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
                              imageFile = value;
                              profilePath = path.basename(value.path);
                            });
                          }
                        });
                        validate(profilePath);
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
  void initState() {
    super.initState();
    profilePath = tourGuide.profilePicture;
    emailController = TextEditingController(text: tourGuide.email);
    nameController = TextEditingController(text: tourGuide.name);
    contactController = TextEditingController(text: tourGuide.hp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Profil Tour Guide"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.symmetric(vertical: 40),
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: (imageFile != null)
                                  ? FileImage(imageFile)
                                  : (profilePath != "")
                                      ? NetworkImage(
                                          BaseUrl.getTourGuideImages +
                                              tourGuide.profilePicture)
                                      : AssetImage('assets/avatar.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            showModalPhoto();
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: mainColor),
                            child: Icon(
                              MaterialCommunityIcons.pencil,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text("Nama Lengkap", style: themeFont.copyWith(fontSize: 16)),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: nameController,
                onChanged: (name) => validate(profilePath, name: name),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Email", style: themeFont.copyWith(fontSize: 16)),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: emailController,
                onChanged: (email) => validate(profilePath, email: email),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Kontak", style: themeFont.copyWith(fontSize: 16)),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: contactController,
                onChanged: (contact) => validate(profilePath, contact: contact),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () => Get.toNamed('/tourGuideChangePassword',
                    arguments: tourGuide),
                contentPadding: EdgeInsets.all(0),
                title: Text("Ganti Password"),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: mainColor,
                    ),
                    onPressed: (isValid)
                        ? () {
                            context.bloc<TourGuideBloc>().add(
                                  UpdateTourGuide(
                                      tourGuide.copyWith(
                                          name: nameController.text,
                                          email: emailController.text,
                                          hp: contactController.text,
                                          profilePicture: profilePath),
                                      imageFile),
                                );
                            Get.back();
                          }
                        : null,
                    child: Text("Update Profil",
                        style: themeFont.copyWith(
                            letterSpacing: 2,
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

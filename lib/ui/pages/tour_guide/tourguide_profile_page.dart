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

  @override
  void initState() {
    super.initState();
    profilePath = tourGuide.profilePicture;
    emailController = TextEditingController(text: tourGuide.email);
    nameController = TextEditingController(text: tourGuide.name);
    contactController = TextEditingController(text: tourGuide.hp);
  }

  //FIXME: tourguide tidak diperbolehkan hapus foto profil

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
                          onTap: () async {
                            if (profilePath == "") {
                              imageFile = await galleryPhoto();
                              if (imageFile != null) {
                                profilePath = path.basename(imageFile.path);
                              }
                            } else {
                              imageFile = null;
                              profilePath = "";
                            }
                            validate(profilePath);
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (profilePath != "")
                                    ? Colors.pink
                                    : mainColor),
                            child: Icon(
                              (profilePath != "")
                                  ? MaterialCommunityIcons.delete
                                  : MaterialCommunityIcons.pencil,
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

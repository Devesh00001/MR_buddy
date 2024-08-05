import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mr_buddy/features/visit_detail/widgets/visit_text_field.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';
import '../../../widgets/comman_appbar.dart';
import '../../home/screen/home_screen.dart';
import '../provider/welcome_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(updateUserName);
  }

  updateUserName() {
    final provider = Provider.of<WelcomeProvider>(context, listen: false);
    provider.userName = _controller.text;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Consumer<WelcomeProvider>(builder: (context, provider, child) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Lottie.asset('assets/lottie/login.json'),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VisitTextField(
                        hintText: 'User Name',
                        validateFunction: provider.validateInput,
                        setFunction: provider.setUserName,
                      ),
                      const SizedBox(height: 10),
                      VisitTextField(
                          hintText: 'Password',
                          validateFunction: provider.validateInput,
                          visibility: true),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await provider.submitUserDetails();
                            if (provider.status == true) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const Home()));
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                              color: HexColor("00AE4D"),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                              child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text("OR"),
                const Divider(),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("4082EE"),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: Row(
                      children: [
                        Icon(MdiIcons.google),
                        const SizedBox(width: 30),
                        const Text("Connect with Google"),
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: Row(
                      children: [
                        Icon(MdiIcons.twitter),
                        const SizedBox(width: 30),
                        const Text("Connect with Twitter"),
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: Row(
                      children: [
                        Icon(MdiIcons.apple),
                        const SizedBox(width: 30),
                        const Text("Connect with icloud"),
                      ],
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }
}

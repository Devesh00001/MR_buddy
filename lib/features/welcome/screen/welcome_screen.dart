import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Consumer<WelcomeProvider>(builder: (context, provider, child) {
        return Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Your name"),
                          TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                                hintText: "Enter your name",
                                contentPadding: EdgeInsets.all(8),
                                isCollapsed: true,
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 20),
                          const Text("Your role"),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8)),
                            child: DropdownButton(
                              borderRadius: BorderRadius.circular(10),
                              underline: null,
                              hint: const Text(
                                  'Please choose a location'), // Not necessary for Option 1
                              value: provider.selectedRole,
                              onChanged: (newValue) {
                                provider.selectedRole = newValue.toString();
                              },
                              items: provider.roles.map((location) {
                                return DropdownMenuItem(
                                  child: Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          // provider.userName = _controller.text;
                          await provider.submitUserDetails();
                          if (provider.status == true) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const Home()));
                          }
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                              color: const Color(0xff2F52AC),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                              child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

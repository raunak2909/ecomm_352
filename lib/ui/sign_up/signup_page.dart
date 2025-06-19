import 'dart:convert';
import 'package:ecomm_352/ui/dashboard/home_page.dart';
import 'package:ecomm_352/ui/sign_up/bloc/user_bloc.dart';
import 'package:ecomm_352/ui/sign_up/bloc/user_event.dart';
import 'package:ecomm_352/ui/sign_up/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isLoading = false;
  String countryCode = "+1";
  late TabController _tabController;
  bool _isObscured = true;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    countryCode = "+91";
    _firstNameFocusNode.addListener(() {
      setState(() {});
    });
    _lastNameFocusNode.addListener(() {
      setState(() {});
    });
    _emailFocusNode.addListener(() {
      setState(() {});
    });
    _phoneFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _dateFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 60),
                        Text(
                          "Get Started Now",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Create an account or log in to explore\nabout our app",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: "Poppins",
                          ),
                        ),
                        SizedBox(height: 15),
                        _buildToggleButtons(),
                        SizedBox(height: 30),
                        _buildNameFields(),
                        SizedBox(height: 25),
                        _buildTextField(
                          "Email",
                          _emailController,
                          Icons.email,
                          false,
                          _emailFocusNode,
                        ),
                        SizedBox(height: 10),
                        _buildPhoneField("Phone Number", _phoneFocusNode),
                        SizedBox(height: 25),
                        _buildTextField(
                          "Set Password",
                          _passwordController,
                          Icons.lock,
                          true,
                          _passwordFocusNode,
                        ),
                        SizedBox(height: 25),
                        _buildTextField(
                          "Confirm Password",
                          _confirmPasswordController,
                          Icons.lock,
                          true,
                          _confirmPasswordFocusNode,
                        ),
                        SizedBox(height: 35),
                        _buildSignUpButton(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: Color(0xffff650e),
            borderRadius: BorderRadius.circular(25),
          ),
          labelColor: Colors.white,
          labelStyle: TextStyle(
            fontFamily: "Poppins",
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(text: "Sign Up"),
            Tab(text: "Log In"),
          ],
          onTap: (index) {
            if (index == 1) {
              _tabController.animateTo(1);
              Future.delayed(Duration(milliseconds: 300), () {
                Navigator.pop(context);
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildNameFields() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            "First Name",
            _firstNameController,
            Icons.person,
            false,
            _firstNameFocusNode,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildTextField(
            "Last Name",
            _lastNameController,
            Icons.person,
            false,
            _lastNameFocusNode,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController? controller,
    IconData icon,
    bool isPassword,
    FocusNode focusNode,
  ) {
    bool isFocused = focusNode.hasFocus;
    Color borderColor = isFocused ? const Color(0xffff650e) : Colors.black54;
    Color iconColor = isFocused ? const Color(0xffff650e) : Colors.black54;
    return Container(
      height: 45,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isPassword ? _isObscured : false,
        onChanged: (value) {},
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: iconColor,
            fontFamily: "Poppins",
            fontSize: 14,
          ),
          prefixIcon: Icon(icon, color: iconColor),
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                  child: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                    color: iconColor,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: borderColor, width: 1.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField(String label, FocusNode focusNode) {
    bool isFocused = focusNode.hasFocus;
    // Color borderColor = isFocused ? const Color(0xffff650e) : Colors.black54;
    Color iconColor = isFocused ? const Color(0xffff650e) : Colors.black54;
    return TextField(
      controller: _phoneController,
      focusNode: focusNode,
      keyboardType: TextInputType.phone,
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: iconColor,
          fontFamily: "Poppins",
          fontSize: 14,
        ),
        prefixIcon: Icon(Icons.phone, color: iconColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Color(0xffff650e), width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,

      child: BlocListener<UserBloc, UserState>(
        listener: (_, state) {
          if (state is UserLoadingState) {
            isLoading = true;
            setState(() {});
          }

          if (state is UserFailureState) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
            setState(() {});
          }

          if (state is UserSuccessState) {
            /// navigate back to login page
            /// navigate to home page
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("User Registered Successfully")),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          }
        },
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              /// request to sign up
              Map<String, dynamic> mParams = {
                "name":
                    "${_firstNameController.text} ${_lastNameController.text}",
                "email": _emailController.text,
                "mobile_number": _phoneController.text,
                "password": _passwordController.text,
              };
              context.read<UserBloc>().add(SignUpEvent(bodyParams: mParams));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffff650e),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: isLoading ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white,),
              SizedBox(width: 11,),
              Text(
                "Signing Up...",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  color: Colors.white,
                ),
              ),
            ],
          ) : Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

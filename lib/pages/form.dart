import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_crossplatform/pages/user_info_page.dart';
import '../model/user.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  FormUser newUser = FormUser();

  final List<String> _countries = ['Russia', 'Ukraine', 'Kazakhstan', 'Germany'];
  late String _selectedCountry = _countries[0];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full name*',
                hintText: 'How people call you?',
                prefixIcon: const Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _nameController.clear();
                  },
                  child: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0)
                ),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0)
                )
              ),
              validator: (val) => validateName(val!),
              onSaved: (value) { newUser.name = value!; },
            ),
            const SizedBox(height: 10,),
            TextFormField(
              focusNode: _phoneFocus,
              autofocus: false,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _phoneFocus, _passFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(
              labelText: 'Phone number*',
                hintText: 'Where can we reach you?',
                helperText: 'Phone format: +X-(XXX)-XXX-XX-XX',
                prefixIcon: const Icon(Icons.call),
                suffixIcon: GestureDetector(
                  onLongPress: () {
                    _phoneController.clear();
                  },
                  child: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0)
                ),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0)
                ),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: const [
                // FilteringTextInputFormatter.digitsOnly,
                // FilteringTextInputFormatter(RegExp(r'^[()\d -]{1, 15}$'), allow: true)
              ],
              onSaved: (value) { newUser.phone = value!; },
              // validator: (val) => _validatePhoneNumber(val!) ? null : 'Phone number must be entered as (XXX)XXX-XXXX',
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email address',
                hintText: 'Enter an email address',
                icon: Icon(Icons.mail)
              ),
              keyboardType: TextInputType.emailAddress,
              // validator: (val) => _validateEmail(val!),
            ),
            const SizedBox(height: 20,),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.map),
                labelText: 'Country?'
              ),
              items: _countries.map((country) {
                return DropdownMenuItem(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (String? country) {
                print(country);
                newUser.country = country!;
                setState(() {
                  _selectedCountry = country ?? '';
                });
              },
              value: _selectedCountry,
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: _storyController,
              decoration: const InputDecoration(
                labelText: 'Life Story',
                hintText: 'Write about yourself',
                helperText: 'Keep it short',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100)
              ],
              onSaved: (value) => newUser.story = value!,
            ),
            const SizedBox(height: 10,),
            TextFormField(
              focusNode: _passFocus,
              controller: _passController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Password*',
                hintText: 'Enter the password',
                suffixIcon: IconButton(
                  icon: Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
                icon: const Icon(Icons.security)
              ),
              validator: (val) => _validatePassword(val!),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _confirmPassController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Confirm the password',
                icon: Icon(Icons.border_color)
              ),
              validator: (val) => _validatePassword(val!),
            ),
            const SizedBox(height: 15,),
            OutlinedButton(
              onPressed: _submitForm,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'Submit form',
                style: TextStyle(
                  color: Colors.white
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _showDialog(name: _nameController.text);
      print('Form is valid');
      _formKey.currentState?.save();
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Story: ${_storyController.text}');
    } else {
      _showMessage('Error');
    }
  }

  String? validateName(String value) {
    final nameExp = RegExp(r'^[A-Za-z]+$');
    if (value.isEmpty) {
      return 'Name is required';
    } else if (!nameExp.hasMatch(value)) {
      return 'Please enter alpha chars';
    } else {
      return null;
    }
  }
  
  bool _validatePhoneNumber(String input) {
    final phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d-\d\d\d\d$');
    return phoneExp.hasMatch(input);
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_emailController.text.contains('@')) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  String? _validatePassword(String value) {
    if (_passController.text.length != 8) {
      return '8 char required for password';
    } else if (_confirmPassController.text != _passController.text) {
      return 'Password doesn\'t match';
    } else {
      return null;
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18
          ),
        )
      )
    );
  }

  void _showDialog({ required String name }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Registration successful',
            style: TextStyle(
              color: Colors.green
            ),
          ),
          content: Text(
            '$name is now a verified',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return UserInfoPage(userInfo: newUser,);
                  }
                ));
              },
              child: const Text(
                'Verified',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0
                ),
              )
            )
          ],
        );
      }
    );
  }
}

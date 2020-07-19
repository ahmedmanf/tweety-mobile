import 'package:flutter/material.dart';
import 'package:tweety_mobile/models/user.dart';
import 'package:tweety_mobile/utils/validators.dart';

class ChangeEmailScreen extends StatefulWidget {
  final User user;

  ChangeEmailScreen({Key key, @required this.user})
      : assert(user != null),
        super(key: key);

  @override
  _ChangeEmailScreenState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;

  String _email;
  String _password;

  bool _isPasswordHidden = true;
  void _toggleVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Change Email',
          style: Theme.of(context).appBarTheme.textTheme.caption,
        ),
        centerTitle: true,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          filled: true,
                          focusColor: Colors.white,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 3.0,
                              color: Colors.red,
                            ),
                          ),
                          prefixIcon: Icon(Icons.mail),
                          hintText: 'Email'),
                      autovalidate: true,
                      autocorrect: false,
                      validator: (val) {
                        return !Validators.isValidEmail(val)
                            ? 'Invalid email.'
                            : null;
                      },
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          filled: true,
                          focusColor: Theme.of(context).primaryColor,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 3.0,
                              color: Colors.red,
                            ),
                          ),
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                              icon: _isPasswordHidden
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                _toggleVisibility();
                              }),
                          hintText: 'Password'),
                      obscureText: _isPasswordHidden,
                      autovalidate: true,
                      autocorrect: false,
                      validator: (val) {
                        return val.trim().isEmpty
                            ? 'Password cannot be empty.'
                            : null;
                      },
                      onSaved: (value) => _password = value,
                    ),
                  ],
                ),
              ),
              InkWell(
                // onTap: isButtonEnabled(state) ? _onFormSubmitted : null,
                onTap: _onFormSubmitted,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.blue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Update',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 20.0),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFormSubmitted() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // BlocProvider.of<ProfileBloc>(context).add(
      //   UpdateProfileEmail(password: _password, email: _email),
      // );
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
}
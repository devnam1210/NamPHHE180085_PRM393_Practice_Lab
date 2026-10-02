import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 7 - Signup Form',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ),
      home: const SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  // Tạo GlobalKey để xác thực form
  final _formKey = GlobalKey<FormState>();

  // Dữ liệu Form
  String _fullName = '';
  String _username = '';
  String _phone = '';
  String _email = '';
  String _password = '';
  bool _termsAccepted = false;

  // Quản lý Trạng thái
  bool _isCheckingEmail = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  // Trạng thái sức mạnh mật khẩu
  String _passwordStrength = '';
  Color _passwordStrengthColor = Colors.transparent;
  double _passwordStrengthValue = 0.0;

  // Focus Nodes
  final _nameFocus = FocusNode();
  final _usernameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  @override
  void dispose() {
    _nameFocus.dispose();
    _usernameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  // Validation cơ bản
  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateEmail(String? value){
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if(!value.contains('@') || !value.contains('.')){
      return 'Email is invalid. Please enter a valid email address like user@example.com';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  void _checkPasswordStrength(String value) {
    setState(() {
      _password = value;
      if (value.isEmpty) {
        _passwordStrength = '';
        _passwordStrengthValue = 0.0;
        _passwordStrengthColor = Colors.transparent;
      } else if (value.length < 8) {
        _passwordStrength = 'Weak';
        _passwordStrengthValue = 0.3;
        _passwordStrengthColor = Colors.red;
      } else {
        bool hasDigits = RegExp(r'[0-9]').hasMatch(value);
        bool hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
        
        if (hasDigits && hasSpecial) {
          _passwordStrength = 'Strong';
          _passwordStrengthValue = 1.0;
          _passwordStrengthColor = Colors.green;
        } else if (hasDigits) {
          _passwordStrength = 'Medium';
          _passwordStrengthValue = 0.7;
          _passwordStrengthColor = Colors.orange;
        } else {
          _passwordStrength = 'Weak';
          _passwordStrengthValue = 0.4;
          _passwordStrengthColor = Colors.redAccent;
        }
      }
    });
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Must contain at least one digit';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != _password) return 'Passwords do not match';
    return null;
  }

  // xử lí submit
  Future<void> _submitForm() async {
    if(!_formKey.currentState!.validate()) {
      return; 
    }
     
    _formKey.currentState!.save();

    setState(() => _isCheckingEmail = true);

    await Future.delayed(const Duration(seconds: 2));
    final emailTaken = _email.toLowerCase().startsWith('taken');

    if(!mounted) return;
    setState(() => _isCheckingEmail = false);

    if(emailTaken){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This email is already taken!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Account successfully created for $_fullName ($_phone) — $_username!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Forms & Validation')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key:_formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              children:[
                const Text('Create an Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Full name
                TextFormField(
                  focusNode: _nameFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_usernameFocus),
                  decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person)),
                  validator: (value) => _validateRequired(value, 'Full Name'),
                  onSaved: (value) => _fullName = value!.trim(),
                ),
                const SizedBox(height: 16),

                // Username
                TextFormField(
                  focusNode: _usernameFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_phoneFocus),
                  decoration: const InputDecoration(labelText: 'Username', prefixIcon: Icon(Icons.account_circle)),
                  validator: (value) => _validateRequired(value, 'Username'),
                  onSaved: (value) => _username = value!,
                ),
                const SizedBox(height: 16),

                // Phone
                TextFormField(
                  focusNode: _phoneFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_emailFocus),
                  decoration: const InputDecoration(labelText: 'Phone', prefixIcon: Icon(Icons.phone)),
                  validator: _validatePhone,
                  onSaved: (value) => _phone = value!,
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  focusNode: _emailFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocus),
                  decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)),
                  validator: _validateEmail,
                  onSaved: (val) => _email = val!,
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  focusNode: _passwordFocus,
                  textInputAction: TextInputAction.next,
                  obscureText: _obscurePassword,
                  onChanged: _checkPasswordStrength,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_confirmFocus),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: _validatePassword,
                ),

                if (_passwordStrength.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: _passwordStrengthValue,
                            color: _passwordStrengthColor,
                            backgroundColor: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _passwordStrength,
                          style: TextStyle(color: _passwordStrengthColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),

                // Confirm Password
                TextFormField(
                  focusNode: _confirmFocus,
                  textInputAction: TextInputAction.done,
                  obscureText: _obscureConfirm,
                  onFieldSubmitted: (_) => _submitForm(),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                  ),
                  validator: _validateConfirmPassword,
                ),
                const SizedBox(height: 16),

                // Checkbox
                FormField<bool>(
                  initialValue: _termsAccepted,
                  validator: (value) {
                    if (value != true) return 'You must accept the Terms & Conditions';
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckboxListTile(
                          title: const Text('I agree to the Terms & Conditions'),
                          value: state.value,
                          onChanged: (val) {
                            setState(() => _termsAccepted = val ?? false);
                            state.didChange(val);
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.deepPurpleAccent,
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              state.errorText!,
                              style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                            ),
                          )
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isCheckingEmail ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: _isCheckingEmail
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                          )
                        : const Text('Create Account', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ]
            )
          )
        )
      )
    );
  }
}
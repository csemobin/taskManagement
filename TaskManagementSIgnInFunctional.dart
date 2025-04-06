import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() => runApp(const TaskManagement());

class TaskManagement extends StatefulWidget {
  const TaskManagement({super.key});
  @override
  State<TaskManagement> createState() => _TaskManagementState();
}

class _TaskManagementState extends State<TaskManagement> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
      ),
    );
  }

  // Elevated Button Theme Data
  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        fixedSize: const Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Input Decoration Theme Code Are here
  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      hintStyle: TextStyle(fontWeight: FontWeight.w300),
      fillColor: Colors.white,
      filled: true,
      border: _inputBorder(),
      enabledBorder: _inputBorder(),
      errorBorder: _inputBorder(),
      focusedBorder: _inputBorder(),
    );
  }

  //Out Line Input Border Stract are here
  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    );
  }

  // Out Line Input Border End here
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  // Splash Screen Controller
  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      (context),
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreen(
        child: Center(
          child: SvgPicture.network(
            'https://raw.githubusercontent.com/rupomsoft/Flutter-Batch/d3040c4b4c9319b6d1fd329967c4d4fab00bc47f/Flutter/Source%20Code/25%20Task%20manager%20project/ui_assets/logo.svg',
          ),
        ),
      ),
    );
  }
}

// Background Screen are here
class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.network(
          'https://raw.githubusercontent.com/rupomsoft/Flutter-Batch/d3040c4b4c9319b6d1fd329967c4d4fab00bc47f/Flutter/Source%20Code/25%20Task%20manager%20project/ui_assets/background.svg',
          fit: BoxFit.cover,
        ),
        SafeArea(child: child),
      ],
    );
  }
}

// Sing in Screen are here
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: BackgroundScreen(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 82),
                Text(
                  'Get Started With',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24),
                _buildSignInForm(),
                SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: _onTapForgotPassword,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      _buildSignInSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // On Tap Forgot Password
  void _onTapForgotPassword() {
    Navigator.push(
      (context),
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordEmailScreen(),
      ),
    );
  }

  // Build Sign in Form
  Widget _buildSignInForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(hintText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(hintText: 'Password'),
          obscureText: true,
        ),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }

  // On Tab Next Button
  void _onTapNextButton() {
    Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => MainBottomNavBarScreen()),
      (value) => false,
    );
  }

  // Build Sign up Section
  Widget _buildSignInSection() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: "Don't have any account? ",
        children: [
          TextSpan(
            text: 'Sign Up',
            style: TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignUp,
          ),
        ],
      ),
    );
  }

  void _onTapSignUp() {
    Navigator.push(
      (context),
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }
}

// Sing UP Screen are here
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // All kind of Controller are here
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  // Sign Up Form Flug are here
  bool _inProgress = false;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 32),
                  Text(
                    'Join With Us',
                    style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildSignUpForm(),
                  SizedBox(height: 24),
                  Center(child: _buildHaveAccountSection()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build Sign in Form
  Widget _buildSignUpForm() {
    return Column(
      children: [
        TextFormField(
          controller: _emailTEController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter a valid Email';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(hintText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _firstNameTEController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(hintText: 'First Name'),

          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter valid name';
            } else {
              return null;
            }
          },
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _lastNameTEController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(hintText: 'Last Name'),

          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Please Enter Last Name';
            } else {
              return null;
            }
          },
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _mobileTEController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter a valid phone number';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(hintText: 'Mobile'),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _passwordTEController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(hintText: 'Password'),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter a valid Password';
            }
            return null;
          },
        ),
        SizedBox(height: 24),
        Visibility(
          visible: !_inProgress,
          replacement: CircularProgressIndicator(),
          child: ElevatedButton(
            onPressed: _onTapNextButton,
            child: Icon(Icons.arrow_circle_right_outlined),
          ),
        ),
      ],
    );
  }

  // On Tab Next Button
  void _onTapNextButton() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Api Called
    _onTapSignUp();
  }

  // On Tap Sign Up Api Called function are here
  Future<void> _onTapSignUp() async {
    _inProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
      "photo": "",
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.registration,
      body: requestBody,
    );
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      clearTextFields();
      showSnackBarMessage(context, 'User Created Successfully');
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  // Build Sign up Section
  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: "Have account? ",
        children: [
          TextSpan(
            text: 'Sign In',
            style: TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  void clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapSignIn() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}

// Forgot Password email Screen
class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});
  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 32),
                Text(
                  'Your Email Address',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A 6 digit Verification otp will be sent to your email address',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 24),
                _buildVarifyEmailForm(),
                SizedBox(height: 24),
                Center(child: _buildHaveAccountSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build Sign in Form
  Widget _buildVarifyEmailForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(hintText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }

  // On Tab Next Button
  void _onTapNextButton() {
    Navigator.push(
      (context),
      MaterialPageRoute(builder: (context) => const ForgotPasswordOtpScreen()),
    );
  }

  // Build Sign up Section
  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: "Have account? ",
        children: [
          TextSpan(
            text: 'Sign In',
            style: TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  void _onTapSignIn() {
    Navigator.pop(context);
  }
}

//Forgot password OTP Screen here
// Forgot Password email Screen
class ForgotPasswordOtpScreen extends StatefulWidget {
  const ForgotPasswordOtpScreen({super.key});
  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Text(
                  'PIN Verification',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A 6 digit Verification otp has been sent to your email address',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 24),
                _buildVarifyEmailForm(),
                SizedBox(height: 24),
                Center(child: _buildHaveAccountSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build Sign in Form
  Widget _buildVarifyEmailForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(hintText: 'PIN'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }

  // On Tab Next Button
  void _onTapNextButton() {
    Navigator.push(
      (context),
      MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
    );
  }

  // Build Sign up Section
  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: "Have account? ",
        children: [
          TextSpan(
            text: 'Sign In',
            style: TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
      (context),

      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (_) => false,
    );
  }
}

// Reset Password Screen
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 32),
                Text(
                  'Set Password',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),

                Text(
                  'Minimun number of password sould be 8 letters',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 24),
                _buildResetPasswordForm(),
                SizedBox(height: 24),
                Center(child: _buildHaveAccountSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build Sign in Form
  Widget _buildResetPasswordForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(hintText: 'Set Password'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(hintText: 'Conform Password'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }

  // On Tab Next Button
  void _onTapNextButton() {
    Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (_) => false,
    );
  }

  // Build Sign up Section
  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: "Have account? ",
        children: [
          TextSpan(
            text: 'Sign In',
            style: TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (_) => false,
    );
  }
}

// Colors Class are here
class AppColors {
  static const Color themeColor = Colors.green;
}

// Main Bottom Nab bar Screen
// Main Bottom Nab bar Screen
// Main Bottom Nab bar Screen
// Main Bottom Nab bar Screen

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});
  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  int _selectedIndex = 0;
  List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
          NavigationDestination(
            icon: Icon(Icons.check_box),
            label: 'Completed',
          ),
          NavigationDestination(icon: Icon(Icons.close), label: 'Cancelled'),
          NavigationDestination(
            icon: Icon(Icons.access_time_outlined),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}

// App Bar Extraction are here
class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.isProfileScreenOpen = false});

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isProfileScreenOpen) {
          return;
        }
        Navigator.push(
          (context),
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      },
      child: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/86688223?v=4',
              ),
              radius: 20,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Maruf Mobin',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'mobinh264@gmail.com',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  (context),
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                  (value) => false,
                );
              },
              icon: Icon(Icons.logout, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// New Task Screen
class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});
  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSummarySection(),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return TaskCard(buttonTitleName: 'New');
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 8);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAppFAB,
        child: Icon(Icons.add),
      ),
    );
  }

  // Build Summary Section are here
  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TaskSummaryCard(title: 'New', count: 9),
            TaskSummaryCard(title: 'Completed', count: 9),
            TaskSummaryCard(title: 'Cancelled', count: 9),
            TaskSummaryCard(title: 'Progress', count: 9),
          ],
        ),
      ),
    );
  }

  void _onTapAppFAB() {
    Navigator.push(
      (context),
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    );
  }
}

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.buttonTitleName});
  final String buttonTitleName;
  @override
  State<TaskCard> createState() => _TaskCardState();
}

// Task Card Class are here
class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Text of the Title',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text('Description of Title '),
            Text('Date 12/12/2002'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusChip(),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: _onTapEditButtonHandler,
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: _onTapDeleteButtonHandler,
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Button handler are here
  void _onTapEditButtonHandler() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                ['New', 'Completed', 'Canclled', 'Progress'].map((e) {
                  return ListTile(onTap: () {}, title: Text(e));
                }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(onPressed: () {}, child: Text('Okey')),
          ],
        );
      },
    );
  }

  void _onTapDeleteButtonHandler() {}

  // Build Task Status Chip
  Widget _buildTaskStatusChip() {
    return Chip(
      label: Text(
        widget.buttonTitleName,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      side: BorderSide(color: AppColors.themeColor),
    );
  }
}

// task Summary Card
class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({super.key, required this.title, required this.count});
  final String title;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: SizedBox(
        width: 110,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                '${count.toString()}',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              //               FittedBox(
              //                 child: Text(title, style: TextStyle(color: Colors.grey)),
              //               ),
              Text(title, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

// Completed Task Screen
class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) {
        return TaskCard(buttonTitleName: 'Complete');
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
    );
  }
}

// Canceled Task Screen
class CanceledTaskScreen extends StatelessWidget {
  const CanceledTaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) {
        return TaskCard(buttonTitleName: 'Cancelled');
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
    );
  }
}

// Progress Task Screen
class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) {
        return TaskCard(buttonTitleName: 'Progress');
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
    );
  }
}

// Profile Update Screen are here
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(isProfileScreenOpen: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 48),
              Text(
                'Update Profile',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 32),
              _buildPhotoPicker(),
              SizedBox(height: 16),
              TextFormField(decoration: InputDecoration(hintText: 'Email')),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(hintText: 'First Name'),
              ),

              SizedBox(height: 8),
              TextFormField(decoration: InputDecoration(hintText: 'Last Name')),

              SizedBox(height: 8),
              TextFormField(decoration: InputDecoration(hintText: 'Phone')),

              SizedBox(height: 8),
              TextFormField(decoration: InputDecoration(hintText: 'Password')),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.arrow_circle_down_rounded),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Build Photo Picker are here
  Container _buildPhotoPicker() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              'Photos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('Selected Photo'),
        ],
      ),
    );
  }
}

// Add New Task Screen Are here
class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});
  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 42),
              Text(
                'Add New Task',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              TextFormField(decoration: InputDecoration(hintText: 'Title')),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(hintText: 'Description'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.arrow_circle_right_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Model Folder Work are here
class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  dynamic responseData;
  String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = 'Something Went Wrong',
  });
}

// Network Caller class are here
class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint('$uri');
      final Response response = await get(uri);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint('$uri');
      final Response response = await post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void printResponse(String url, Response response) {
    debugPrint(
      'URL : ${url}\nStatusCode : ${response.statusCode}\nData : ${response.body}',
    );
  }
}

class Urls {
  static const String _baseUrl = 'http://152.42.163.176:2006/api/v1';
  //http://152.42.163.176:2006/api/v1  https://task.teamrabbil.com/api/v1
  //   static const String registration = 'http://152.42.163.176:2006/api/v1';
  static const String registration = '$_baseUrl/registration';
}

void showSnackBarMessage(
  BuildContext context,
  String message, [
  bool isError = false,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : null,
    ),
  );
}

class CenterCircularProgressIndicator extends StatelessWidget {
  const CenterCircularProgressIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

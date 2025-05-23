import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/gestures.dart';

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
    );
  }

  // Build Sign in Form
  Widget _buildSignUpForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(hintText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 8),
        TextFormField(decoration: InputDecoration(hintText: 'First Name')),
        SizedBox(height: 8),
        TextFormField(decoration: InputDecoration(hintText: 'Last Name')),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(hintText: 'Mobile'),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 8),
        TextFormField(decoration: InputDecoration(hintText: 'Password')),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }

  // On Tab Next Button
  void _onTapNextButton() {}

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
  const TMAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      body: Column(children: [_buildSummarySection()]),
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
    return Center(child: Text('Completed'));
  }
}

// Canceled Task Screen
class CanceledTaskScreen extends StatelessWidget {
  const CanceledTaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Canceled task Screen'));
  }
}

// Progress Task Screen
class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Progress Task Screen'));
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

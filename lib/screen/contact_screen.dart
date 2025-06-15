import 'package:flutter/material.dart';

import '../main.dart'; // For color constants

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({super.key});

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false; // To disable button during submission

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && !_isSubmitting) {
      setState(() {
        _isSubmitting = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Submitting...'), duration: Duration(seconds: 3)),
      );

      try {
        // Data to insert
        final Map<String, dynamic> formData = {
          'first_name': _firstNameController.text,
          'last_name': _lastNameController.text,
          'email': _emailController.text,
          'subject': _subjectController.text,
          'message': _messageController.text,
          // 'ip_address': null, // You could try to get this if needed, but it's trickier from client-side
          // 'user_agent': null, // Same as above
        };

        // Insert data into Supabase
        // 'contact_messages' should match your table name in Supabase
        await supabase.from('contact_messages').insert(formData);

        // Success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Thank you! Your message has been received.'),
            backgroundColor: kAccentColor,
          ),
        );
        _formKey.currentState!.reset();
        _firstNameController.clear();
        _lastNameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
      } catch (e) {
        // Handle network errors or other exceptions
        print('Error sending form: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'An error occurred. Please check your connection and try again.'),
              backgroundColor: Colors.redAccent),
        );
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    } else if (_isSubmitting) {
      // Optionally inform user if they click again while submitting
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submission in progress...')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please correct the errors in the form.'),
            backgroundColor: Colors.redAccent),
      );
    }
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String subLabel,
    String? Function(String?)? validator,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(subLabel,
            style: TextStyle(color: kTextColor.withOpacity(0.8), fontSize: 14)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(color: kFormFieldTextColor, fontSize: 16),
          decoration: InputDecoration(
            filled: true,
            fillColor: kFormFieldBackgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            errorStyle: const TextStyle(color: kAccentColor, fontSize: 12),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          vertical: 20.0, horizontal: isSmallScreen ? 0 : 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Please use the form below to request a quote for a\nproject, inquire about a collaboration, or simply say\nhello.',
              style: textTheme.titleLarge?.copyWith(
                fontSize: isSmallScreen ? 16 : 18,
                height: 1.6,
                color: kTextColor.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 30),

            // Name Fields
            Text('Name (required)',
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align validator messages properly
              children: [
                Expanded(
                  child: _buildFormField(
                    controller: _firstNameController,
                    subLabel: 'First Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFormField(
                    controller: _lastNameController,
                    subLabel: 'Last Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name.';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Email Field
            Text('Email (required)',
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            _buildFormField(
              controller: _emailController,
              subLabel: '', // Main label is enough
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email.';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Subject Field
            Text('Subject (required)',
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            _buildFormField(
              controller: _subjectController,
              subLabel: '', // Main label is enough
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a subject.';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Message Field
            Text('Message (required)',
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            _buildFormField(
              controller: _messageController,
              subLabel: '', // Main label is enough
              maxLines: 6,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message.';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),

            // Submit Button
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                    disabledBackgroundColor:
                        kButtonBackgroundColor.withOpacity(0.5)),
                child: _isSubmitting
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(kButtonTextColor),
                        ),
                      )
                    : Text('Submit'),
              ),
            ),
            const SizedBox(height: 20), // Extra space at bottom
          ],
        ),
      ),
    );
  }
}

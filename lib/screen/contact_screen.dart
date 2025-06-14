import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    if (_formKey.currentState!.validate()) {
      // Process data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Form Submitted!\nName: ${_firstNameController.text} ${_lastNameController.text}\nEmail: ${_emailController.text}\nSubject: ${_subjectController.text}\nMessage: ${_messageController.text}'),
          backgroundColor: kAccentColor,
        ),
      );
      final String backendUrl = 'YOUR_BACKEND_API_ENDPOINT_HERE';

      try {
        final response = await http.post(
          Uri.parse(backendUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF--8',
          },
          body: jsonEncode(<String, String>{
            'firstName': _firstNameController.text,
            'lastName': _lastNameController.text,
            'email': _emailController.text,
            'subject': _subjectController.text,
            'message': _messageController.text,
          }),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Success
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Thank you! Your message has been sent.'),
              backgroundColor: kAccentColor, // Or your success color
            ),
          );
          _formKey.currentState!.reset();
          _firstNameController.clear();
          _lastNameController.clear();
          _emailController.clear();
          _subjectController.clear();
          _messageController.clear();
        } else {
          // Handle server errors
          print('Server error: ${response.statusCode}');
          print('Response body: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Failed to send message. Please try again later.'),
                backgroundColor: Colors.redAccent),
          );
        }
      } catch (e) {
        // Handle network errors or other exceptions
        print('Error sending form: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'An error occurred. Please check your connection and try again.'),
              backgroundColor: Colors.redAccent),
        );
      }
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
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ),
            const SizedBox(height: 20), // Extra space at bottom
          ],
        ),
      ),
    );
  }
}

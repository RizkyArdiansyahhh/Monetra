import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsDialogWidget extends StatelessWidget {
  const TermsAndConditionsDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(children: [
        Text(
          "Welcome to Monetra, an application designed to provide flexibility and convenience in network monitoring based on Zabbix. This application enables users to perform real-time monitoring, add and remove hosts, and receive important notifications regarding the status of monitored systems. With Monetra, users can manage IT infrastructure more efficiently and responsively, anytime and anywhere.\n\n"
          "By downloading, accessing, or using this application, users are deemed to have read, understood, and agreed to all the terms outlined in this document. If a user does not agree with any or all of these terms, it is recommended not to continue using the application. Monetra is only intended for individuals who have the legal capacity to agree to these terms. If a user is under 18 years of age, the use of this application must be authorized and supervised by a legal guardian.\n\n"
          "Each user is fully responsible for the security of their account and credentials, including maintaining the confidentiality of login information. Misuse of the application for unlawful purposes, such as hacking, data abuse, or any actions that may harm network systems, is strictly prohibited. Additionally, any form of data manipulation or unauthorized exploitation of security vulnerabilities within Monetra will be considered a serious violation, subject to legal sanctions. Users are also prohibited from distributing, modifying, or using any part of this application for commercial purposes without written permission from the developer.\n\n"
          "All rights to the design, logo, features, program code, and other elements of Monetra are owned by Rizky Ardiansyah and are protected by copyright laws and relevant regulations. Unauthorized use, reproduction, or distribution of any part of this application without official permission from the developer constitutes a legal violation and may result in sanctions under applicable laws.\n\n"
          "Monetra is committed to protecting user privacy and data security. The collected information will only be used for operational purposes and service improvements. Users can rest assured that personal data provided will not be shared, sold, or distributed to third parties without explicit consent, except as required by law or authorized authorities.\n\n"
          "Monetra is provided  without explicit or implicit warranties regarding availability, reliability, or suitability for a particular purpose. The developer is not responsible for any loss, damage, or negative consequences arising from the use of this application, including but not limited to system or network disruptions beyond the developer's control, user misconfiguration leading to monitoring failures, and third-party misuse due to user negligence in safeguarding account credentials.\n\n"
          "The developer reserves the right to modify, add, or update these terms and conditions at any time to align with application developments and applicable regulations. Any changes will be communicated to users, and continued use of the application after such changes will be considered acceptance of the updated terms.\n\n"
          "In enforcing these policies, Monetra adheres to and complies with the laws of Indonesia. Any disputes arising from the use of this application will be resolved through deliberation or applicable legal mechanisms.\n\n"
          "If users have any questions, complaints, or need assistance regarding the use of Monetra, they may contact the development team via email, website, or the provided contact information. We are committed to delivering the best service and welcome feedback that can improve the quality of this application.\n\n",
          textAlign: TextAlign.justify,
          style: GoogleFonts.montserrat(fontSize: 14, color: Colors.black),
        ),
        Text(
            "Monetra is developed by Rizky Ardiansyah from Universitas Riau in 2025."
            "Copyright © 2025 Rizky Ardiansyah. All rights reserved.",
            style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ]),
    );
  }
}

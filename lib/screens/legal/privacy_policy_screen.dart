import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'Privacy Policy | سياسة الخصوصية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FLEX YEMEN PRIVACY POLICY',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.goldColor),
            ),
            Text(
              'Last Updated: April 16, 2026 | Effective Date: April 16, 2026',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            _buildSection(
              '1. INTRODUCTION AND SCOPE',
              'Flex Yemen ("the Platform," "we," "us," "our") is committed to protecting the privacy and security of your Personal Data. This Privacy Policy explains how we collect, use, disclose, retain, and protect your information when you access or use our Platform, including our mobile application, website, and related services (collectively, the "Services").\n\n'
              'This Policy is designed to comply with applicable data protection laws, including but not limited to the General Data Protection Regulation (GDPR), California Consumer Privacy Act (CCPA), and other relevant privacy frameworks.\n\n'
              'BY ACCESSING OR USING OUR SERVICES, YOU ACKNOWLEDGE THAT YOU HAVE READ, UNDERSTOOD, AND AGREE TO BE BOUND BY THIS PRIVACY POLICY. IF YOU DO NOT AGREE, YOU MUST IMMEDIATELY DISCONTINUE USE OF THE SERVICES.',
            ),
            _buildSection(
              '2. DEFINITIONS AND INTERPRETATION',
              'For the purposes of this Privacy Policy:\n\n'
              '"Personal Data" means any information relating to an identified or identifiable natural person (Data Subject). An identifiable natural person is one who can be identified, directly or indirectly, by reference to an identifier such as a name, identification number, location data, online identifier, or to one or more factors specific to the physical, physiological, genetic, mental, economic, cultural, or social identity of that natural person.\n\n'
              '"Sensitive Personal Data" means Personal Data revealing racial or ethnic origin, political opinions, religious or philosophical beliefs, trade union membership, genetic data, biometric data for the purpose of uniquely identifying a natural person, data concerning health, or data concerning a natural person\'s sex life or sexual orientation.\n\n'
              '"Processing" means any operation or set of operations performed on Personal Data, whether or not by automated means, such as collection, recording, organization, structuring, storage, adaptation or alteration, retrieval, consultation, use, disclosure by transmission, dissemination or otherwise making available, alignment or combination, restriction, erasure, or destruction.\n\n'
              '"Data Controller" means the natural or legal person, public authority, agency, or other body which, alone or jointly with others, determines the purposes and means of the Processing of Personal Data.\n\n'
              '"Data Processor" means a natural or legal person, public authority, agency, or other body which processes Personal Data on behalf of the Data Controller.\n\n'
              '"Data Subject" means the identified or identifiable natural person to whom Personal Data relates.\n\n'
              '"Consent" means any freely given, specific, informed, and unambiguous indication of the Data Subject\'s wishes by which he or she, by a statement or by a clear affirmative action, signifies agreement to the Processing of Personal Data relating to him or her.',
            ),
            _buildSection(
              '3. DATA COLLECTION: CATEGORIES AND METHODS',
              '3.1 Personal Identifiable Information (PII) We Collect:\n'
              '• Full Legal Name (First Name, Middle Name, Last Name, Family Name)\n'
              '• Username and Display Name\n'
              '• Mobile Telephone Number (Verified via One-Time Password OTP/SMS Verification)\n'
              '• Email Address (Primary Email and Recovery Email)\n'
              '• National Identification Number / Civil ID / Passport Number\n'
              '• Date of Birth (For Age Verification and Legal Capacity Confirmation)\n'
              '• Gender (Optional)\n'
              '• Profile Photograph (Optional)\n\n'
              '3.2 Location and Device Information:\n'
              '• Precise Geolocation Data (GPS Coordinates, Latitude and Longitude)\n'
              '• Approximate Location Data (Derived from IP Address, WiFi Access Points, Cell Tower Triangulation)\n'
              '• Internet Protocol Address (IPv4 and IPv6)\n'
              '• Device Identifiers (Unique Device Identifier UDID, International Mobile Equipment Identity IMEI, Media Access Control MAC Address, Android ID, Identifier for Advertisers IDFA)\n'
              '• Device Fingerprint (Combination of Device Characteristics for Fraud Prevention)\n'
              '• Browser Type and Version (User Agent String)\n'
              '• Operating System and Version (iOS, Android, HarmonyOS)\n'
              '• Mobile Network Operator and Carrier Information\n'
              '• Time Zone Settings and Preferred Language\n\n'
              '3.3 Financial and Transaction Data:\n'
              '• Bank Account Details (Account Holder Name, International Bank Account Number IBAN, Account Number, Bank Name, SWIFT/BIC Code)\n'
              '• E-Wallet Account Identifiers (Jeeb Wallet ID, OneCash Account, You Mobile Number, Mahfazati ID, Floosak Account, Easy Yemen Reference)\n'
              '• Payment Card Information (Cardholder Name, Card Number, Expiration Date, CVV/CVC). NOTE: Full card details are tokenized and stored by our PCI-DSS Level 1 compliant payment processors. We do not store raw magnetic stripe or full primary account number (PAN) data on our servers.\n'
              '• Transaction Records (Transaction ID, Amount, Currency, Timestamp, Status, Payment Method, Authorization Code)\n'
              '• Billing Address and Shipping Address\n\n'
              '3.4 Behavioral and Usage Data:\n'
              '• Browsing History (Pages Viewed, Time Spent on Pages, Referral URLs, Exit Pages)\n'
              '• Search Queries (Keywords, Search Filters Applied, Search Results Clicked)\n'
              '• Purchase History (Items Purchased, Quantities, Prices, Frequency of Purchases, Average Order Value)\n'
              '• Clickstream Data (Mouse Movements, Clicks, Scroll Depth, Session Recordings)\n'
              '• Interaction with Advertisements (Ad Impressions, Ad Clicks, Conversion Events)\n'
              '• Application Performance Data (Crash Logs, Error Reports, Latency Metrics)\n\n'
              '3.5 Third-Party Data Sources:\n'
              '• Credit Bureaus and Credit Reporting Agencies (For creditworthiness assessment of merchants)\n'
              '• Identity Verification Services (For Know Your Customer KYC compliance)\n'
              '• Sanctions and Watchlist Screening Databases (For Anti-Money Laundering AML compliance)\n'
              '• Social Media Platforms (If you choose to link your social media accounts)\n'
              '• Publicly Available Government Databases (For business verification of merchants)',
            ),
            _buildSection(
              '4. PURPOSES AND LEGAL BASES FOR PROCESSING',
              '4.1 Performance of Contract (Necessary for Service Delivery):\n'
              '• To create, maintain, and authenticate your user account\n'
              '• To process and fulfill your orders, including payment processing and delivery coordination\n'
              '• To communicate with you regarding your orders, account status, and service updates\n'
              '• To provide customer support, handle inquiries, and resolve disputes\n'
              '• To facilitate communication between buyers and sellers through our chat system\n'
              '• To process refunds, returns, and warranty claims\n\n'
              '4.2 Legitimate Interests (Balanced Against Your Rights and Freedoms):\n'
              '• To detect, prevent, and investigate fraud, money laundering, terrorist financing, and other illegal activities\n'
              '• To verify the identity and legal capacity of users (KYC/KYB Compliance)\n'
              '• To conduct credit checks and assess the financial reliability of merchants\n'
              '• To monitor compliance with our Terms of Service and Community Guidelines\n'
              '• To analyze usage patterns and improve the functionality, performance, and user experience of our Services\n'
              '• To personalize content and product recommendations based on your browsing and purchase history\n'
              '• To conduct market research, statistical analysis, and business intelligence\n'
              '• To enforce our legal rights, including debt collection and litigation\n'
              '• To protect the security and integrity of our Platform and IT systems\n\n'
              '4.3 Consent (Where Explicitly Provided):\n'
              '• To send you marketing communications, promotional offers, newsletters, and personalized advertisements (You may withdraw consent at any time)\n'
              '• To use your precise geolocation data for location-based services (e.g., finding nearby stores)\n'
              '• To access your device camera, microphone, photo gallery, or contacts (Only when necessary for specific features)\n'
              '• To share your Personal Data with third-party partners for their own marketing purposes (Only with your explicit opt-in consent)\n\n'
              '4.4 Compliance with Legal Obligations:\n'
              '• To comply with applicable laws, regulations, court orders, subpoenas, or governmental requests\n'
              '• To maintain records required by tax authorities, financial regulators, and law enforcement agencies\n'
              '• To report suspicious transactions to relevant Financial Intelligence Units (FIUs)\n'
              '• To respond to valid legal process and cooperate with authorized investigative bodies',
            ),
            _buildSection(
              '5. DATA SHARING AND DISCLOSURE',
              '5.1 Service Providers and Data Processors:\n'
              'We engage trusted third-party service providers to perform functions and process data on our behalf. These providers are contractually bound to process Personal Data only in accordance with our documented instructions and to implement appropriate technical and organizational security measures. Categories of service providers include:\n'
              '• Payment Gateway Providers and Payment Processors (PCI-DSS Certified)\n'
              '• Cloud Hosting and Infrastructure Providers (Data Storage, Content Delivery Networks)\n'
              '• Customer Support and Call Center Service Providers\n'
              '• Identity Verification and KYC Service Providers\n'
              '• Fraud Detection and Prevention Service Providers\n'
              '• Email and SMS Communication Service Providers\n'
              '• Analytics and Business Intelligence Service Providers\n'
              '• Marketing and Advertising Platforms\n'
              '• Logistics and Delivery Service Partners\n\n'
              '5.2 Affiliates and Subsidiaries:\n'
              'We may share your information with our corporate affiliates, subsidiaries, and parent companies for purposes consistent with this Privacy Policy. All affiliated entities are required to honor this Privacy Policy.\n\n'
              '5.3 Business Transfers:\n'
              'In the event of a merger, acquisition, reorganization, bankruptcy, receivership, sale of company assets, or transition of service to another provider, your Personal Data may be transferred to the successor entity as part of the transaction. We will notify you via email and/or a prominent notice on our Platform of any change in ownership or use of your Personal Data.\n\n'
              '5.4 Legal and Regulatory Disclosures:\n'
              'We may disclose your Personal Data if we believe in good faith that such disclosure is necessary to:\n'
              '• Comply with applicable laws, regulations, legal process, or enforceable governmental requests\n'
              '• Enforce our Terms of Service, including investigation of potential violations\n'
              '• Detect, prevent, or otherwise address fraud, security, or technical issues\n'
              '• Protect the rights, property, or safety of Flex Yemen, our users, or the public against harm or illegal activities\n\n'
              '5.5 With Your Consent:\n'
              'We may share your Personal Data with other third parties when we have obtained your explicit, informed consent to do so.',
            ),
            _buildSection(
              '6. INTERNATIONAL DATA TRANSFERS',
              'Your Personal Data may be transferred to, stored in, and processed in countries outside of your country of residence, including countries that may not provide the same level of data protection as your home jurisdiction. These international transfers are necessary for the global nature of our operations and the services provided by our third-party processors.\n\n'
              'When we transfer Personal Data internationally, we implement appropriate safeguards in accordance with applicable data protection laws, including but not limited to:\n'
              '• European Commission Standard Contractual Clauses (SCCs) for transfers from the European Economic Area (EEA), United Kingdom, and Switzerland\n'
              '• Binding Corporate Rules (BCRs) for intra-group transfers\n'
              '• Adequacy Decisions issued by relevant regulatory authorities\n'
              '• Derogations for specific situations as permitted by applicable law\n\n'
              'By using our Services, you acknowledge and consent to the transfer of your Personal Data to countries outside your country of residence as described in this Privacy Policy.',
            ),
            _buildSection(
              '7. DATA RETENTION AND STORAGE',
              '7.1 Retention Periods:\n'
              'We retain your Personal Data only for as long as necessary to fulfill the purposes for which it was collected, including for the purposes of satisfying any legal, regulatory, accounting, or reporting requirements. To determine the appropriate retention period, we consider:\n'
              '• The amount, nature, and sensitivity of the Personal Data\n'
              '• The potential risk of harm from unauthorized use or disclosure\n'
              '• The purposes for which we process your Personal Data and whether we can achieve those purposes through other means\n'
              '• Applicable legal, regulatory, tax, accounting, and other requirements\n\n'
              '7.2 Specific Retention Guidelines:\n'
              '• Account Information: Retained for the duration of your account being active, plus a period of seven (7) years after account closure for legal and audit purposes\n'
              '• Transaction Records: Retained for a minimum of ten (10) years to comply with tax laws, anti-money laundering regulations, and financial record-keeping requirements\n'
              '• Communications and Correspondence: Retained for three (3) years from the date of last communication\n'
              '• Marketing Preferences: Retained indefinitely unless you withdraw consent or request deletion\n'
              '• KYC/AML Verification Documents: Retained for five (5) years after the termination of the business relationship\n'
              '• Log Files and System Data: Retained for a rolling period of twelve (12) to twenty-four (24) months\n\n'
              '7.3 Data Minimization and Anonymization:\n'
              'When Personal Data is no longer required for the primary purpose, we may anonymize or pseudonymize such data so that it can no longer be associated with an identified or identifiable natural person. Anonymized data may be retained indefinitely for statistical, research, and business intelligence purposes.',
            ),
            _buildSection(
              '8. DATA SECURITY MEASURES',
              '8.1 Technical Security Measures:\n'
              'We implement and maintain industry-standard technical safeguards to protect your Personal Data against unauthorized access, disclosure, alteration, and destruction, including:\n'
              '• Transport Layer Security (TLS 1.3) encryption for data in transit\n'
              '• Advanced Encryption Standard (AES-256) for data at rest\n'
              '• Multi-Factor Authentication (MFA) for administrative access\n'
              '• Regular vulnerability scanning and penetration testing by qualified security professionals\n'
              '• Web Application Firewall (WAF) and Distributed Denial of Service (DDoS) protection\n'
              '• Intrusion Detection and Prevention Systems (IDS/IPS)\n'
              '• Secure Sockets Layer (SSL) / Transport Layer Security (TLS) certificate validation\n'
              '• Regular security patches and system updates\n\n'
              '8.2 Organizational Security Measures:\n'
              '• Access to Personal Data is restricted to authorized personnel on a strict need-to-know basis\n'
              '• All employees and contractors sign confidentiality agreements and undergo data protection training\n'
              '• Background checks are conducted on personnel with access to sensitive data\n'
              '• Regular internal and external audits of security practices\n'
              '• Incident Response Plan and Data Breach Notification Procedures in compliance with applicable laws\n'
              '• Designated Data Protection Officer (DPO) responsible for overseeing data protection compliance\n\n'
              '8.3 Limitations and Disclaimer:\n'
              'Despite our best efforts, no method of transmission over the Internet or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Data, we cannot guarantee its absolute security. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. Please notify us immediately of any unauthorized use of your account or any other breach of security.',
            ),
            _buildSection(
              '9. YOUR RIGHTS AND CHOICES',
              'Depending on your jurisdiction, you may have certain rights regarding your Personal Data:\n\n'
              '9.1 Right to Access and Data Portability:\n'
              'You have the right to request access to the Personal Data we hold about you and to receive a copy of such data in a structured, commonly used, and machine-readable format. You may also request that we transmit this data directly to another Data Controller where technically feasible.\n\n'
              '9.2 Right to Rectification:\n'
              'You have the right to request correction of inaccurate or incomplete Personal Data we hold about you. You can update certain information directly through your account settings.\n\n'
              '9.3 Right to Erasure (Right to be Forgotten):\n'
              'You have the right to request the deletion of your Personal Data under certain circumstances, such as when the data is no longer necessary for the purposes for which it was collected, when you withdraw consent, or when the data has been unlawfully processed. This right is not absolute and may be limited by legal retention obligations.\n\n'
              '9.4 Right to Restriction of Processing:\n'
              'You have the right to request that we restrict the processing of your Personal Data in certain situations, such as when you contest the accuracy of the data or object to processing.\n\n'
              '9.5 Right to Object:\n'
              'You have the right to object to the processing of your Personal Data based on our legitimate interests or for direct marketing purposes. We will cease processing unless we demonstrate compelling legitimate grounds that override your interests, rights, and freedoms.\n\n'
              '9.6 Right to Withdraw Consent:\n'
              'Where processing is based on your consent, you have the right to withdraw that consent at any time. Withdrawal of consent does not affect the lawfulness of processing based on consent before its withdrawal.\n\n'
              '9.7 Right to Lodge a Complaint:\n'
              'You have the right to lodge a complaint with a supervisory authority, particularly in the Member State of your habitual residence, place of work, or place of the alleged infringement if you consider that the processing of your Personal Data infringes applicable data protection laws.\n\n'
              '9.8 Automated Decision-Making and Profiling:\n'
              'You have the right not to be subject to a decision based solely on automated processing, including profiling, which produces legal effects concerning you or similarly significantly affects you. We do not engage in such automated decision-making without human intervention.\n\n'
              'To exercise any of these rights, please contact us using the contact information provided in Section 14. We will respond to your request within the timeframes required by applicable law. We may need to verify your identity before processing your request.',
            ),
            _buildSection(
              '10. COOKIES AND SIMILAR TRACKING TECHNOLOGIES',
              '10.1 What Are Cookies:\n'
              'Cookies are small text files that are placed on your device when you visit a website or use an application. Cookies are widely used to make websites and applications work, or work more efficiently, as well as to provide information to the owners of the site or app.\n\n'
              '10.2 Types of Cookies We Use:\n'
              '• Strictly Necessary Cookies: These cookies are essential for the operation of our Platform and enable you to navigate and use its features. Without these cookies, services you have requested cannot be provided.\n'
              '• Performance and Analytics Cookies: These cookies collect information about how users interact with our Platform, such as which pages are visited most often and any error messages received. This information is aggregated and anonymized and is used solely to improve the performance and user experience.\n'
              '• Functionality Cookies: These cookies allow our Platform to remember choices you make (such as your language preference or the region you are in) and provide enhanced, more personalized features.\n'
              '• Targeting and Advertising Cookies: These cookies are used to deliver advertisements that are more relevant to you and your interests. They are also used to limit the number of times you see an advertisement and to help measure the effectiveness of advertising campaigns.\n\n'
              '10.3 Managing Cookies:\n'
              'Most web browsers and mobile operating systems allow you to control cookies through their settings preferences. You can set your browser to refuse cookies, delete cookies, or alert you when cookies are being sent. However, if you choose to disable cookies, some features of our Platform may not function properly or may become unavailable.\n\n'
              '10.4 Do Not Track Signals:\n'
              'Some web browsers may transmit "Do Not Track" (DNT) signals. At this time, our Platform does not respond to DNT signals due to the lack of a standardized industry approach.',
            ),
            _buildSection(
              '11. CHILDREN\'S PRIVACY',
              'Our Services are not intended for use by children under the age of majority in their jurisdiction of residence (typically 18 years of age). We do not knowingly collect Personal Data from children. If we become aware that we have inadvertently collected Personal Data from a child without verifiable parental consent, we will take steps to delete such information promptly. If you believe that we might have any information from or about a child, please contact us immediately.',
            ),
            _buildSection(
              '12. THIRD-PARTY LINKS AND SERVICES',
              'Our Platform may contain links to third-party websites, applications, or services that are not owned or controlled by Flex Yemen. This Privacy Policy applies only to information collected by our Platform. We are not responsible for the privacy practices, content, or security of any third-party sites. We encourage you to review the privacy policies of any third-party site you visit before providing any Personal Data.',
            ),
            _buildSection(
              '13. CHANGES TO THIS PRIVACY POLICY',
              'We reserve the right to modify, amend, or update this Privacy Policy at any time to reflect changes in our practices, technologies, legal requirements, or for other operational reasons. When we make material changes, we will notify you by email (sent to the email address specified in your account) or by means of a prominent notice on our Platform prior to the change becoming effective. The "Last Updated" date at the top of this Policy will be revised accordingly.\n\n'
              'Your continued use of the Services after the effective date of any revised Privacy Policy constitutes your acceptance of the revised terms. If you do not agree with the changes, you must discontinue use of the Services and may request deletion of your account and associated Personal Data.',
            ),
            _buildSection(
              '14. CONTACT INFORMATION AND DATA PROTECTION OFFICER',
              'If you have any questions, concerns, or requests regarding this Privacy Policy or our data protection practices, or if you wish to exercise any of your data subject rights, please contact our Data Protection Officer (DPO) at:\n\n'
              'Flex Yemen Data Protection Office\n'
              'Email: privacy@flexyemen.com\n'
              'Address: Sana\'a, Yemen\n'
              'Phone: +967 1 234 567\n\n'
              'We will endeavor to respond to all legitimate inquiries and requests within the timeframes prescribed by applicable law.',
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ACKNOWLEDGMENT AND CONSENT',
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.goldColor),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'By continuing to use Flex Yemen, you expressly acknowledge that you have read, understood, and agree to be bound by this Privacy Policy and consent to the collection, use, disclosure, and retention of your Personal Data as described herein.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: const TextStyle(fontSize: 14, height: 1.6),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'Legal Disclaimer | إخلاء المسؤولية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LEGAL DISCLAIMER AND LIMITATION OF LIABILITY',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.gold),
            ),
            Text(
              'Last Updated: April 16, 2026',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            
            _buildWarningBox(
              'IMPORTANT LEGAL NOTICE',
              'PLEASE READ THIS DISCLAIMER CAREFULLY. IT CONTAINS IMPORTANT INFORMATION REGARDING YOUR LEGAL RIGHTS, REMEDIES, AND OBLIGATIONS. THIS DISCLAIMER LIMITS THE LIABILITY OF FLEX YEMEN AND AFFECTS YOUR ABILITY TO RECOVER DAMAGES.',
            ),
            
            _buildSection(
              '1. NO LIABILITY FOR ILLEGAL USE',
              '1.1 Prohibition of Unlawful Activities:\n'
              'Flex Yemen expressly prohibits the use of its Platform for any illegal, unlawful, fraudulent, or unauthorized purposes. Users are strictly forbidden from using the Platform to engage in, facilitate, or promote any activity that violates applicable local, state, national, or international laws, regulations, or ordinances.\n\n'
              '1.2 User\'s Sole Responsibility:\n'
              'Each User is solely and exclusively responsible for ensuring that their use of the Platform, including all transactions, communications, and content, complies with all applicable laws and regulations. Flex Yemen does not provide legal advice and makes no representations or warranties regarding the legality of any User\'s activities on the Platform.\n\n'
              '1.3 Reporting of Suspicious Activities:\n'
              'If Flex Yemen becomes aware of or reasonably suspects that a User is engaging in illegal activities, including but not limited to money laundering, terrorist financing, fraud, trafficking in illicit goods, sanctions violations, or any other criminal conduct, we reserve the right to:\n'
              '• Immediately suspend or terminate the User\'s account without prior notice;\n'
              '• Freeze any funds or assets associated with the account pending investigation;\n'
              '• Report such activities to appropriate law enforcement authorities, financial intelligence units, and regulatory bodies;\n'
              '• Cooperate fully with any resulting investigation or prosecution, including providing all relevant account information, transaction records, and communications.\n\n'
              '1.4 No Liability for User Misconduct:\n'
              'Flex Yemen shall not be liable for any damages, losses, claims, or expenses arising from or related to any User\'s illegal, fraudulent, or unauthorized use of the Platform. Users who violate applicable laws agree to indemnify and hold Flex Yemen harmless from any and all consequences of such violations, including legal fees, fines, penalties, and damages awarded to third parties.',
            ),
            
            _buildSection(
              '2. NO LIABILITY FOR TRANSACTIONS BETWEEN USERS',
              '2.1 Platform as Venue Only:\n'
              'Flex Yemen operates as a neutral venue and technology platform that facilitates connections between Buyers and Sellers. Flex Yemen is not a party to any transaction between Users, is not a buyer, seller, or agent for any party, and does not transfer legal ownership of items from Seller to Buyer.\n\n'
              '2.2 No Control Over Listed Items:\n'
              'Flex Yemen has no control over and does not guarantee:\n'
              '• The existence, quality, safety, authenticity, or legality of items listed;\n'
              '• The truth, accuracy, or completeness of any listing descriptions, images, or representations;\n'
              '• The ability of Sellers to sell items or fulfill orders;\n'
              '• The ability of Buyers to pay for items purchased;\n'
              '• The completion of any transaction or the performance of any contractual obligations between Users.\n\n'
              '2.3 Caveat Emptor (Buyer Beware):\n'
              'All transactions are conducted entirely at the risk of the parties involved. Buyers are strongly encouraged to exercise due diligence, ask questions, request additional information or images, and use secure payment methods. Flex Yemen does not provide any warranties or guarantees regarding items purchased through the Platform.\n\n'
              '2.4 Limitation of Liability for Transactions:\n'
              'To the fullest extent permitted by law, Flex Yemen disclaims all liability for any loss, damage, injury, or claim arising from or related to any transaction between Users, including but not limited to non-delivery, late delivery, defective items, counterfeit items, items not as described, payment disputes, or any other issue arising from the transaction.',
            ),
            
            _buildSection(
              '3. NO LIABILITY FOR THIRD-PARTY CONTENT AND LINKS',
              '3.1 Third-Party Content:\n'
              'The Platform may display content provided by third parties, including Sellers, advertisers, and other Users. Such content is the sole responsibility of the party providing it. Flex Yemen does not endorse, guarantee, or assume responsibility for the accuracy, completeness, reliability, or legality of any third-party content.\n\n'
              '3.2 External Links:\n'
              'The Platform may contain links to third-party websites, applications, or services that are not owned or controlled by Flex Yemen. We have no control over and assume no responsibility for the content, privacy policies, terms of service, or practices of any third-party sites or services. You access such third-party sites at your own risk.\n\n'
              '3.3 No Endorsement:\n'
              'The inclusion of any third-party content or link on the Platform does not imply endorsement, sponsorship, or recommendation by Flex Yemen.',
            ),
            
            _buildSection(
              '4. NO LIABILITY FOR TECHNICAL ISSUES AND INTERRUPTIONS',
              '4.1 No Warranty of Availability:\n'
              'Flex Yemen does not warrant or guarantee that the Platform will be available at all times, uninterrupted, timely, secure, error-free, or free of viruses or other harmful components. The Platform may be subject to periods of downtime for maintenance, upgrades, or reasons beyond our control.\n\n'
              '4.2 No Liability for Service Interruptions:\n'
              'Flex Yemen shall not be liable for any loss, damage, or inconvenience resulting from:\n'
              '• Service interruptions, delays, or errors;\n'
              '• Technical malfunctions of any telephone network, computer system, server, or provider;\n'
              '• Internet congestion or connectivity issues;\n'
              '• Software bugs, glitches, or compatibility issues;\n'
              '• Cyber-attacks, hacking, or other malicious interference;\n'
              '• Force majeure events as defined in the Terms of Service.',
            ),
            
            _buildSection(
              '5. NO PROFESSIONAL ADVICE',
              '5.1 No Legal Advice:\n'
              'Nothing on the Platform constitutes legal advice. Users should consult with qualified legal counsel regarding any legal questions or concerns.\n\n'
              '5.2 No Financial Advice:\n'
              'Nothing on the Platform constitutes financial, investment, or tax advice. Users should consult with qualified financial advisors regarding any financial decisions.\n\n'
              '5.3 No Medical Advice:\n'
              'Any health or medical-related products listed on the Platform are not intended to diagnose, treat, cure, or prevent any disease. Users should consult with qualified healthcare professionals regarding any medical concerns.',
            ),
            
            _buildSection(
              '6. RESERVATION OF RIGHTS',
              'Flex Yemen expressly reserves all rights and defenses available under applicable law, including but not limited to the right to:\n\n'
              '• Remove any listing or content at any time for any reason without notice or liability;\n'
              '• Refuse service to any person or entity for any reason at our sole discretion;\n'
              '• Investigate and take appropriate action against any User suspected of violating these Terms or applicable laws;\n'
              '• Cooperate with law enforcement and regulatory authorities in investigations;\n'
              '• Modify, suspend, or discontinue any aspect of the Platform at any time without notice or liability.',
            ),
            
            _buildSection(
              '7. ACKNOWLEDGMENT OF RISK',
              'BY USING THE PLATFORM, YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT:\n\n'
              '• You are using the Platform at your own sole risk;\n'
              '• You have read and understood this Disclaimer in its entirety;\n'
              '• You accept the limitations of liability set forth herein;\n'
              '• You waive any and all claims against Flex Yemen arising from or related to your use of the Platform to the fullest extent permitted by law;\n'
              '• You will comply with all applicable laws and regulations in connection with your use of the Platform.',
            ),
            
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.gold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.gold, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: AppTheme.gold, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        'BINDING ACKNOWLEDGMENT',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.gold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'BY CONTINUING TO ACCESS OR USE FLEX YEMEN, YOU EXPRESSLY ACKNOWLEDGE THAT YOU HAVE READ, UNDERSTOOD, AND VOLUNTARILY AGREE TO BE BOUND BY THIS LEGAL DISCLAIMER IN ITS ENTIRETY. YOU FURTHER ACKNOWLEDGE THAT THIS DISCLAIMER IS A MATERIAL PART OF THE AGREEMENT BETWEEN YOU AND FLEX YEMEN AND THAT FLEX YEMEN WOULD NOT PROVIDE ACCESS TO THE PLATFORM WITHOUT YOUR ACCEPTANCE OF THESE TERMS.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningBox(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red[700], size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(fontSize: 14, height: 1.6),
          ),
        ],
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


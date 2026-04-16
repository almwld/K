import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'Terms of Service | شروط الخدمة'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FLEX YEMEN TERMS OF SERVICE',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.goldColor),
            ),
            Text(
              'Last Updated: April 16, 2026 | Effective Date: April 16, 2026',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            _buildSection(
              '1. ACCEPTANCE OF TERMS',
              'These Terms of Service ("Terms") constitute a legally binding agreement between you ("User," "you," or "your") and Flex Yemen ("Company," "we," "us," or "our") governing your access to and use of the Flex Yemen mobile application, website, and related services (collectively, the "Platform").\n\n'
              'BY CLICKING "I AGREE," "ACCEPT," OR BY ACCESSING OR USING THE PLATFORM IN ANY MANNER, YOU EXPRESSLY ACKNOWLEDGE THAT YOU HAVE READ, UNDERSTOOD, AND AGREE TO BE BOUND BY THESE TERMS, OUR PRIVACY POLICY, AND ALL OTHER APPLICABLE POLICIES, GUIDELINES, AND RULES INCORPORATED HEREIN BY REFERENCE.\n\n'
              'IF YOU DO NOT AGREE TO THESE TERMS IN THEIR ENTIRETY, YOU ARE EXPRESSLY PROHIBITED FROM USING THE PLATFORM AND MUST IMMEDIATELY DISCONTINUE ALL USE THEREOF.',
            ),
            _buildSection(
              '2. ELIGIBILITY AND LEGAL CAPACITY',
              '2.1 Age Requirement:\n'
              'You must be at least eighteen (18) years of age, or the age of majority in your jurisdiction of residence (whichever is greater), to create an account and use the Platform. By using the Platform, you represent and warrant that you meet this age requirement and have the legal capacity to enter into a binding contract.\n\n'
              '2.2 Legal Capacity:\n'
              'If you are using the Platform on behalf of a company, organization, or other legal entity, you represent and warrant that you have the full power and authority to bind such entity to these Terms. In such case, "you" and "your" shall refer to both you as an individual and the entity you represent.\n\n'
              '2.3 Prohibited Persons:\n'
              'You may not use the Platform if you are (a) located in, under the control of, or a national or resident of any country subject to comprehensive economic sanctions administered by the United States, European Union, United Nations, or other applicable governmental authority; or (b) listed on any prohibited or restricted parties list maintained by such authorities.\n\n'
              '2.4 Verification:\n'
              'We reserve the right to verify your identity, age, and eligibility at any time through various means, including but not limited to requesting government-issued identification, performing credit checks, or utilizing third-party verification services. Failure to provide requested verification information may result in suspension or termination of your account.',
            ),
            _buildSection(
              '3. ACCOUNT REGISTRATION AND SECURITY',
              '3.1 Account Creation:\n'
              'To access certain features of the Platform, you must register for an account by providing accurate, current, and complete information as prompted by the registration form. You agree to maintain and promptly update your account information to keep it accurate, current, and complete.\n\n'
              '3.2 Account Credentials:\n'
              'You are solely responsible for maintaining the confidentiality and security of your account credentials, including your username, password, and any other authentication factors. You agree not to share your credentials with any third party or allow any other person to use your account.\n\n'
              '3.3 Account Responsibility:\n'
              'You are fully and solely responsible for all activities, transactions, and conduct that occur under your account, whether authorized by you or not. You agree to immediately notify us of any unauthorized use of your account, password, or any other breach of security.\n\n'
              '3.4 Single Account:\n'
              'Each User is permitted to maintain only one (1) account. Multiple accounts per User are strictly prohibited. We reserve the right to suspend, merge, or terminate duplicate accounts at our sole discretion.\n\n'
              '3.5 Account Termination:\n'
              'We reserve the right, at our sole discretion and without prior notice, to suspend, restrict, or terminate your account and access to the Platform for any reason or no reason, including but not limited to violation of these Terms, suspected fraudulent activity, prolonged inactivity, or at the request of law enforcement or regulatory authorities.',
            ),
            _buildSection(
              '4. USER CONDUCT AND PROHIBITED ACTIVITIES',
              '4.1 Compliance with Laws:\n'
              'You agree to use the Platform in strict compliance with all applicable local, state, national, and international laws, statutes, ordinances, regulations, and treaties, including but not limited to laws governing export control, consumer protection, unfair competition, anti-discrimination, and false advertising.\n\n'
              '4.2 Prohibited Conduct:\n'
              'You expressly agree NOT to:\n'
              '(a) Use the Platform for any illegal, fraudulent, unauthorized, or improper purpose, including but not limited to money laundering, terrorist financing, trafficking in illicit goods, or evading taxes or sanctions;\n'
              '(b) Post, upload, transmit, or distribute any content that is unlawful, defamatory, libelous, obscene, pornographic, indecent, lewd, harassing, threatening, invasive of privacy or publicity rights, abusive, inflammatory, fraudulent, or otherwise objectionable;\n'
              '(c) Impersonate any person or entity, falsely state or misrepresent your affiliation with a person or entity, or engage in identity theft;\n'
              '(d) Interfere with or disrupt the operation of the Platform or the servers or networks connected to the Platform, including through the use of viruses, bots, worms, Trojan horses, logic bombs, or other malicious code;\n'
              '(e) Attempt to gain unauthorized access to any portion or feature of the Platform, or any other systems or networks connected to the Platform, through hacking, password mining, or any other illegitimate means;\n'
              '(f) Use any automated means, including robots, spiders, scrapers, or crawlers, to access, monitor, or copy any content or information from the Platform without our express prior written consent;\n'
              '(g) Engage in any activity that imposes an unreasonable or disproportionately large load on our infrastructure, as determined by us in our sole discretion;\n'
              '(h) Circumvent, disable, or otherwise interfere with security-related features of the Platform or features that prevent or restrict use or copying of any content;\n'
              '(i) Reverse engineer, decompile, disassemble, or otherwise attempt to derive the source code or underlying algorithms of any part of the Platform;\n'
              '(j) Harass, abuse, stalk, threaten, or otherwise violate the legal rights of other Users or our employees, agents, or representatives;\n'
              '(k) Use the Platform to transmit spam, chain letters, pyramid schemes, or other unsolicited commercial communications;\n'
              '(l) Collect or harvest any personally identifiable information from the Platform without express consent;\n'
              '(m) Manipulate or artificially inflate ratings, reviews, or other feedback mechanisms;\n'
              '(n) List counterfeit, stolen, or infringing items for sale;\n'
              '(o) Engage in price gouging, bid rigging, or other anti-competitive practices.',
            ),
            _buildSection(
              '5. BUYER TERMS AND CONDITIONS',
              '5.1 Offer and Acceptance:\n'
              'All listings on the Platform are invitations to treat, not binding offers. When you place an order, you are making an offer to purchase the listed items at the stated price and terms. A contract of sale is formed only when the Seller accepts your order, which may be evidenced by order confirmation, shipment notification, or other affirmative action.\n\n'
              '5.2 Pricing and Payment:\n'
              'All prices are listed in Yemeni Rial (YER) unless otherwise specified. Prices are subject to change without notice prior to order acceptance. You agree to pay all charges incurred in connection with your order, including the purchase price, applicable taxes, shipping fees, and any other charges disclosed at checkout.\n\n'
              '5.3 Payment Processing:\n'
              'Payments are processed through our designated third-party payment processors. By providing payment information, you represent and warrant that you are authorized to use the designated payment method and authorize us and our payment processors to charge the total amount to that payment method.\n\n'
              '5.4 Delivery and Risk of Loss:\n'
              'Delivery timelines are estimates only and not guaranteed. Risk of loss and title for items purchased pass to you upon delivery to the carrier. You are responsible for inspecting items upon delivery and reporting any damage or discrepancies within the timeframes specified in our Return Policy.\n\n'
              '5.5 Cancellation Rights:\n'
              'You may cancel an order prior to Seller acceptance. Once accepted, cancellation is subject to the Seller\'s individual cancellation policy. We reserve the right to cancel any order at any time for reasons including but not limited to pricing errors, product unavailability, or suspected fraud.\n\n'
              '5.6 Buyer Protection:\n'
              'Flex Yemen offers a Buyer Protection program that may provide reimbursement in certain circumstances where an item is not received or is significantly not as described. The terms, conditions, and limitations of the Buyer Protection program are set forth in a separate policy document and are incorporated herein by reference.',
            ),
            _buildSection(
              '6. SELLER TERMS AND CONDITIONS',
              '6.1 Seller Eligibility and Verification:\n'
              'To list items for sale on the Platform, you must apply for and be approved as a Seller. We reserve the right to conduct background checks, credit checks, identity verification, and Know Your Customer (KYC) / Know Your Business (KYB) procedures. Approval as a Seller is at our sole discretion and may be revoked at any time.\n\n'
              '6.2 Seller Representations and Warranties:\n'
              'As a Seller, you represent and warrant that:\n'
              '(a) You have full legal right, title, and authority to sell each item you list;\n'
              '(b) All items are genuine, authentic, and not counterfeit, stolen, or otherwise infringing on any third-party intellectual property rights;\n'
              '(c) All items comply with all applicable laws, regulations, safety standards, and labeling requirements;\n'
              '(d) Your listings are accurate, complete, and not misleading in any material respect;\n'
              '(e) You have and will maintain all necessary licenses, permits, and authorizations required to conduct your business;\n'
              '(f) You will fulfill all accepted orders in accordance with the stated terms and delivery timeframes.\n\n'
              '6.3 Listing Guidelines:\n'
              'All listings must comply with our Listing Guidelines and Prohibited Items Policy. We reserve the right to remove any listing at any time for any reason without prior notice and without liability. Repeated violations may result in account suspension or termination.\n\n'
              '6.4 Fees and Commissions:\n'
              'Sellers agree to pay all applicable fees, commissions, and charges as set forth in our Fee Schedule, which is incorporated herein by reference. Fees may include, but are not limited to:\n'
              '• Listing Fees: Per-item fees for posting listings\n'
              '• Transaction Commission: Percentage-based commission on the total sale amount (including shipping)\n'
              '• Payment Processing Fees: Fees charged by payment processors\n'
              '• Premium Placement Fees: Optional fees for enhanced listing visibility\n'
              '• Subscription Fees: Monthly or annual fees for premium Seller accounts\n\n'
              'All fees are non-refundable except as expressly provided in the Fee Schedule. We reserve the right to modify the Fee Schedule upon reasonable notice to Sellers.\n\n'
              '6.5 Payouts and Settlement:\n'
              'Funds from completed sales, less applicable fees and commissions, will be settled to your designated payout method according to the settlement schedule set forth in the Seller Agreement. We reserve the right to withhold or delay payouts in cases of suspected fraud, disputes, chargebacks, or other exceptional circumstances.\n\n'
              '6.6 Seller Performance Standards:\n'
              'Sellers must maintain minimum performance standards, including but not limited to order defect rate, late shipment rate, and cancellation rate. Failure to meet these standards may result in penalties, including increased fees, search ranking demotion, selling restrictions, or account suspension.',
            ),
            _buildSection(
              '7. DISPUTE RESOLUTION BETWEEN USERS',
              '7.1 Direct Negotiation:\n'
              'In the event of a dispute between Users (e.g., Buyer and Seller), the parties agree to first attempt to resolve the dispute informally through direct communication. The Platform provides messaging tools to facilitate such communication.\n\n'
              '7.2 Flex Yemen Dispute Resolution:\n'
              'If direct negotiation fails, either party may escalate the dispute to Flex Yemen for resolution. By using the Platform, you agree that we may, at our sole discretion, intervene in disputes and make a final and binding determination based on our review of available evidence, our policies, and principles of fairness. You agree to abide by and comply with our determination.\n\n'
              '7.3 Release of Claims:\n'
              'To the fullest extent permitted by law, you release Flex Yemen and its officers, directors, employees, agents, and affiliates from any and all claims, demands, and damages (actual and consequential) of every kind and nature, known and unknown, arising out of or in any way connected with disputes between Users.\n\n'
              '7.4 Chargebacks and Payment Disputes:\n'
              'If a Buyer initiates a chargeback or payment dispute with their financial institution, you agree to cooperate fully with our investigation. We reserve the right to debit your account for the disputed amount plus any chargeback fees assessed by payment processors, pending resolution of the dispute.',
            ),
            _buildSection(
              '8. INTELLECTUAL PROPERTY RIGHTS',
              '8.1 Platform Ownership:\n'
              'The Platform, including but not limited to its software, source code, object code, algorithms, user interface, graphics, logos, trademarks, service marks, trade dress, and all other content provided by Flex Yemen (collectively, "Platform IP"), is owned exclusively by Flex Yemen and its licensors and is protected by copyright, trademark, patent, trade secret, and other intellectual property laws of Yemen and international treaties.\n\n'
              '8.2 Limited License:\n'
              'Subject to your compliance with these Terms, we grant you a limited, non-exclusive, non-transferable, non-sublicensable, revocable license to access and use the Platform for your personal, non-commercial use or, if you are a Seller, for the limited commercial purpose of listing and selling items in accordance with these Terms.\n\n'
              '8.3 Restrictions:\n'
              'You may not copy, modify, distribute, sell, lease, loan, or create derivative works based on the Platform IP. You may not use any meta tags, hidden text, or other methods incorporating our trademarks without our express prior written consent.\n\n'
              '8.4 User-Generated Content:\n'
              'By submitting, posting, or displaying content on or through the Platform (including but not limited to product listings, reviews, comments, images, and messages), you grant Flex Yemen a worldwide, non-exclusive, royalty-free, fully paid-up, perpetual, irrevocable, transferable, and sublicensable license to use, reproduce, modify, adapt, publish, translate, create derivative works from, distribute, publicly perform, and publicly display such content in any media or format now known or hereafter developed.\n\n'
              '8.5 Infringement Claims:\n'
              'We respect the intellectual property rights of others and expect our Users to do the same. If you believe that any content on the Platform infringes your copyright, trademark, or other intellectual property rights, please notify us immediately with the information required by our Intellectual Property Policy. We will respond expeditiously to valid notices of alleged infringement.',
            ),
            _buildSection(
              '9. DISCLAIMER OF WARRANTIES',
              'THE PLATFORM IS PROVIDED ON AN "AS IS" AND "AS AVAILABLE" BASIS, WITHOUT ANY REPRESENTATIONS, WARRANTIES, OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED. TO THE FULLEST EXTENT PERMITTED BY APPLICABLE LAW, FLEX YEMEN EXPRESSLY DISCLAIMS ALL WARRANTIES, INCLUDING BUT NOT LIMITED TO:\n\n'
              '(A) IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE, AND NON-INFRINGEMENT;\n'
              '(B) WARRANTIES THAT THE PLATFORM WILL MEET YOUR REQUIREMENTS OR EXPECTATIONS;\n'
              '(C) WARRANTIES THAT THE PLATFORM WILL BE UNINTERRUPTED, TIMELY, SECURE, ERROR-FREE, OR FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS;\n'
              '(D) WARRANTIES REGARDING THE ACCURACY, COMPLETENESS, RELIABILITY, OR CURRENCY OF ANY INFORMATION, CONTENT, OR MATERIALS PROVIDED THROUGH THE PLATFORM;\n'
              '(E) WARRANTIES REGARDING THE QUALITY, SAFETY, OR LEGALITY OF ANY ITEMS LISTED OR SOLD THROUGH THE PLATFORM;\n'
              '(F) WARRANTIES REGARDING THE ABILITY OF SELLERS TO SELL ITEMS OR THE ABILITY OF BUYERS TO PAY FOR ITEMS.\n\n'
              'YOUR USE OF THE PLATFORM IS AT YOUR SOLE RISK. YOU ARE SOLELY RESPONSIBLE FOR ANY DAMAGE TO YOUR DEVICE OR LOSS OF DATA THAT RESULTS FROM YOUR USE OF THE PLATFORM.\n\n'
              'FLEX YEMEN IS NOT A PARTY TO ANY TRANSACTION BETWEEN BUYERS AND SELLERS AND HAS NO CONTROL OVER AND DISCLAIMS ALL LIABILITY FOR THE QUALITY, SAFETY, MORALITY, OR LEGALITY OF ANY ASPECT OF ANY LISTED ITEMS, THE TRUTH OR ACCURACY OF LISTINGS, OR THE ABILITY OF SELLERS TO SELL OR BUYERS TO PAY.',
            ),
            _buildSection(
              '10. LIMITATION OF LIABILITY',
              '10.1 Exclusion of Certain Damages:\n'
              'TO THE FULLEST EXTENT PERMITTED BY APPLICABLE LAW, IN NO EVENT SHALL FLEX YEMEN, ITS AFFILIATES, OFFICERS, DIRECTORS, EMPLOYEES, AGENTS, LICENSORS, OR SERVICE PROVIDERS BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, EXEMPLARY, OR PUNITIVE DAMAGES, INCLUDING BUT NOT LIMITED TO LOSS OF PROFITS, LOSS OF REVENUE, LOSS OF DATA, LOSS OF GOODWILL, BUSINESS INTERRUPTION, OR COST OF SUBSTITUTE GOODS OR SERVICES, ARISING OUT OF OR IN CONNECTION WITH YOUR USE OF OR INABILITY TO USE THE PLATFORM, WHETHER BASED ON WARRANTY, CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY, OR ANY OTHER LEGAL THEORY, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.\n\n'
              '10.2 Cap on Liability:\n'
              'TO THE FULLEST EXTENT PERMITTED BY APPLICABLE LAW, THE AGGREGATE LIABILITY OF FLEX YEMEN AND ITS AFFILIATES FOR ALL CLAIMS ARISING OUT OF OR RELATING TO THESE TERMS OR YOUR USE OF THE PLATFORM SHALL NOT EXCEED THE GREATER OF (A) THE TOTAL FEES AND COMMISSIONS PAID BY YOU TO FLEX YEMEN DURING THE TWELVE (12) MONTHS IMMEDIATELY PRECEDING THE EVENT GIVING RISE TO LIABILITY, OR (B) ONE HUNDRED UNITED STATES DOLLARS (USD 100).\n\n'
              '10.3 Exceptions:\n'
              'SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OR LIMITATION OF CERTAIN DAMAGES OR LIABILITY FOR CERTAIN TYPES OF LOSS. IN SUCH JURISDICTIONS, OUR LIABILITY IS LIMITED TO THE MAXIMUM EXTENT PERMITTED BY LAW.',
            ),
            _buildSection(
              '11. INDEMNIFICATION',
              'You agree to defend, indemnify, and hold harmless Flex Yemen, its affiliates, and their respective officers, directors, employees, agents, licensors, and service providers from and against any and all claims, damages, losses, liabilities, costs, and expenses (including reasonable attorneys\' fees and court costs) arising out of or relating to:\n\n'
              '(a) Your use of or access to the Platform;\n'
              '(b) Your violation of any provision of these Terms;\n'
              '(c) Your violation of any applicable law, rule, or regulation;\n'
              '(d) Your violation of any rights of any third party, including but not limited to intellectual property rights, privacy rights, or publicity rights;\n'
              '(e) Any dispute or transaction between you and any other User;\n'
              '(f) Any User-Generated Content you submit, post, or transmit through the Platform;\n'
              '(g) Any fraudulent, negligent, or intentional misconduct committed by you.\n\n'
              'We reserve the right, at our own expense, to assume the exclusive defense and control of any matter otherwise subject to indemnification by you, in which event you agree to cooperate fully with us in asserting any available defenses.',
            ),
            _buildSection(
              '12. GOVERNING LAW AND DISPUTE RESOLUTION',
              '12.1 Governing Law:\n'
              'These Terms and any dispute or claim arising out of or in connection with them or their subject matter or formation (including non-contractual disputes or claims) shall be governed by and construed in accordance with the laws of the Republic of Yemen, without regard to its conflict of law principles.\n\n'
              '12.2 Mandatory Arbitration:\n'
              'ANY DISPUTE, CONTROVERSY, OR CLAIM ARISING OUT OF OR RELATING TO THESE TERMS, THE PLATFORM, OR THE RELATIONSHIP BETWEEN YOU AND FLEX YEMEN SHALL BE RESOLVED EXCLUSIVELY THROUGH FINAL AND BINDING ARBITRATION ADMINISTERED BY THE YEMEN ARBITRATION ASSOCIATION (YAA) IN ACCORDANCE WITH ITS COMMERCIAL ARBITRATION RULES THEN IN EFFECT. THE ARBITRATION SHALL BE CONDUCTED IN ARABIC BEFORE A SINGLE ARBITRATOR MUTUALLY AGREED UPON BY THE PARTIES, OR, FAILING AGREEMENT, APPOINTED BY THE YAA. THE SEAT OF ARBITRATION SHALL BE SANA\'A, YEMEN.\n\n'
              '12.3 Class Action Waiver:\n'
              'YOU EXPRESSLY WAIVE ANY RIGHT TO PARTICIPATE IN ANY CLASS ACTION, COLLECTIVE ACTION, REPRESENTATIVE ACTION, OR PRIVATE ATTORNEY GENERAL ACTION AGAINST FLEX YEMEN. ALL DISPUTES MUST BE RESOLVED ON AN INDIVIDUAL BASIS.\n\n'
              '12.4 Exception for Injunctive Relief:\n'
              'Notwithstanding the foregoing, either party may seek injunctive or other equitable relief from a court of competent jurisdiction to prevent the actual or threatened infringement, misappropriation, or violation of intellectual property rights or to address any urgent matter where arbitration would not provide an adequate remedy.\n\n'
              '12.5 Limitation Period:\n'
              'ANY CAUSE OF ACTION OR CLAIM YOU MAY HAVE ARISING OUT OF OR RELATING TO THESE TERMS OR THE PLATFORM MUST BE COMMENCED WITHIN ONE (1) YEAR AFTER THE CAUSE OF ACTION ACCRUES; OTHERWISE, SUCH CAUSE OF ACTION OR CLAIM IS PERMANENTLY BARRED.',
            ),
            _buildSection(
              '13. TERMINATION',
              '13.1 Termination by You:\n'
              'You may terminate your account at any time by following the account closure procedures within the Platform or by contacting customer support. Termination of your account will not relieve you of any outstanding obligations, including payment of any fees or commissions owed.\n\n'
              '13.2 Termination by Us:\n'
              'We may suspend, restrict, or terminate your access to the Platform, in whole or in part, at any time, with or without cause, and with or without prior notice. Grounds for termination may include, but are not limited to: (a) violation of these Terms; (b) suspected fraudulent, illegal, or harmful activity; (c) prolonged inactivity; (d) request by law enforcement or regulatory authorities; or (e) discontinuance or modification of the Platform.\n\n'
              '13.3 Effect of Termination:\n'
              'Upon termination, your right to access and use the Platform shall immediately cease. All provisions of these Terms that by their nature should survive termination shall survive, including but not limited to ownership provisions, warranty disclaimers, indemnification, and limitations of liability.',
            ),
            _buildSection(
              '14. FORCE MAJEURE',
              'Neither party shall be liable for any failure or delay in performance under these Terms (except for payment obligations) due to causes beyond its reasonable control, including but not limited to acts of God, war, terrorism, riots, embargoes, acts of civil or military authorities, fire, floods, earthquakes, hurricanes, accidents, strikes, labor shortages, epidemics, pandemics, internet or telecommunications failures, or governmental restrictions (each a "Force Majeure Event"). The affected party shall promptly notify the other party of the Force Majeure Event and use commercially reasonable efforts to resume performance as soon as practicable.',
            ),
            _buildSection(
              '15. NO AGENCY OR PARTNERSHIP',
              'Nothing in these Terms shall be construed to create a partnership, joint venture, agency, employment, or franchise relationship between you and Flex Yemen. You have no authority to bind Flex Yemen in any respect. Flex Yemen is an independent contractor for all purposes.',
            ),
            _buildSection(
              '16. SEVERABILITY',
              'If any provision of these Terms is held by a court of competent jurisdiction to be invalid, illegal, or unenforceable for any reason, such provision shall be eliminated or limited to the minimum extent necessary so that the remaining provisions of these Terms will continue in full force and effect. The invalidity of any provision shall not affect the validity or enforceability of any other provision.',
            ),
            _buildSection(
              '17. WAIVER',
              'No waiver of any term, provision, or condition of these Terms, whether by conduct or otherwise, in any one or more instances, shall be deemed to be, or shall constitute, a waiver of any other term, provision, or condition hereof, whether or not similar, nor shall such waiver constitute a continuing waiver of any such term, provision, or condition. No waiver shall be binding unless executed in writing by the party making the waiver.',
            ),
            _buildSection(
              '18. ASSIGNMENT',
              'You may not assign, delegate, or transfer these Terms or any of your rights or obligations hereunder, in whole or in part, without our prior written consent. Any attempted assignment in violation of this provision shall be null and void. We may freely assign, delegate, or transfer these Terms or any of our rights or obligations hereunder without restriction and without notice to you.',
            ),
            _buildSection(
              '19. ENTIRE AGREEMENT',
              'These Terms, together with our Privacy Policy, Fee Schedule, and any other policies, guidelines, or rules incorporated herein by reference, constitute the entire agreement between you and Flex Yemen concerning the subject matter hereof and supersede all prior or contemporaneous understandings, agreements, representations, and warranties, whether written or oral.',
            ),
            _buildSection(
              '20. MODIFICATIONS TO TERMS',
              'We reserve the right, at our sole discretion, to modify, amend, or replace these Terms at any time. When we make material changes, we will notify you by email (sent to the email address associated with your account) or by posting a prominent notice on the Platform. The "Last Updated" date at the top of these Terms will be revised accordingly.\n\n'
              'Your continued use of the Platform after the effective date of any revised Terms constitutes your acceptance of the revised Terms. If you do not agree with the changes, you must discontinue use of the Platform and may terminate your account.',
            ),
            _buildSection(
              '21. CONTACT INFORMATION',
              'If you have any questions, comments, or concerns regarding these Terms, please contact us at:\n\n'
              'Flex Yemen Legal Department\n'
              'Email: legal@flexyemen.com\n'
              'Address: Sana\'a, Yemen\n'
              'Phone: +967 1 234 567',
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
                    'ACKNOWLEDGMENT AND ACCEPTANCE',
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.goldColor),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'BY CONTINUING TO USE FLEX YEMEN, YOU EXPRESSLY ACKNOWLEDGE THAT YOU HAVE READ, UNDERSTOOD, AND AGREE TO BE LEGALLY BOUND BY THESE TERMS OF SERVICE IN THEIR ENTIRETY.',
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

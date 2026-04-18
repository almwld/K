import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class FeeScheduleScreen extends StatelessWidget {
  const FeeScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'Fee Schedule | جدول العمولات والرسوم'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FLEX YEMEN FEE SCHEDULE',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.gold),
            ),
            Text(
              'Effective Date: April 16, 2026',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            
            _buildSection(
              '1. GENERAL PROVISIONS',
              'This Fee Schedule sets forth the fees, commissions, and charges applicable to Sellers using the Flex Yemen Platform. All fees are denominated in Yemeni Rial (YER) unless otherwise specified. Fees are subject to applicable taxes, including Value Added Tax (VAT), where applicable.\n\n'
              'BY LISTING ITEMS FOR SALE ON THE PLATFORM, YOU EXPRESSLY AGREE TO PAY ALL APPLICABLE FEES IN ACCORDANCE WITH THIS FEE SCHEDULE. FEES ARE NON-REFUNDABLE EXCEPT AS EXPRESSLY PROVIDED HEREIN.',
            ),
            
            _buildSection(
              '2. TRANSACTION COMMISSIONS',
              'Flex Yemen charges a commission on each successfully completed sale transaction. The commission is calculated as a percentage of the Total Sale Amount, which includes the item price plus any shipping fees charged to the Buyer.',
            ),
            
            _buildFeeTable(),
            
            _buildSection(
              '3. LISTING FEES',
              '3.1 Standard Listings:\n'
              'Basic listing: Free (up to 50 active listings per month)\n'
              'Additional listings beyond free allowance: 100 YER per listing per 30-day period\n\n'
              '3.2 Premium Placement Options (Optional):\n'
              '• Featured Listing (Homepage placement): 5,000 YER per 7-day period\n'
              '• Priority Search Ranking: 2,000 YER per 7-day period\n'
              '• Category Spotlight: 3,000 YER per 7-day period\n'
              '• Urgent Badge: 500 YER per listing\n\n'
              '3.3 Auction Listings:\n'
              '• Standard auction listing: 200 YER per listing\n'
              '• Reserve price auction: 500 YER per listing\n'
              '• Buy It Now option added to auction: 200 YER',
            ),
            
            _buildSection(
              '4. PAYMENT PROCESSING FEES',
              'Payment processing fees are charged by our third-party payment processors and passed through to Sellers. These fees vary depending on the payment method selected by the Buyer:\n\n'
              '• Flex Pay Wallet: 0% (No processing fee)\n'
              '• Jeeb / OneCash / Mahfazati / You Mobile: 0.5% of transaction amount\n'
              '• Cash Wallet / Floosak: 0.8% of transaction amount\n'
              '• Easy Yemen: 0.3% of transaction amount\n'
              '• Bank Transfer: 1,000 YER flat fee per transfer\n'
              '• Cash on Delivery (COD): 2% of transaction amount (minimum 200 YER)',
            ),
            
            _buildSection(
              '5. SUBSCRIPTION PLANS (OPTIONAL)',
              'Sellers may choose to subscribe to a monthly or annual plan for reduced commission rates and additional benefits:\n\n'
              'Basic Plan: Free\n'
              '• Standard commission rates apply\n'
              '• Up to 50 active listings\n'
              '• Basic analytics\n\n'
              'Pro Plan: 15,000 YER/month or 150,000 YER/year\n'
              '• 20% reduction on standard commission rates\n'
              '• Up to 500 active listings\n'
              '• Advanced analytics and sales reports\n'
              '• Priority customer support\n\n'
              'Premium Plan: 35,000 YER/month or 350,000 YER/year\n'
              '• 35% reduction on standard commission rates\n'
              '• Unlimited active listings\n'
              '• Premium analytics and market insights\n'
              '• Dedicated account manager\n'
              '• Free featured listing (one per month)\n\n'
              'Enterprise Plan: Custom pricing\n'
              '• Custom commission rates\n'
              '• API access for inventory management\n'
              '• White-label solutions available\n'
              '• Contact enterprise@flexyemen.com for details',
            ),
            
            _buildSection(
              '6. ADVERTISING FEES',
              'Sellers may purchase advertising placements to promote their products or store:\n\n'
              '• Banner Advertisement (Homepage): 25,000 YER per week\n'
              '• Banner Advertisement (Category Page): 10,000 YER per week\n'
              '• Sponsored Product Listings: Cost-per-click (CPC) starting at 10 YER per click\n'
              '• Store Spotlight: 15,000 YER per month\n'
              '• Email Newsletter Feature: 5,000 YER per campaign',
            ),
            
            _buildSection(
              '7. WITHDRAWAL AND SETTLEMENT FEES',
              '7.1 Standard Settlement:\n'
              '• Weekly automated settlement: Free\n'
              '• Bi-weekly automated settlement: Free\n'
              '• Monthly automated settlement: Free\n\n'
              '7.2 Expedited Withdrawal:\n'
              '• Same-day withdrawal (subject to cut-off times): 500 YER per withdrawal\n'
              '• Instant withdrawal: 1,000 YER per withdrawal\n\n'
              '7.3 Minimum Payout Threshold:\n'
              'The minimum amount for any payout is 1,000 YER. Balances below this threshold will be carried forward to the next settlement period.',
            ),
            
            _buildSection(
              '8. DISPUTE AND CHARGEBACK FEES',
              '8.1 Dispute Resolution Fee:\n'
              'If a Buyer escalates a dispute to Flex Yemen for resolution, a non-refundable Dispute Resolution Fee of 500 YER will be charged to the Seller, regardless of the outcome.\n\n'
              '8.2 Chargeback Fee:\n'
              'If a Buyer initiates a chargeback with their payment provider, a Chargeback Fee of 2,500 YER will be assessed to the Seller per chargeback, in addition to the reversal of the transaction amount.\n\n'
              '8.3 Refund Processing Fee:\n'
              'If a Seller issues a refund to a Buyer, the original transaction commission (excluding payment processing fees) will be refunded to the Seller on a pro-rata basis.',
            ),
            
            _buildSection(
              '9. PENALTIES AND FINES',
              '9.1 Late Shipment Penalty:\n'
              'If a Seller fails to ship an item within the promised handling time, a Late Shipment Penalty of 500 YER may be assessed per late shipment.\n\n'
              '9.2 Cancellation Penalty:\n'
              'If a Seller cancels an accepted order (other than at Buyer\'s request), a Cancellation Penalty of 1,000 YER may be assessed per cancellation.\n\n'
              '9.3 Listing Violation Penalty:\n'
              'If a Seller lists prohibited items or violates Listing Guidelines, a penalty of up to 5,000 YER may be assessed per violation, and the listing will be removed.',
            ),
            
            _buildSection(
              '10. FEE PAYMENT AND COLLECTION',
              '10.1 Automatic Deduction:\n'
              'All fees and commissions are automatically deducted from Seller payouts before settlement. If a Seller\'s available balance is insufficient to cover fees owed, Flex Yemen reserves the right to invoice the Seller or charge the Seller\'s registered payment method.\n\n'
              '10.2 Tax Obligations:\n'
              'Sellers are solely responsible for determining, collecting, reporting, and remitting all applicable taxes (including VAT, sales tax, and income tax) arising from their sales activities on the Platform.\n\n'
              '10.3 Late Payments:\n'
              'Any fees not paid when due shall accrue interest at the rate of 1.5% per month (18% per annum) or the maximum rate permitted by law, whichever is lower.',
            ),
            
            _buildSection(
              '11. MODIFICATIONS TO FEE SCHEDULE',
              'Flex Yemen reserves the right to modify this Fee Schedule at any time. Material changes will be communicated to Sellers via email or Platform notification at least thirty (30) days prior to the effective date. Continued use of the Platform after the effective date constitutes acceptance of the modified Fee Schedule.',
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
                    'ACKNOWLEDGMENT',
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.gold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'By listing items for sale on Flex Yemen, Seller acknowledges receipt of this Fee Schedule and agrees to be bound by its terms. Seller authorizes Flex Yemen to deduct all applicable fees from Seller payouts.',
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

  Widget _buildFeeTable() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.gold.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
            ),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Commission Rate', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                Expanded(flex: 2, child: Text('Minimum Fee', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
              ],
            ),
          ),
          _buildTableRow('Electronics & Mobiles', '8%', '200 YER'),
          _buildTableRow('Fashion & Accessories', '12%', '150 YER'),
          _buildTableRow('Home & Furniture', '10%', '300 YER'),
          _buildTableRow('Vehicles & Automotive', '5%', '1,000 YER'),
          _buildTableRow('Real Estate', '3%', '5,000 YER'),
          _buildTableRow('Groceries & Food', '10%', '100 YER'),
          _buildTableRow('Health & Beauty', '12%', '150 YER'),
          _buildTableRow('Books & Stationery', '10%', '100 YER'),
          _buildTableRow('Sports & Fitness', '10%', '200 YER'),
          _buildTableRow('Toys & Games', '12%', '100 YER'),
          _buildTableRow('Pet Supplies', '10%', '100 YER'),
          _buildTableRow('Services', '15%', '250 YER'),
          _buildTableRow('Other Categories', '12%', '150 YER'),
        ],
      ),
    );
  }

  Widget _buildTableRow(String category, String rate, String minFee) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(category)),
          Expanded(flex: 2, child: Text(rate, textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text(minFee, textAlign: TextAlign.center)),
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

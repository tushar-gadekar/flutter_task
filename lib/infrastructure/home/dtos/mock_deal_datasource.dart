import 'package:investor_app/infrastructure/home/dtos/deal_model.dart';

class MockDealDataSource {
  Future<List<DealModel>> getDeals() async {
    await Future.delayed(const Duration(milliseconds: 1400));

    final rawData = [
      {
        'id': 'd001',
        'company_name': 'GreenVolt Energy',
        'industry': 'CleanTech',
        'investment_required': 5000000.0,
        'expected_roi': 22.5,
        'risk_level': 'Medium',
        'status': 'Open',
        'company_overview':
        'GreenVolt Energy is a renewable energy startup focused on solar micro-grids for tier-2 and tier-3 cities across India. Founded in 2021, the company has already deployed 40+ installations.',
        'financial_highlights':
        'Revenue: ₹1.2Cr (FY23) | EBITDA Margin: 18% | YoY Growth: 64% | Burn Rate: ₹8L/month',
        'risk_explanation':
        'Medium risk due to dependency on government subsidies and raw material cost volatility. Strong demand pipeline reduces downside.',
        'roi_projection': [2.1, 4.5, 6.8, 9.2, 12.0, 15.3, 17.1, 18.9, 20.0, 21.2, 21.9, 22.5],
      },
      {
        'id': 'd002',
        'company_name': 'HealthBridge AI',
        'industry': 'HealthTech',
        'investment_required': 8000000.0,
        'expected_roi': 35.0,
        'risk_level': 'High',
        'status': 'Open',
        'company_overview':
        'HealthBridge AI builds diagnostic AI tools for rural clinics, reducing misdiagnosis rates. Their flagship product processes X-rays with 94% accuracy.',
        'financial_highlights':
        'Revenue: ₹80L (FY23) | ARR Growing 120% | Partnerships: 3 state govts | Team: 28 FTEs',
        'risk_explanation':
        'High risk as the product is pre-profitability and regulatory approvals are still pending in 2 states. High reward potential if scale achieved.',
        'roi_projection': [1.0, 3.2, 5.5, 8.9, 13.0, 18.4, 22.0, 26.5, 29.0, 31.2, 33.4, 35.0],
      },
      {
        'id': 'd003',
        'company_name': 'Kirana Kart',
        'industry': 'RetailTech',
        'investment_required': 2000000.0,
        'expected_roi': 18.0,
        'risk_level': 'Low',
        'status': 'Open',
        'company_overview':
        'Kirana Kart digitises local grocery stores with inventory management, UPI billing, and bulk ordering. 1200+ stores onboarded in Pune and Nashik.',
        'financial_highlights':
        'Revenue: ₹2.8Cr (FY23) | EBITDA Positive | NPS Score: 72 | MoM Growth: 11%',
        'risk_explanation':
        'Low risk with proven unit economics and a sticky merchant base. Primary risk is competition from large quick commerce players.',
        'roi_projection': [1.5, 3.0, 5.0, 7.2, 9.0, 11.0, 12.8, 14.2, 15.5, 16.5, 17.2, 18.0],
      },
      {
        'id': 'd004',
        'company_name': 'EduPath',
        'industry': 'EdTech',
        'investment_required': 3500000.0,
        'expected_roi': 28.0,
        'risk_level': 'Medium',
        'status': 'Open',
        'company_overview':
        'EduPath offers vernacular skill training for blue collar workers. Courses in electrician, plumbing, and welding with placement guarantee.',
        'financial_highlights':
        'Revenue: ₹95L (FY23) | Placement Rate: 87% | Students Trained: 3400+ | B2B Clients: 14',
        'risk_explanation':
        'Medium risk with strong social impact. Revenue depends on corporate training contracts which can have long sales cycles.',
        'roi_projection': [2.0, 5.0, 8.3, 11.5, 14.8, 17.9, 20.5, 22.8, 24.5, 26.0, 27.2, 28.0],
      },
      {
        'id': 'd005',
        'company_name': 'AgriSense',
        'industry': 'AgriTech',
        'investment_required': 6500000.0,
        'expected_roi': 31.0,
        'risk_level': 'High',
        'status': 'Closed',
        'company_overview':
        'AgriSense provides IoT soil monitoring and precision irrigation to farmers. Reduces water usage by 40% and increases yield by 18% on average.',
        'financial_highlights':
        'Revenue: ₹1.7Cr (FY23) | Devices Deployed: 8000+ | States Active: 6 | Seed Funded: ₹3Cr',
        'risk_explanation':
        'High risk due to hardware dependency, rural internet connectivity, and low farmer tech-adoption. Long payback period.',
        'roi_projection': [0.5, 2.0, 4.5, 7.8, 11.2, 15.0, 18.5, 22.0, 25.3, 27.8, 29.5, 31.0],
      },
      {
        'id': 'd006',
        'company_name': 'LegalEase',
        'industry': 'LegalTech',
        'investment_required': 1500000.0,
        'expected_roi': 20.0,
        'risk_level': 'Low',
        'status': 'Open',
        'company_overview':
        'LegalEase simplifies contract drafting and legal document review for SMEs using AI. Saves upto 70% in legal fees for small businesses.',
        'financial_highlights':
        'Revenue: ₹55L (FY23) | Subscribers: 1800 | Churn Rate: 4.2% | MRR: ₹6.8L',
        'risk_explanation':
        'Low risk SaaS model with steady subscription revenue. Risk is limited to regulatory changes in AI-generated legal documents.',
        'roi_projection': [1.8, 3.8, 6.0, 8.5, 10.8, 13.0, 14.9, 16.5, 17.8, 18.8, 19.4, 20.0],
      },
    ];

    return rawData.map((e) => DealModel.fromJson(e)).toList();
  }
}
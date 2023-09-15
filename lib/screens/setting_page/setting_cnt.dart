import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/languages/controller/languages_cnt.dart';
import 'package:katon/screens/intro/intro_page.dart';
import 'package:katon/utils/app_binding.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';

import '../../models/snackbar_datamodel.dart';
import '../../network/api_constants.dart';
import '../../services/api_service.dart';
import '../../services/snackbar_service.dart';
import '../../widgets/loading_indicator.dart';

class SettingCnt extends GetxController {
  final cnt = Get.put(LanguagesCnt());
  var indexs = 0;
  RxBool selectedVal = false.obs;

  RxList<Map<String, dynamic>> FAQList = [
    {
      "question": "1. What is TLMS?",
      "answer":
          "Ans: Teaching and Learning Management System (TLMS) is a mobile and web-based educational tool aimed at digitalizing the educational system. Due to the evolution of education from the traditional teaching and learning system to the smart classroom system, TLMS is bridging educational gaps in the educational system through E-learning and technology for teachers and students.",
    },
    {
      "question": "2. How do I sign-up on the TLMS platform?",
      "answer":
          "Ans: The MoE as a stakeholder provides user accounts for all to log in with or visit tlmsgh.com.",
    },
    {
      "question": "3. Does TLMS require payment?",
      "answer": "Ans: No payment is required for the TLMS platform.",
    },
    {
      "question": "4. Is TLMS available in other countries?",
      "answer": "Ans: The TLMS is designed to suit every country’s host.",
    },
    {
      "question": "5. Can I use the TLMS app on my laptop?",
      "answer": "Ans: TLMS is also available on the web and for tablet users.",
    },
    {
      "question": "6. What is the connect feature on the TLMS for?",
      "answer":
          "Ans: Welcome to our connecting feature, a vibrant digital environment where you can share your ideas, experiences, and views with our community. It's similar to a blog but better! Express yourself effectively through brief, insightful posts and engage in meaningful discussions with others. Connect, inspire, and keep informed via this dynamic platform created specifically for you.",
    },
    {
      "question": "7. How do I create a “new connect” on TLMS?",
      "answer":
          "Ans: You go to create after clicking connect on the menu bar, and this allows you to build a “new connect” where you may discuss ideas and opinions with others.",
    },
    {
      "question": "8. What subjects does the TLMS offer?",
      "answer":
          "Ans: TLMS provides a wide range of topics/subjects for Primary, Junior, and Senior Secondary school students. These subjects are Mathematics, ICT, English Language, RME, Integrated Science, Social Studies, and Creative Arts.",
    },
    {
      "question": "9. Can I get access to past questions on the TLMS?",
      "answer":
          "Ans: TLMS's large database of past question papers and solutions makes it a perfect product for assisting a learner in preparing for key tests or examinations.",
    },
    {
      "question": "10. Can I solve past questions on TLMS?",
      "answer": "Ans: No, past questions cannot be solved on the TLMS.",
    },
  ].obs;

  RxList<Map<String, dynamic>> TandCList = [
    {
      "mainTitle": "1. Welcome to TLMS!",
      "subList": [
        {
          "title": "1.1 Introduction:",
          "description":
              "TLMS GH provides its services (described below) to you through its website located at https://tlmsgh.com (the “Site”) and through its mobile applications and related services (collectively, such services, including any new features and applications, and the Site, the “Service(s)”), subject to the following Terms of Service (the “Terms of Service”). PLEASE READ THESE TERMS OF SERVICE CAREFULLY, AS THEY GOVERN YOUR USE OF THE SITE AND SERVICES, PARTICULARLY SECTION 10 (BINDING ARBITRATION; CLASS ACTION WAIVER), WHICH AFFECTS YOUR RIGHTS IN THE EVENT OF A DISPUTE BETWEEN US.",
        },
        {
          "title": "1.2 Modifications to Terms of Service:",
          "description":
              "At our sole discretion, we reserve the right to change or modify portions of these Terms of Service at any time. If we do this, depending on the nature of the change, we will post the changes on this page and indicate at the top of this page the date these terms were last revised and/or notify you, either through the Services' user interface, in an email notification or through other reasonable means and as required by applicable law. Any such changes will become effective no earlier than fourteen (14) days after they are posted, except that changes addressing new functions of the Services or changes made for legal reasons will be effective immediately. Your continued use of the Service after the date any such changes become effective constitutes your acceptance of the new Terms of Service. In addition, when using certain Services, you will be subject to any additional terms applicable to such Services that may be posted on the Service from time to time.",
        },
        {
          "title": "1.3 Privacy:",
          "description":
              "At TLMS, we respect the privacy of our users. For details please see our Privacy Policy By using the Service, you consent to our collection and use of personal data as outlined therein.",
        },
      ],
    },
    {
      "mainTitle": "2. Access and Use of the Service",
      "subList": [
        {
          "title": "2.1 Use Description:",
          "description":
              "The TLMS platform, and any content viewed through our service, are solely for your personal and non-commercial use. With your TLMS purchase/subscription, we grant you limited, non-exclusive, non-transferable, access to the TLMS content and view your books/course(s) through the service on a streaming-only basis for that purpose. Except for the foregoing limited license, no right, title, or interest shall be transferred to you. You agree not to use the service for public performances. TLMS may revoke your license/access at any time in its sole discretion. Upon such revocation, you must promptly destroy all content downloaded or otherwise obtained through the service, as well as copies of such materials, whether made by these Terms of Service or otherwise",
        },
        {
          "title": "2.2 Your Registration Obligations:",
          "description":
              "You may be required to register with TLMS to access and use certain Service features. If you choose to register for the Service, you agree to provide and maintain true, accurate, current, and complete information about yourself as prompted by the Service’s registration form. Registration data and certain other information about you are governed by ours.",
        },
        {
          "title": "2.3 Member Account, Password and Security:",
          "description":
              "You may never use another's account, and you may not provide another person with the username and password to access your account. You should maintain control over all of the devices that are used to access the Service. If you fail to maintain control of a device, other users may access the Service through your account and may be able to access certain of your account information. You are fully responsible for any activities that occur under your password or account, and it is your responsibility to ensure that your password remains confidential and secure. You agree to (a) immediately notify TLMS of any unauthorized use of your password or account or any other breach of security, and (b) ensure that you exit from your account at the end of each session when accessing the Service. TLMS will not be liable for any loss or damage arising from your failure to comply with this Section.",
        },
        {
          "title": "2.4 Modifications to Service:",
          "description":
              "TLMS reserves the right to modify or discontinue, temporarily or permanently, the Service (or any part thereof) with or without notice. You agree that TLMS will not be liable to you or any third party for any modification, suspension, or discontinuance of the Service. We have no obligation to retain any of Your Account or Submitted Content for any period beyond what may be required by applicable law.",
        },
        {
          "title": "2.5 Modifications to Service: Mobile Services:",
          "description":
              "The Service may include certain services that are available via a mobile device, including (i) the ability to upload content to the Service via a mobile device, (ii) the ability to browse the Service and the Site from a mobile device, and (iii) the ability to access certain features through an application downloaded and installed on a mobile device (collectively, the “Mobile Services”). To the extent, you access the Service through a mobile device, your wireless service carrier’s standard charges, data rates, and other fees may apply. In addition, downloading, installing, or using certain Mobile Services may be prohibited or restricted by your carrier, and not all Mobile Services may work with all carriers or devices. In using the Mobile Services, you may provide your telephone number. By providing your telephone number, you consent to receive calls and/or SMS, MMS, or text messages at that number. We may share your phone numbers with our affiliates or with our service providers (such as customer support, billing or collections companies, and text message service providers) whom we have contracted to assist us in pursuing our rights or providing our Services under these Terms of Service, our policies, applicable law, or any other agreement we may have with you. You agree these parties may also contact you using autodialed or prerecorded calls and text messages, as authorized by us to carry out the purposes we have identified above, and not for their purposes. In the event you change or deactivate your mobile telephone number, you agree to promptly update your TLMS account information to ensure that your messages are not sent to the person that acquires your old number.",
        },
        {
          "title": "2.6 Money Back Guarantee:",
          "description":
              "Unless otherwise noted during your purchase/subscription of the Service you choose, or as outlined in the refund policy (see Section 3.3 below), should you become dissatisfied with the Service within the first 15 days after purchase, TLMS will refund the full amount of your purchase and subsequently terminate your access/subscription. Refunds are not available for customers 15 days after purchase. Refunds are not available for accounts that have violated the terms of service; violations are determined at TLMS's sole discretion. If TLMS determines that you are abusing our refund policy, we reserve the right to suspend or terminate your account and refuse or restrict any current or future use of the Service without delivering a refund. To request a refund or to ask a question regarding the 15-day money-back guarantee, email Support at info@tlmsgh.com.",
        },
      ],
    },
    {
      "mainTitle": "3. Conditions of Use",
      "subList": [
        {
          "title": "3.1 User Conduct:",
          "description":
              "You are solely responsible for all code, video, images, information, data, text, software, music, sound, photographs, graphics, messages, or other materials (“content”) that you upload, post, publish, or display (hereinafter, “upload”) or email or otherwise use via the Service. TLMS reserves the right to investigate and take appropriate legal action against anyone who, in our sole discretion, violates this provision, including removing the offending content from the Service, suspending or terminating the account of such violators, and reporting you to the law enforcement authorities. You agree to not use the Service to:\n\nemail or otherwise upload any content that (i) infringes any intellectual property or other proprietary rights of any party; (ii) you do not have a right to upload under any law or under contractual or fiduciary relationships; (iii) contains software viruses or any other computer code, files or programs designed to interrupt, destroy or limit the functionality of any computer software or hardware or telecommunications equipment; (iv) poses or creates a privacy or security risk to any person; (v) constitutes unsolicited or unauthorized advertising, promotional materials, commercial activities and/or sales, “junk mail,” “spam,” “chain letters,” “pyramid schemes,” “contests,” “sweepstakes,” or any other form of solicitation; (vi) is unlawful, harmful, threatening, abusive, harassing, tortious, excessively violent, defamatory, vulgar, obscene, pornographic, libelous, invasive of another’s privacy, hateful racially, ethnically or otherwise objectionable; or (vii) in the sole judgment of TLMS, is objectionable or which restricts or inhibits any other person from using or enjoying the Service, or which may expose us or its users to any harm or liability of any type· interfere with or disrupt the Service or servers or networks connected to the Service, or disobey any requirements, procedures, policies, or regulations of networks connected to the Service\n\n· violate any applicable local, state, national, or international law, or any regulations having the force of law.\n\n· impersonate any person or entity, or falsely state or otherwise misrepresent your affiliation with a person or entity\n\n· harvest or collect email addresses or other contact information of other users from the Service by electronic or other means to send unsolicited emails or other unsolicited communications",
        },
        {
          "title": "3.2 Fees:",
          "description":
              "To the extent the Service or any portion thereof is made available for any fee, you will be required to select a payment plan and provide TLMS information regarding your credit card, Mobile money, or another payment instrument. You represent and warrant to TLMS that such information is true and that you are authorized to use the payment instrument. You will promptly update your account information with any changes (for example, a change in your billing address, Change of Mobile Money Number, or credit card expiration date, etc.) that may occur. You agree to pay TLMS the amount that is specified in the payment plan (as well as any applicable taxes) by the terms of such plan and this Terms of Service. You hereby authorize us to bill your payment instrument by the terms of the applicable payment plan (as well as any applicable taxes) until you terminate your account, and you further agree to pay any charges so incurred. If you dispute any charges you must let us know within thirty (30) days after the date that we charge you. We reserve the right to change our prices. Your continued use of the Service after the price change becomes effective constitutes your agreement to pay the changed amount. You shall be responsible for all taxes associated with the Services.",
        },
        {
          "title": "3.3 Recurring Subscriptions:",
          "description":
              "If you select a Service with an auto renewal feature (“Recurring Subscription”), you authorize us to maintain your account information and charge that account automatically upon the renewal of the Service you choose with no further action required by you. If TLMS is unable to charge your account as authorized by you when you enrolled in a Recurring Subscription, we, may, in our sole discretion: (i) bill you for your Service and suspend your access to the Service until payment is received, and/or (ii) seek to update your account information through third-party sources (i.e., your bank or a payment processor) to continue charging your account as authorized by you.\n\nWe may change the price for Recurring Subscriptions from time to time and will communicate any price changes to you in advance and, if applicable, how to accept those changes. Price changes for Recurring Subscriptions will take effect at the start of the next subscription period following the date of the price change. You accept the new price by continuing to use your Recurring Subscription after the price change takes effect. If you do not agree with the price changes, you have the right to reject the change by canceling your Recurring Subscription before the price change goes into effect. Please, therefore, make sure you read any such notification of price changes carefully.\n\nPayments are nonrefundable and there are no refunds or credits for partially used periods. You may cancel a Recurring Subscription at any time, but if you cancel your subscription before the end of the current subscription period, we will not refund any subscription fees already paid to us. Following any cancellation, however, you will continue to have access to the service through the end of your current subscription period. At any time, and for any reason, we may provide a refund, discount, or other consideration to some or all of our users ('credits'). The amount and form of such credits, and the decision to provide them, are at our sole and absolute discretion. The provision of credits in one instance does not entitle you to credits in the future for similar instances, nor does it obligate us to provide credits in the future, under any circumstance.\n\nIf you purchase any Service through a mobile purchase or third-party marketplace (e.g., through the Apple App Store or Google Play Store), the refund policy applicable to that third-party marketplace will apply, unless otherwise explicitly stated by us. Except as otherwise explicitly stated by us, the third-party marketplace will be solely responsible for making refunds under its refund policy, and we will have no refund obligations. TLMS disclaims any responsibility or liability related to any third-party marketplace's refund policy or the third party's compliance or noncompliance with such policy.",
        },
        {
          "title": "3.4 Commercial Use:",
          "description":
              "Unless otherwise expressly authorized herein or by us in writing, you agree not to display, distribute, license, perform, publish, reproduce, duplicate, copy, create derivative works from, modify, sell, resell, exploit, transfer, or upload for any commercial purposes, any portion of the Service, use of the Service, or access to the Service. The Service is solely for your non-commercial, personal, educative use.",
        },
      ],
    },
    {
      "mainTitle": "4. Intellectual Property Rights",
      "subList": [
        {
          "title": "4.1 Service Content, Software and Trademarks:",
          "description":
              "You acknowledge and agree that the Service may contain content or features (“Service Content”) that are protected by copyright, patent, trademark, trade secret, or other proprietary rights and laws. Except as expressly authorized by us, you agree not to modify, copy, frame, scrape, rent, lease, loan, sell, distribute, or create derivative works based on the Service or the Service Content, in whole or in part. Any use of the Service or the Service Content other than as specifically authorized herein is strictly prohibited. The content, technology, and software underlying the Service or distributed in connection therewith are the property of TLMS, our affiliates, and our partners (the “Software”). You agree not to copy, modify, create a derivative work of, reverse engineer, reverse assemble, or otherwise attempt to discover any source code, sell, assign, sublicense, or otherwise transfer any right in the application. Any rights not expressly granted herein are reserved by us.\n\nThe TLMS name and logos are trademarks and service marks of TLMS (collectively the “TLMS Trademarks”). Other TLMS, product, and service names and logos used and displayed via the Service may be trademarks or service marks of their respective owners who may or may not endorse or be affiliated with or connected to us. Nothing in this Terms of Service or the Service should be construed as granting, by implication, estoppel, or otherwise, any license or right to use any of TLMS Trademarks displayed on the Service, without our prior written permission in each instance. All goodwill generated from the use of our Trademarks will inure to our exclusive benefit.",
        },
        {
          "title": "4.2 Third Party Material:",
          "description":
              "Under no circumstances will TLMS be liable in any way for any content or materials of any third parties (including users), including, but not limited to, for any errors or omissions in any content, or any loss or damage of any kind incurred as a result of the use of any such content. Without limiting the foregoing, TLMS and its designees will have the right to remove any content that violates these Terms of Service or is deemed by us, in its sole discretion, to be otherwise objectionable. You agree that you must evaluate, and bear all risks associated with, the use of any content, including any reliance on the accuracy, completeness, or usefulness of such content.",
        },
        {
          "title": "4.3 Copyright Complaints:",
          "description":
              "TLMS respects the intellectual property of others. If you believe in good faith that any materials on the Sites/platform infringe upon your copyrights, please send the following information to our Agent at info@tlmsgh.com.\n\n· Identification of the copyrighted work claimed to have been infringed, or, if multiple copyrighted works, a representative list of such works\n\n· Identification of the material that is claimed to be infringing or to be the subject of infringing activity and that is to be removed or access to which is to be disabled, and information reasonably sufficient to permit us to locate the material\n\n· Your address, telephone number, and email address\n\n· A statement by you that you have a good faith belief that the use of the material in the manner complained of is not authorized by you.",
        },
        {
          "title": "4.4 Repeat Infringer Policy:",
          "description":
              "By the applicable terms, TLMS has adopted a policy of terminating, in appropriate circumstances and at our sole discretion, users who are deemed to be repeated infringers. We may also at its sole discretion limit access to the Service and/or terminate the memberships of any users who infringe any intellectual property rights, whether or not there is any repeat infringement.",
        },
      ],
    },
    {
      "mainTitle": "5. Indemnity and Release",
      "subList": [
        {
          "title": "",
          "description":
              "To the fullest extent permitted by law, you agree to release, indemnify and hold TLMS and its affiliates and their officers, employees, directors, and agents harmless from any losses, damages, and expenses, including reasonable attorneys’ fees, rights, claims, actions of any kind and injury (including death) arising out of or relating to your use of the Service, any User Content, your connection to the Service, your violation of these Terms of Service or your violation of any rights of another’s.",
        },
      ],
    },
    {
      "mainTitle": "6. Disclaimer of Warranties",
      "subList": [
        {
          "title": "",
          "description":
              "YOUR USE OF THE SERVICE IS AT YOUR SOLE RISK. THE SERVICE IS PROVIDED ON AN “AS IS” AND “AS AVAILABLE” BASIS. EXCEPT AS OTHERWISE EXPRESSLY PROVIDED HEREIN, TLMS EXPRESSLY DISCLAIMS ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS, IMPLIED, OR STATUTORY, INCLUDING, BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE, AND NON-INFRINGEMENT.\n\nTLMS MAKES NO WARRANTY THAT (I) THE SERVICE WILL MEET YOUR REQUIREMENTS, (II) THE SERVICE WILL BE UNINTERRUPTED, TIMELY, SECURE, OR ERROR-FREE, (III) THE RESULTS THAT MAY BE OBTAINED FROM THE USE OF THE SERVICE WILL BE ACCURATE OR RELIABLE, OR (IV) THE QUALITY OF ANY PRODUCTS, SERVICES, INFORMATION, OR OTHER MATERIAL PURCHASED OR OBTAINED BY YOU THROUGH THE SERVICE WILL MEET YOUR EXPECTATIONS.",
        },
      ],
    },
    {
      "mainTitle": "7. Limitation of Liability",
      "subList": [
        {
          "title": "",
          "description":
              "YOU EXPRESSLY UNDERSTAND AND AGREE THAT TLMS WILL NOT BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, EXEMPLARY DAMAGES, OR DAMAGES FOR LOSS OF PROFITS INCLUDING BUT NOT LIMITED TO, DAMAGES FOR LOSS OF GOODWILL, USE, DATA, OR OTHER INTANGIBLE LOSSES (EVEN IF TLMS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES), WHETHER BASED ON CONTRACT, TORT, NEGLIGENCE, STRICT LIABILITY OR OTHERWISE, RESULTING FROM: (I) THE USE OR THE INABILITY TO USE THE SERVICE; (II) THE COST OF PROCUREMENT OF SUBSTITUTE PRODUCTS AND SERVICES RESULTING FROM ANY PRODUCTS, DATA, INFORMATION OR SERVICES PURCHASED OR OBTAINED OR MESSAGES RECEIVED OR TRANSACTIONS ENTERED INTO THROUGH OR FROM THE SERVICE; (III) UNAUTHORIZED ACCESS TO OR ALTERATION OF YOUR TRANSMISSIONS OR DATA; (IV) STATEMENTS OR CONDUCT OF ANY THIRD PARTY ON THE SERVICE; OR (V) ANY OTHER MATTER RELATING TO THE SERVICE. IN NO EVENT WILL TLMS’S TOTAL LIABILITY TO YOU FOR ALL DAMAGES, LOSSES, OR CAUSES OF ACTION EXCEED THE AMOUNT YOU HAVE PAID MASTERCLASS IN THE LAST SIX (6) MONTHS,\n\nACCORDINGLY, SOME OF THE ABOVE LIMITATIONS SET FORTH ABOVE MAY NOT APPLY TO YOU. IF YOU ARE DISSATISFIED WITH ANY PORTION OF THE SERVICE OR WITH THESE TERMS OF SERVICE, YOUR SOLE AND EXCLUSIVE REMEDY IS TO DISCONTINUE THE USE OF THE SERVICE.",
        },
      ],
    },
    {
      "mainTitle": "8. Binding Arbitration; Class Action Waiver",
      "subList": [
        {
          "title": "",
          "description":
              "This Section 8 is intended to be interpreted broadly and governs any disputes between us including but not limited to claims arising out of or relating to any aspect of the relationship between us or the Terms of Service or the Service, whether based on contract, tort, statute, fraud, misrepresentation or any other legal theory. The only disputes excluded from this broad prohibition are the litigation of certain intellectual property and small court claims, as provided below.\n\nIf you have any dispute with us, you agree that before taking any formal action, you will contact, the support email: info@tlmsgh.com. Helpline: 0800790555, GZ-281-9218, Frema House Spintex Gbatsuna Ledzokuku district Accra and provide a brief, written description of the dispute and your contact information (including your username, if your dispute relates to an account). Except for intellectual property and small claims court claims, the parties agree to use their best efforts to settle any dispute, claim, question, or disagreement directly through consultation and good faith negotiations shall be a condition to either party initiating a lawsuit or arbitration.\n\nAll disputes, claims, or controversies arising out of or relating to the Terms of Service or the Service that are not resolved by the procedures identified above shall be resolved by individual (not group) binding arbitration.\n\nTLMS shall have exclusive authority to resolve all disputes arising out of or relating to the interpretation, applicability, enforceability, or formation of these Terms of Service, including but not limited to any claim that all or any part of these Terms of Services are void or voidable, or whether a claim is subject to arbitration.\n\nYou and we agree that the arbitration shall be conducted in the party’s respective individual capacities only and not as a class action or other representative action, and the parties expressly waive their right to file a class action or seek relief on a class basis. YOU AND TLMS AGREE THAT EACH MAY BRING CLAIMS AGAINST THE OTHER ONLY IN YOUR OR ITS CAPACITY, AND NOT AS A PLAINTIFF OR CLASS MEMBER IN ANY PURPORTED CLASS OR REPRESENTATIVE PROCEEDING.\n\nYOU UNDERSTAND AND AGREE THAT THE ABOVE DISPUTE PROCEDURES SHALL BE YOUR SOLE REMEDY IN THE EVENT OF A DISPUTE BETWEEN YOU AND TLMS REGARDING ANY ASPECT OF THE SERVICE (INCLUDING THE REGISTRATION PROCESS) AND THAT YOU ARE WAIVING YOUR RIGHT TO LEAD OR PARTICIPATE IN A LAWSUIT INVOLVING OTHER PERSONS, SUCH AS A CLASS ACTION.",
        },
      ],
    },
    {
      "mainTitle": "9. Termination",
      "subList": [
        {
          "title": "",
          "description":
              "You agree that TLMS, in its sole discretion, may suspend or terminate your account (or any part thereof) or use of the Service for any reason, including, without limitation, for lack of use or if we believe that you have violated or acted inconsistently with the letter or spirit of these Terms of Service. Any suspected fraudulent, abusive, or illegal activity that may be grounds for termination of your use of Service, may be referred to appropriate law enforcement authorities. TLMS may also in its sole discretion and at any time discontinue providing the Service, or any part thereof, with or without notice. You agree that any termination of your access to the Service under any provision of this Terms of Service may be affected without prior notice, and acknowledge and agree that we may immediately deactivate or delete your account and all related information and/or bar any further access to any files or the Service. Further, you agree that we will not be liable to you or any third party for any termination of your access to the Service.",
        },
      ],
    },
    {
      "mainTitle": "10. Disputes Between Users",
      "subList": [
        {
          "title": "",
          "description":
              "You agree that you are solely responsible for your interactions with any other user in connection with the Service and we will have no liability or responsibility with respect thereto. We reserves the right, but has no obligation, to become involved in any way with disputes between you and any other user of the Service.",
        },
      ],
    },
    {
      "mainTitle": "11. General",
      "subList": [
        {
          "title": "",
          "description":
              "These Terms of Service constitute the entire agreement between you and TLMS and govern your use of the Service/platform, superseding any prior agreements between you and us concerning the Service. You also may be subject to additional terms and conditions that may apply when you use affiliate or third-party services, third-party content, or third-party software. These Terms of Service will be governed by the laws of the country without regard to its conflict of law provisions. If any provision of these Terms of Service is found by a court of competent jurisdiction to be invalid, the parties nevertheless agree that the court should endeavor to give effect to the party’s intentions as reflected in the provision, and the other provisions of these Terms of Service remain in full force and effect. You agree that regardless of any statute or law to the contrary, any claim or cause of action arising out of or related to the use of the Service or these Terms of Service must be filed within one (1) year after such claim or cause of action arose or be forever barred. A printed version of this agreement and any notice given in electronic form will be admissible in judicial or administrative proceedings based upon or relating to this agreement to the same extent and subject to the same conditions as other business documents and records originally generated and maintained in printed form. You may not assign these Terms of Service without the prior written consent of TLMS, but we may assign or transfer these Terms of Service, in whole or in part, without restriction. The section titles in these Terms of Service are for convenience only and have no legal or contractual effect. Notices to you may be made via either email or regular mail. Under no circumstances shall TLMS be held liable for any delay or failure in performance resulting directly or indirectly from an event beyond its reasonable control. The Service may also provide notices to you of changes to these Terms of Service or other matters by displaying notices or links to notices generally on the Service.",
        },
      ],
    },
    {
      "mainTitle": "12. Questions? Concerns? Suggestions?",
      "subList": [
        {
          "title": "",
          "description":
              "Please contact us at; Digital Address: GZ-281-9218, Frema House Spintex Gbatsuna Ledzokuku district Accra, support email: (info@tlmsgh.com) or through our helpline 0800790555, to report any violations of these Terms of Service or to pose any questions regarding this Terms of Service or the Service.",
        },
      ],
    },
  ].obs;

  RxList<Map<String, dynamic>> privacyList = [
    {
      "title": "",
      "description":
          "Welcome to the TLMS GHANA Privacy Policy (“Policy”).\n\nTLMS GHANA (“We” or “Our”) operates https://tlmsgh.com (the “Website”) and TLMS GHANA Mobile Application (the “Application”). The Website and Application are platforms built to host, manage, and deploy curriculum-relevant educational content to learners through desktop, laptop, and tablet computers as well as smartphones, with marginal concern for internet limitations and costs.\n\nThis page informs you of Our policies regarding the collection, use, and disclosure of your data when you visit, access, browse, and/or use Our Website or Mobile Application (“Platform”) and when you use any storage or transmitting device provided by us. Please read carefully, as you need to understand how We intend to retain and protect the private information you provide us. To protect your privacy, TLMS GHANA follows different principles of worldwide user privacy and data protection practices.\n\nTLMS GHANA values your trust and confidence. We are committed to always safeguarding the privacy of your information. If you have any questions about this Policy or Our data protection practices, kindly contact us.",
    },
    {
      "title": "Consent",
      "description":
          "By accessing or using Our services or Products, you agree to the collection and use of information by this Policy. Once you provide consent, you may change your mind and withdraw the consent at any time by contacting us at info@tlmsgh.com. Please note that withdrawing consent will not affect the lawfulness of any process carried out before you withdraw your consent.",
    },
    {
      "title": "The Data We Collect About You",
      "description":
          "When signing up on Our Platform, we collect information about you. This information may include:\n\n· Profile data, such as your name, username or alias, e-mail address, mailing address, location, school, class (in school), age, organization of work, and phone number among others.\n\n· Technical information, such as the type of computer and or mobile device and internet browser you use, your computer IP address, data about the pages you access, mobile device ID or unique identifier, statistics on page views, standard Web log data, still and moving images, etc.\n\n· Marketing data, such as customer or user feedback; and • Usage data, such as time spent on Our Website and Application, when the application was opened, device data, and learning statistics (time spent learning, lessons viewed, test scores, etc.).",
    },
    {
      "title": "The Data We Collect About You",
      "description":
          "When signing up on Our Platform, we collect information about you. This information may include:\n\n· Profile data, such as your name, username or alias, e-mail address, mailing address, location, school, class (in school), age, organization of work, and phone number among others.\n\n· Technical information, such as the type of computer and or mobile device and internet browser you use, your computer IP address, data about the pages you access, mobile device ID or unique identifier, statistics on page views, standard Web log data, still and moving images, etc.\n\n· Marketing data, such as customer or user feedback; and • Usage data, such as time spent on Our Website and Application, when the application was opened, device data, and learning statistics (time spent learning, lessons viewed, test scores, etc.).",
    },
    {
      "title": "How We Use Your Personal Data",
      "description":
          "We will only use your data for the purpose for which We collected it. This may include the following:\n· to register you as a new user,\n· to process and deliver your order(s),\n· to manage your relationship with TLMS GHANA,\n· to recommend products and or services that may be of interest to you,\n· to help TLMS GHANA identify and provide the type of service offerings in which you are most interested,\n· to enable us to create the content most relevant to you and to generally improve Our services,\n· to make the Platform easier for you to use and avoid repetitions,\n· to manage, detect, prevent, and/or remediate the risk of fraud, or other potentially prohibited or illegal activities, and\n· to send periodic electronic mails, notifications, and marketing materials of Our products and services.",
    },
    {
      "title": "Third Party Links",
      "description":
          "Occasionally, we may include or offer third-party products or services on Our Platform. As such, Our Platform may contain links to websites owned and operated by third parties. These third-party websites may have their own separate and independent privacy policies, which may govern the collection and processing of your data. We urge you to review these privacy policies – because this Policy will not apply. We, therefore, have no responsibility or liability for the content, activities, and privacy practices of such third-party websites.",
    },
    {
      "title": "Cookies",
      "description":
          "Our website uses cookies (text files with small pieces of data that are used to identify your computer as you use a computer network), which We place on your computer with your consent. These cookies allow us to uniquely identify your browser and distinguish you from other users of Our Website. This enables us to track your preferences and provide you with a personalized and smooth experience when you browse Our site. The cookies We use are “analytical” cookies. They allow us to recognize and count the number of visitors and to see how visitors move around the Website when they are using it. This helps us to improve the way Our Website works, for example by ensuring that users are finding what they are looking for easily. The information collected by the cookies is not shared with any third parties.",
    },
    {
      "title": "User Profiles",
      "description":
          "Every registered user has a unique personal profile. Each profile is assigned a unique personal identification number. This helps us to ensure that only you can access your profile.\n\nWhen you register, we create your profile, assign a personal identification number (your User ID), and then send this personal identification number back to your email address with an activation link for the activation of your profile. This code is unique and applies only to you. It is your passport to seamless travel across Our Platform, allowing you to use Our Platform without having to fill out registration forms with information you’ve already provided. Even if you switch computers, you won’t have to re-register – just use your User ID to identify yourself.",
    },
    {
      "title": "Data Security",
      "description":
          "We store and process your personal information on Our servers in Ghana under strict security and data protection protocols. If We need to transfer your data to another country, we ensure that such country has adequate data protection laws to guarantee the security of your data. Please be assured that We have put in place appropriate security measures including but not limited to access controls, firewalls, data encryption, and physical security to prevent your data from being lost, altered, disclosed, or otherwise used in an unauthorized way. In addition, we limit access to your data to those employees, agents, and contractors who have a business need to know. These employees, agents, and contractors must always maintain confidentiality and will only process your data based on Our instructions.\n\nNote that We have put in place procedures to deal with any suspected personal data breach and will notify you and any applicable regulator concern of a breach where We are legally required to do so.",
    },
    {
      "title": "Retention of Personal Information",
      "description":
          "We will keep your personal information for as long as it is required and for the purpose it is being processed for, or for tax, accounting, regulatory, or legal purposes. We will keep the personal data for a period that enables us to handle or respond to any complaints, queries, or concerns relating to Our relationship with you. Related to this, we may retain your data for a longer period in the event of a complaint or if We reasonably believe there is a prospect of litigation concerning Our relationship with you.\n\nYou may notify us whenever you no longer wish to hear from us, and we will keep minimum information upon receipt of such notice to ensure that no future contact is made by us. We will actively review the personal information We hold and delete it securely, or in some cases anonymize it, when there is no longer a legal, business or user need for it to be retained.",
    },
    {
      "title": "Your Legal Rights",
      "description":
          "You have the right to:\n\n· Ask for access to your data (commonly known as a “data subject access request”). This enables you to receive a copy of the personal information We hold about you to check if We are lawfully processing it. Please note that a data subject access request may attract an administrative fee,\n\n· Ask for correction of the personal data that We hold about you. This enables you to have any incomplete or inaccurate data We hold about you corrected, though We may need to verify the accuracy of the new data you provide,\n\n· Request the removal of your data. This enables you to ask us to delete or remove personal data where there is no good reason for us continuing to process it. You also have the right to ask us to delete or remove your data where you have successfully exercised your right to object to processing (see below), where We may have processed your information unlawfully, or where We are required to delete your data to comply with local law. Note however, that We may not always be able to comply with your request of deletion for specific legal reasons which will be notified to you, if applicable, at the time of your request,\n\n· Object to processing of your data where We are relying on a legitimate interest (or those of a third party) and there is something about your situation which makes you want to object to processing on this ground as you feel it impacts on your fundamental rights and freedoms. You also have the right to object to where we are processing your data for direct marketing purposes. In some cases, we may demonstrate that We have compelling legitimate grounds to process your information which override your rights and freedoms,\n\n· Request transfer of your data to you or a third party. We will provide you, or a third party you have chosen, with your data in a structured, commonly used, machine-readable format. Note that this right only applies to automated information which you initially provided consent for us to use or where We used the information to carry out a contract with you. Please note that this request may also attract an administrative fee,\n\n· Withdraw consent at any time where We are relying on consent to process your data. However, this will not affect the lawfulness of any process carried out before you withdraw your consent. If you withdraw your consent, we may not be able to provide certain products or services to you. We will advise you if this is the case at the time you withdraw your consent.",
    },
    {
      "title": "Security",
      "description":
          "At TLMS GHANA, we implement a variety of reasonable security measures to protect the security and integrity of your personal information.\n\nTo prevent unauthorized access to your information, we have implemented strong controls and security safeguards at the technical and operational levels. Our Platform uses Transport Layer Security (TLS) to ensure secure transmission of your data. You should see the padlock symbol in your URL address bar once you are successfully logged onto the platform. The URL address will also start with https:// depicting a secure Webpage.\n\nPlease note that you also have a significant role in protecting your information. No one can see or edit your personal information without knowing your username and password, so do not share these with others. However, as the internet is not a secure medium, we cannot guarantee that security breaches will never occur. Accordingly, we are not responsible for the matters, which include actions of hackers and other unauthorized third parties that breach Our reasonable security procedure.",
    },
    {
      "title": "Online Privacy Policy Only",
      "description":
          "This online Policy applies only to information collected on Our Platform and not to information collected offline.",
    },
    {
      "title": "Changes to Our Privacy Policy",
      "description":
          "We reserve the right to amend, modify or change this Privacy Policy and if We do so, we will post the changes on this page. It is your responsibility to check the Privacy Policy every time you submit information to us or use Our Platform. Your use will signify that you agree to any such changes. In the event, the purpose is for processing change, or if a revision is material, TLMS GHANA will notify you via electronic mail or via a pop-up or redirection when you log in to our Platform.",
    },
    {
      "title": "DISCLAIMER",
      "description":
          "By this Policy We do not represent or warrant the condition or functionality of Our platform(s), its suitability for use, nor guarantee that Our services and products will be free from interruption or any error. No liability or responsibility shall lie for risks associated with the use of Our Platform, including but not limited to any risk to your computer, software, or data being damaged by any virus, software, or any other file that might be transmitted or activated via Our Platform or your access to it. Neither do We guarantee the reliability of the information contained on Our Platform—particularly those shared by third-party users.",
    },
    {
      "title": "Contact Us",
      "description":
          "If you have any questions about this Privacy Policy, please contact our Data Protection Officer (DPO) at TLMS GHANA: info@tlmsgh.com",
    },
  ].obs;

  void init() {
    if (AppPreference().getString(PreferencesKey.language) == "fr") {
      indexs = 1;
    } else if (AppPreference().getString(PreferencesKey.language) == "pt") {
      indexs = 2;
    }
  }

  Future<void> onchangeLanguage(int index) async {
    indexs = index;
    cnt.updateLanguage(cnt.locale[index].LanguageCode);
    await AppPreference().setString(
        PreferencesKey.language, "${cnt.locale[index].LanguageCode}");
  }

  Future deleteAccount() async {
    try {
      String token = AppPreference().getString(PreferencesKey.token);
      int uid = AppPreference().getInt(PreferencesKey.uId);
      String usertype = AppPreference().getString(PreferencesKey.uType);
      CustomLoadingIndicator.instance.show();

      await ApiService.instance.deleteHTTP(
        url: "${ApiRoutes.deleteAccount}",
        queryParameters: {
          "userId": uid,
          "userType": usertype,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': "application/json"
        },
      ).then((value) {
        // navigatorKey.currentState!.pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => IntroPage()),
        //     (route) => false);
        Future.delayed(Duration(milliseconds: 100), () {
          Get.offAll(() => IntroPage());
        });
      });
      CustomLoadingIndicator.instance.hide();
    } on Exception catch (e) {
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      CustomLoadingIndicator.instance.hide();
    }
  }
}

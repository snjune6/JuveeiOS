//
//  TermConditionsView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/13.
//

import SwiftUI

struct AgreeDocumentView: View {
    
    @Binding var popupVisible: Bool
    @Binding var popupGB: Int
    
    var body: some View {
        if popupVisible {
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Text(popupGB == 1 ? "Terms & Conditions" : "Privacy Policy")
                            .font(.system(size: 14))
                            .padding()
                        Spacer()
                        Image("x")
                            .padding()
                            .onTapGesture {
                                popupVisible.toggle()
                            }
                    }
                    Divider()
                }
                .background(Color.white)
                .zIndex(20)
                .frame(width: UIScreen.main.bounds.width - 32)
                ScrollView{
                    
                    if popupGB == 1 {
                        VStack {
                            
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Agreement between User and www.e32tech.com By accessing or using www.e32tech.com website (the “Site”) is comprised of various web pages operated by e32 Technology Inc. (“Company”). This Site is offered to you conditioned on your acceptance without modification of the terms, conditions, and notices contained herein (the “Terms”). Your use of this Site constitutes your agreement to all such Terms.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Privacy")
                                    .font(.system(size: 14))
                                Text("Your use of this Site is subject to Company’s Privacy Policy. Please review our Privacy Policy, which also governs the Site and informs users of our data collection practices.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Electronic Communications")
                                    .font(.system(size: 14))
                                Text("Visiting this Site or sending emails to Company constitutes electronic communications. You consent to receive electronic communications and you agree that all agreements, notices, disclosures and other communications that we provide to you electronically, via email and on the Site, satisfy any legal requirement that such communications be in writing.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Children Under Thirteen")
                                    .font(.system(size: 14))
                                Text("Company does not knowingly collect, either online or offline, personal information from persons under the age of thirteen. If you are under 18, you may use this Site only with permission of a parent or guardian.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Links to Third Party Sites/Third Party Services")
                                    .font(.system(size: 14))
                                Text("This Site may contain links to other websites (“Linked Sites”). The Linked Sites are not under the control of the Company and the Company is not responsible for the contents of any Linked Site, including without limitation any link contained in a Linked Site, or any changes or updates to a Linked Site. The Company is providing these links to you only as a convenience, and the inclusion of any link does not imply endorsement by the Company of the site or any association with its operators. Certain services made available via this Site are delivered by third-party sites and organizations. By using any product, service, or functionality originating from the www.e32tech.com domain, you hereby acknowledge and consent that the Company may share such information and data with any third party with whom the Company has a contractual relationship to provide the requested product, service or functionality on behalf of this Site’s users and customers.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                
                            }
                            .padding()
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Text("No Unlawful or Prohibited Use/Intellectual Property")
                                    .font(.system(size: 14))
                                Text("You are granted a non-exclusive, non-transferable, revocable license to access and use this Site strictly in accordance with these Terms of Use. As a condition of your use of the Site, you warrant to the Company that you will not use the Site for any purpose that is unlawful or prohibited by these Terms. You may not use the Site in any manner which could damage, disable, overburden, or impair the Site or interfere with any other party’s use and enjoyment of the Site. You may not obtain or attempt to obtain any materials or information through any means not intentionally made available or provided for through the Site. All content, such as text, graphics, logos, images, as well as the compilation thereof, and any software used on the Site, is the property of the Company or its suppliers and protected by copyright and other laws that protect intellectual property and proprietary rights. You agree to observe and abide by all copyright and other proprietary notices, legends or other restrictions contained in any such content and will not make any changes thereto. You will not modify, publish, transmit, reverse engineer, participate in the transfer or sale, create derivative works, or in any way exploit any of the content, in whole or in part, found on the Site. The Company’s content is not for resale. Your use of the Site does not entitle you to make any unauthorized use of any protected content, and in particular, you will not delete or alter any proprietary rights or attribution notices in any content. You will use protected content solely for your personal use, and will make no other use of the content without the express written permission of the Company and the copyright owner. You agree that you do not acquire any ownership rights in any protected content. We do not grant you any licenses, express or implied, to the intellectual property of the Company or our licensors except as expressly authorized by these Terms.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("International Users")
                                    .font(.system(size: 14))
                                Text("This Site is controlled, operated, and administered by Company from our offices within the USA. If you access the Site from a location outside the USA, you are responsible for compliance with all local laws. You agree that you will not use the Company content accessed through www.e32tech.com in any country or in any manner prohibited by any applicable laws, restrictions, or regulations.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Indemnification")
                                    .font(.system(size: 14))
                                Text("You agree to indemnify, defend and hold harmless the Company, its officers, directors, employees, agents and third parties, for any losses, costs, liabilities and expenses (including reasonable attorney’s fees) relating to or arising out of your use of or inability to use the Site or services, any user postings made by you, your violation of any terms of this Agreement or your violation of any rights of a third party, or your violation of any applicable laws, rules or regulations. The Company reserves the right, at its own cost, to assume the exclusive defense and control of any matter otherwise subject to indemnification by you, in which event you will fully cooperate with the Company in asserting any available defenses.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Liability Disclaimer")
                                    .font(.system(size: 14))
                                Text("The information, software, products, and services included in or available through the site may include inaccuracies or typographical errors. changes are periodically added to the information herein. the company may make improvements and/or changes in the site at any time. the company makes no representations about the suitability, reliability, availability, timeliness, and accuracy of the information, software, products, services and related graphics contained on the site for any purpose. to the maximum extent permitted by applicable law, all such information, software, products, services and related graphics are provided “as is” without warranty or condition of any kind. the company hereby disclaims all warranties and conditions with regard to this information, software, products, services and related graphics, including all implied warranties or conditions of merchantability, fitness for a particular purpose, title and non-infringement. to the maximum extent permitted by applicable law, in no event shall the company be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use or performance of the site, with the delay or inability to use the site or related services, the provision of or failure to provide services, or for any information, software, products, services and related graphics obtained through the site, or otherwise arising out of the use of the site, whether based on contract, tort, negligence, strict liability or otherwise, even if e32 technology inc. or any of its suppliers has been advised of the possibility of damages. because some states/jurisdictions do not allow the exclusion or limitation of liability for consequential or incidental damages, the above limitation may not apply to you. if you are dissatisfied with any portion of the site, or with any of these terms of use, your sole and exclusive remedy is to discontinue using the site.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Termination/Access Restriction")
                                    .font(.system(size: 14))
                                Text("The Company reserves the right, in its sole discretion, to terminate your access to the Site and the related services or any portion thereof at any time, without notice. To the maximum extent permitted by law, this agreement is governed by the laws of the State of Delaware and you hereby consent to the exclusive jurisdiction and venue of courts in Delaware in all disputes arising out of or relating to the use of the Site. Use of the Site is unauthorized in any jurisdiction that does not give effect to all provisions of these Terms, including, without limitation, this section. You agree that no joint venture, partnership, employment, or agency relationship exists between you and the Company as a result of this agreement or use of the Site. Company’s performance of this agreement is subject to existing laws and legal process, and nothing contained in this agreement is in derogation of Company’s right to comply with governmental, court and law enforcement requests or requirements relating to your use of the Site or information provided to or gathered by the Company with respect to such use. If any part of this agreement is determined to be invalid or unenforceable pursuant to applicable law including, but not limited to, the warranty disclaimers and liability limitations set forth above, then the invalid or unenforceable provision will be deemed superseded by a valid, enforceable provision that most closely matches the intent of the original provision and the remainder of the agreement shall continue in effect. Unless otherwise specified herein, this agreement constitutes the entire agreement between the user and the Company with respect to the Site and it supersedes all prior or contemporaneous communications and proposals, whether electronic, oral or written, between the user and the Company with respect to the Site.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                            }
                            .padding()
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Changes to Terms")
                                    .font(.system(size: 14))
                                Text("The Company reserves the right, in its sole discretion, to change the Terms under which this Site is offered. The most current version of the Terms will supersede all previous versions.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Contact Us")
                                    .font(.system(size: 14))
                                Text("The Company welcomes your questions or comments regarding the Terms of Use. Our contact information is on the Contact Us page on the Site.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                            }
                            .padding()
                            
                        }
                        .background(Color.white)
                    } else if popupGB == 2 {
                        VStack {
                            
                            
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Protecting your private information is our priority. This Statement of Privacy applies to www.e32tech.com, and e32 Technology Inc. and governs data collection and usage. For the purposes of this Privacy Policy, unless otherwise noted, all references to e32 Technology Inc. (“Company”) include www.e32tech.com (“Site”). By using the Company website, you consent to the data practices described in this statement.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Collection of your Personal Information")
                                    .font(.system(size: 14))
                                Text("We do not collect any personal information about you unless you voluntarily provide it to us. However, you may be required to provide certain personal information to us when you elect to use certain products or services. These may include: (a) registering for an account; (b) entering a sweepstakes or contest sponsored by us or one of our partners; (c) signing up for special offers from selected third parties; (d) sending us an email message; (e) submitting your credit card or other payment information when ordering and purchasing products and services. To wit, we will use your information for, but not limited to, communicating with you in relation to services and/or products you have requested from us. We also may gather additional personal or nonpersonal information in the future.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Sharing Information with Third Parties")
                                    .font(.system(size: 14))
                                Text("The Company does not sell, rent or lease its customer lists to third parties.\n\nThe Company may, from time to time, contact you on behalf of external business partners about a particular offering that may be of interest to you. In those cases, your unique personally identifiable information (e-mail, name, address, telephone number) is transferred to the third party. The Company may share data with trusted partners to help perform statistical analysis, send you email or postal mail, provide customer support, or arrange for deliveries. All such third parties are prohibited from using your personal information except to provide these services to the Company, and they are required to maintain the confidentiality of your information.\n\nThe Company may disclose your personal information, without notice, if required to do so by law or in the good faith belief that such action is necessary to: (a) conform to the edicts of the law or comply with legal process served on the Company or the Site; (b) protect and defend the rights or property of the Company; and/or (c) act under exigent circumstances to protect the personal safety of users of the Company, or the public. Opt-Out of Disclosure of Personal Information to Third Parties In connection with any personal information we may disclose to a third party for a business purpose, you have the right to know:\n\nThe categories of personal information that we disclosed about you for a business purpose.\n\nYou have the right under certain privacy and data protection laws, as applicable, to opt-out of the disclosure of your personal information. If you exercise your right to opt-out of the disclosure of your personal information, we will refrain from disclosing your personal information, unless you subsequently provide express authorization for the disclosure of your personal information. To opt-out of the disclosure of your personal information, you may contact us. Our contact information is on the Contact Us page on the Site.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Tracking User Behavior")
                                    .font(.system(size: 14))
                                Text("The Company may keep track of the Site and pages our users visit within the Company, in order to determine what the Company services are the most popular. This data is used to deliver customized content and advertising within the Company to users whose behavior indicates that they are interested in a particular subject area.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Automatically Collected Information")
                                    .font(.system(size: 14))
                                Text("Information about your computer hardware and software may be automatically collected by the Company. This information can include your: IP address, browser type, domain names, access times and referring website addresses. This information is used for the operation of the service, to maintain quality of the service, and to provide general statistics regarding use of the Company Site.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                
                            }
                            .padding()
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Use of Cookies")
                                    .font(.system(size: 14))
                                Text("The Company Site may use “cookies” to help you personalize your online experience. A cookie is a text file that is placed on your hard disk by a web page server. Cookies cannot be used to run programs or deliver viruses to your computer. Cookies are uniquely assigned to you, and can only be read by a web server in the domain that issued the cookie to you. One of the primary purposes of cookies is to provide a convenience feature to save you time. The purpose of a cookie is to tell the web server that you have returned to a specific page. For example, if you personalize the Company pages, or register with the Company site or services, a cookie helps the Company to recall your specific information on subsequent visits. This simplifies the process of recording your personal information, such as billing addresses, shipping addresses, and so on. When you return to the same Company Site, the information you previously provided can be retrieved, so you can easily use the Company Site features that you customized. You have the ability to accept or decline cookies. Most web browsers automatically accept cookies, but you can usually modify your browser setting to decline cookies if you prefer. If you choose to decline cookies, you may not be able to fully experience the interactive features of the Company services or Site you visit.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Links")
                                    .font(.system(size: 14))
                                Text("This Site may contain links to other sites. Please be aware that we are not responsible for the content or privacy practices of such other sites. We encourage our users to be aware when they leave our Site and to read the privacy statements of any other site that collects personally identifiable information.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Right to Deletion")
                                    .font(.system(size: 14))
                                Text("Subject to certain exceptions set out below, on receipt of a verifiable request from you, we will:\nDelete your personal information from our records; and Direct any service providers to delete your personal information from their records. Please note that we may not be able to comply with requests to delete your personal information if it is necessary to:\n\nComplete the transaction for which the personal information was collected, fulfill the terms of a written warranty or product recall conducted in accordance with federal law, provide a good or service requested by you, or reasonably anticipated within the context of our ongoing business relationship with you, or otherwise perform a contract between you and us;\nDetect security incidents, protect against malicious, deceptive, fraudulent, or illegal activity; or prosecute those responsible for that activity;\nDebug to identify and repair errors that impair existing intended functionality;\nExercise free speech, ensure the right of another consumer to exercise his or her right of free speech, or exercise another right provided for by law;\nEngage in public or peer-reviewed scientific, historical, or statistical research in the public interest that adheres to all other applicable ethics and privacy laws, when our deletion of the information is likely to render impossible or seriously impair the achievement of such research, provided we have obtained your informed consent;\nEnable solely internal uses that are reasonably aligned with your expectations based on your relationship with us;\nComply with an existing legal obligation; or Otherwise use your personal information, internally, in a lawful manner that is compatible with the context in which you provided the information.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Children Under Thirteen")
                                    .font(.system(size: 14))
                                Text("The Company does not knowingly collect personally identifiable information from children under the age of thirteen. If you are under the age of thirteen, you must ask your parent or guardian for permission to use this website. Opt-Out & Unsubscribe from Third Party Communications We respect your privacy and give you an opportunity to opt-out of receiving announcements of certain information. Users may opt-out of receiving any or all communications from third-party partners of the Company by contacting us. Our contact information is on the Contact Us page on the Site.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("E-mail Communications")
                                    .font(.system(size: 14))
                                Text("From time to time, the Company may contact you via email for the purpose of providing announcements, promotional offers, alerts, confirmations, surveys, and/or other general communication.\n\nIf you would like to stop receiving marketing or promotional communications via email from the Company, you may opt out of such communications by contacting us. Our contact information is on the Contact Us page on the Site.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                            }
                            .padding()
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Changes to this Statement")
                                    .font(.system(size: 14))
                                Text("The Company reserves the right to change, modify, add, or remove portions of this Privacy Policy from time to time. We encourage users to review the Privacy Policy periodically. Your continued use of the Site available after such modifications will constitute your: (a) acknowledgment of the modified Privacy Policy; and (b) agreement to abide and be bound by that Policy.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                                    .padding(.bottom)
                                
                                Text("Contact Information")
                                    .font(.system(size: 14))
                                Text("The Company welcomes your questions or comments regarding the Terms of Use. Our contact information is on the Contact Us page on the Site.")
                                    .foregroundColor(Color(hex: 0xB5B5B6))
                            }
                            .padding()
                            
                        }
                        .background(Color.white)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height / 1.5)
            }
            .background(Color.white)
            .cornerRadius(10)
        }
        
    }
}


//
//  SwiftConstants.swift
//  Bamboo-Pro
//
//  Created by Deepak on 7/4/17.
//  Copyright © 2017 Click-Labs. All rights reserved.
//

import Foundation
import UIKit

// Size
let kScreenHeight = UIScreen.main.bounds.height
let kScreenWidth = UIScreen.main.bounds.width

let kNavigationBarHeight = 64

let kUsMobileNumberFormatLength = 16
let kUsMobileNumberLength = 10
let kMaxMobileLengthForOtherCountries = 15
let kMinMobileLengthForOtherCountries = 9


let kZipCodeLength = 5
let kPostalCodeLength = 10
let kMobileCodeLength = 6

let kFirstLastNameMinLength = 2
let kFirstLastNameMaxLength = 30
let kStreetLength = 100
let kCityLength = 30
let kStateLength = 30
let kRelationshipLength = 30
let kPasswordMinLength = 10



//1. Signup Screen
//2. Enter your name
//3. Enter your address
//4. Emergency Contact number
//5. Your phone number
//6. With OTP
//7. Verify Email
//8. Profile Privacy Settings
//9. Add profile picture
//10. Your profile description
//11. What you like doing best
//12. Photos of your work
//13. Select your role
//14. Add your skills
//15. Add your hourly rate
//16. Backgroud check screen1
//17 Screen 2
//18. Disclosure
//19. Authorization
let kTotalNumberOfScreens = 19 //
let kTotakNumberOfScreensForFacebook = 18
let kTotalNumberOfFCRAScreens = 10 //


let kCountryCodeForUS = "+1"
let kCountryNameForUS = "US"

let kStringCharactersSet = "abcdefghijklmnopqrstuvqxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let kNumericCharacterSet = "0123456789"

// ---- Segue Identifier
let kIntroToFacebookSignUpSegue =  "IntroToFacebookSignUpSegue"


let kDarkGrayColor = "#979797"
let kGreenColor = "#68B513"
let kWhiteColor = "#FFFFFF"
let kLightGrayColor = "#CDCCCC"
let kBlackColor = "#373737"
let kOrangeColor = "#D37014"
let kYelloColor = "#FFC200"
let kRedColor = "#FF0000"
let kOffWhiteColor = "#F6F6F6"
let kBlueColor = "#3B5998"

// ----- Constant Keys

let kFbFirstName = "first_name"
let kFbLastName = "last_name"
let kFbName = "name"
let kFbEmail = "email"
let kFbPicture = "picture"
let kData = "data"
let kFbProfilePictureUrl = "url"
let kFbId = "id"
let kFacebookToken = "facebookToken"
let kContactDetailLocalData = "contactDetailLocalData"
let kEmergencyContactLocalData = "emergencyContactLocalData"
let kPhoneVerificationLocalData = "phoneVerificationLocalData"
let kFormattedMobileNumber = "phoneNumberFormatted"

let kGallery = "Gallery"
let kCamera = "Camera"
let kAttachment = "Attachment"

// ------ API Name
let kUserLoginAPI = "user/login"
let kUserSignUpAPI =  "serviceProvider/register"
let kUpdateUserAPI = "serviceProvider/updateProfile"
let kLoginByAccessTokenAPI = "user/accessTokenLogin"
let kAddPhoneNumberAPI = "user/addPhoneNumber"
let kVerifyMobileOtpApi = "user/verifyMobileOTP"
let kResendOtpCode = "user/resendOTP"
let kUserLogOutAPI = "user/logout"
let kChangeEmailAPI = "user/changeEmail"
let kResendEmailVerificationAPI = "user/resendEmailVerificationLink"
let kUpdateOnboardingStateAPI = "user/updateOnboardingState"
let kResetPasswordAPI = "user/getResetPasswordToken"
let kUploadUserIamgeAPI = "serviceProvider/uploadImage"
let kGetRoll = "serviceProvider/roles"
let kSkills = "serviceProvider/skills"
let kDeleteImage = "serviceProvider/deleteImage"
let kUpdateRoleAndSkills = "serviceProvider/updateRoleAndSkills"
let kBackgroundSubmitForm = "serviceProvider/backgroundCheck/submitForm"
let kUploadLicenseImage = "serviceProvider/uploadImageOnly"

// ----- API Keys Constant

let kEmail = "email"
let kPassword = "password"
let kFacebookId = "facebookID"
let kUserRole = "role"
let kAppVersionKey = "appVersion"
let kDeviceNameKey = "deviceName"
let kDeviceTokenKey = "deviceToken"
let kDeviceTypeKey = "deviceType"
let kContentLanguage = "content-language"
let kUtcOffSetInMins = "utcOffsetInMins"
let kAuthorizationKey = "authorization"
let kPhoneKey = "phone"
let kOtpCodeKey = "OTPCode"
let kSkipEmailVerificationKey = "skipEmailVerification"
let kIsWhatHappensNext = "whatHappensNext"
let kEmergencyCountryCodeKey = "emergencyContactCountryCode"
let kEmergencyFirstNameKey = "emergencyContactFirstName"
let kEmergencyLastNameKey = "emergencyContactLastName"
let kEmergencyPhoneNumberKey = "emergencyContactPhone"
let kEmergencyRelationshipKey = "emergencyContactRelationship"
let kCountryFlag = "countryFlag"
let kIsProfilePublic =  "profilePublic"
let kAllowNotification = "allowNotification"
let kImageType = "imageType"
let kSkipProfileDescription = "skipProfileDescription"
let kWhatYouLikeDoingBest = "whatYouLikeDoingBest"
let kIsSelectedRoll = "isSelectedRoll"
let kUserPortfolioPhoto = "userPortfolioPhoto"

// ----- API Response Keys

let kMessage = "message"

// Emaregecy Contacts
let kEmergencyContact =  "emergencyContact"
let kEmergencyCountryCode = "countryCode"
let kEmergencyFirstName = "firstName"
let kEmergencyLastName = "lastName"
let kEmergencyPhoneNumber = "phone"
let kEmergencyRelationship = "relationship"
let kEmergencyCountryFlag = "emergencyContactCountryFlag"



let kState = "state"
let kAddress = "address"
let kStreetAddress = "streetAddress"
let kZipCode = "zipCode"
let kCountry = "country"
let kCity = "city"
let kLatitude = "latitude"
let kLongitude = "longitude"
let kIsBlocked = "isBlocked"
let kUserAccessToken = "token"
let kUserLastName = "lastName"
let kUserFirstName = "firstName"
let kIsEmailVerified = "isEmailVerified"
let kProfilePicUrl = "profilePicURL"
let kProfilePicOriginal = "original"
let kProfilePicThumb = "thumb"
let kCountryCode = "countryCode"
let kIsOtpVerified = "isOTPVerified"
let kIsAdminVerified = "isAdminVerified"
let kSocialAccounts = "socialAccounts"
let kSkipEmailVerification =  "skipEmailVerification"
let kProfilePicConfirmed = "profilePicConfirmed"



// What happen next:
let kPersonalInformationStatus = "personalInformationStatus"
let kBuildYourProfileStatus = "buildYourProfileStatus"
let kChooseYourExpertiseStatus = "chooseYourExpertiseStatus"
let kIdentityCheckStatus = "identityCheckStatus"
let kOptionalInfoStatus = "optionalInfoStatus"

//User Profile
let kProfilePicSaved = "profilePicSaved"
let kOriginalProfilePicURL = "original"
let kThumbProfilePicURL = "thumb"
let kProfileDescription = "profileDescription"



// ------ Key Values
let kDeviceTypeValue = "IOS"
let kContentLanguageValue = "en"
let kUserRoleValue = "serviceProvider"
let kAppVersionValue = "1.0"




//---- Controller Segue Identifier
let kSignUpToSignUpUserNameSegue = "SignUpToSignUpUserNameSegue"
let kSignUpUserNameToAddressSegue = "SignUpUserNameToAddressSegue"
let kAddressToEmergencyContactSegue = "AddressToEmergencyContactSegue"
let kEmergencyContactToPhoneVerifySegue = "EmergencyContactToPhoneVerificationSegue"
let kFacebookSignUpToAddressScreen = "facebookSignUpToAddressScreen"
let kPhoneVerificationToOtpVerificationSegue = "PhoneVerificationToOtpVerificationSegue"
let kOtpVerifyScreenToConfirmScreenSegue  = "OtpVerificationScreenToPhoneConfirmationScreenSegue"
let kPhoneVerificationToConfirmScreenSegue = "PhoneVerificationToConfirmScreenSegue"
let kEmailSentToAppleNotificationSegue = "EmailSentToAppleNotificationSegue"
let kAppleNotificationToWhatHappensSegue = "AppleNotificationToWhatHappensSegue"
let kWhatHappensToProfilePrivacySegue = "WhatHappensToProfilePrivacySegue"
let kResetPasswordToPasswordLinkSegue = "ResetPasswordToPasswordLinkSegue"
let kProfileSettingToAddPictureSegue = "ProfileSettingToAddPictureSegue"
let kAddPictureToCameraPermissionSegue = "AddPictureToCameraPermissionSegue"
let kEmailSentToWhatHappensSegue = "EmailSentToWhatHappensSegue"

//----- Default Country Image

let kDefaultCountryImage = UIImage(named: "US")



//----- US State Data
let kStateListForUS = [ "Alabama", "Alaska", "American Samoa",
                       "Arizona",
                       "Arkansas",
                       "California",
                       "Colorado",
    "Connecticut",
    "Delaware",
    "District Of Columbia",
    "Federated States Of Micronesia",
    "Florida",
    "Georgia",
    "Guam",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Marshall Islands",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi",
    "Missouri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "New York",
    "North Carolina",
    "North Dakota",
    "Northern Mariana Islands",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Palau",
    "Pennsylvania",
    "Puerto Rico",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Vermont",
    "Virgin Islands",
    "Virginia",
    "Washington",
    "West Virginia",
    "Wisconsin",
"Wyomi" ]

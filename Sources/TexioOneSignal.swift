//
//  TexioOneSignal.swift
//  TexioSwift
//
//  Created by Shayan on 5/30/17.
//
//  This is a swift wrapper for OneSignal's notification API
//  for when you want your server to programmatically send
//  notifications to your users. You may use one of these three
//  methods to create notifications using this wrapper: Segment,
//  Filter, or by Device ID
//
//  You can learn more about this api and OneSignal's notification
//  API from their documentations :
//  https://documentation.onesignal.com/reference
//

import Foundation

class TexioNotification {
    
    private let httpUrl = "https://onesignal.com/api/v1/notifications"
    public static var Credentials : (API_KEY : String, APP_ID : String) = ("","")
    
    typealias USD = Double
    
    /// list of the parameters for each request
    var parameters : [String : Any] = [:]
    
    fileprivate var filters : [[String : Any]] = [] {
        didSet { parameters["filters"] = filters }
    }
    
    typealias languageCode = String
    
    private var headings : [languageCode : String] = [:] {
        didSet { parameters["headings"] = headings }
    }

    private var subtitle : [languageCode : String] = [:] {
        didSet { parameters["subtitle"] = subtitle }
    }
    
    private var content : [languageCode : String] = [:] {
        didSet { parameters["contents"] = content }
    }
        
    /// Sending true wakes your app from background to run custom native code (Apple interprets this as content-available=1)
    /// * platform : ios
    var content_available : Bool = true {
        didSet { parameters["content_available"] = content_available }
    }
    
    /// Use a template you setup on our dashboard. You can override the template values by sending other parameters with the request. The template_id is the UUID found in the URL when viewing a template on our dashboard.
    /// * platform : all
    var template_id : String? {
        didSet { parameters["template_id"] = template_id }
    }
    
    /// Sending true allows you to change the notification content in your app before it is displayed. Triggers didReceive(_:withContentHandler:) on your
    /// * platfrom : ios 10+
    var mutable_content : Bool = false {
        didSet { parameters["mutable_content"] = mutable_content }
    }
    
    
    /// The notification's title, a map of language codes to text for each language. Each hash must have a language code string for a key, mapped to the localized text you would like users to receive for that language. A default title may be displayed if a title is not provided.
    /// * platform : all
    /// * example : {"en": "English Title", "es": "Spanish Title"}
    /// - parameter lc : Language code for this heading
    /// - parameter text : the text of this heading
    func addHeading(_ lc : LanguageCode, text : String) {
        self.headings[lc.rawValue] = text
    }
    
    /// The notification's title, a map of language codes to text for each language. Each hash must have a language code string for a key, mapped to the localized text you would like users to receive for that language. A default title may be displayed if a title is not provided.
    /// * platform : all
    /// * example : {"en": "English Title", "es": "Spanish Title"}
    /// - parameter lc : Language code for this heading
    /// - parameter text : the text of this heading
    func addHeading(_ lc : LanguageCode, text : @escaping () -> String) {
        self.addHeading(lc, text: text())
    }
    
    /// The notification's subtitle, a map of language codes to text for each language. Each hash must have a language code string for a key, mapped to the localized text you would like users to receive for that language. A default title may be displayed if a title is not provided.
    /// * platform : ios 10+
    /// * example : {"en": "English Subtitle", "es": "Spanish Subtitle"}
    /// - parameter lc : Language code for this subtitle
    /// - parameter text : the text of this subtitle
    func addSubtitle(_ lc : LanguageCode, text : String) {
        self.subtitle[lc.rawValue] = text
    }
    
    /// The notification's subtitle, a map of language codes to text for each language. Each hash must have a language code string for a key, mapped to the localized text you would like users to receive for that language. A default title may be displayed if a title is not provided.
    /// * platform : ios 10+
    /// * example : {"en": "English Subtitle", "es": "Spanish Subtitle"}
    /// - parameter lc : Language code for this subtitle
    /// - parameter text : the text of this subtitle
    func addSubtitle(_ lc : LanguageCode, text : @escaping () -> String) {
        self.addSubtitle(lc, text: text())
    }
    
    /// The notification's content (excluding the title), a map of language codes to text for each language.
    /// * platform : all
    /// * example : {"en": "English Message", "es": "Spanish Message"}
    /// - parameter lc : Language code for this content
    /// - parameter text : the text of this content
    func addContent(_ lc : LanguageCode, text : String) {
        self.content[lc.rawValue] = text
    }
    
    /// The notification's content (excluding the title), a map of language codes to text for each language.
    /// * platform : all
    /// * example : {"en": "English Message", "es": "Spanish Message"}
    /// - parameter lc : Language code for this content
    /// - parameter text : the text of this content
    func addContent(_ lc : LanguageCode, text : @escaping () -> String) {
        self.addContent(lc, text: text())
    }
    
    /// Schedule notification for future delivery.
    /// Examples: All examples are the exact same date & time.
    /// - "Thu Sep 24 2015 14:00:00 GMT-0700 (PDT)"
    /// - "September 24th 2015, 2:00:00 pm UTC-07:00"
    /// - "2015-09-24 14:00:00 GMT-0700"
    /// - "Sept 24 2015 14:00:00 GMT-0700"
    /// -  "Thu Sep 24 2015 14:00:00 GMT-0700 (Pacific Daylight Time)"
    func send_after(_ date : String) {
        parameters["send_after"] = date
    }
    
    enum delayed_options : String {
        
        /// Deliver at a specific time-of-day in each users own timezone
        case timezone = "timezone"
        
        /// Same as Intelligent Delivery. (Deliver at the same time of day as each user last used your app)
        case lastActive = "last-active"
        
        /// If send_after is used, this takes effect after the send_after time has elapsed.
        case sendAfter = "send-after"
    }
    
    /// Possible values are:
    /// - timezone (Deliver at a specific time-of-day in each users own timezone)
    /// - last-active Same as Intelligent Delivery. (Deliver at the same time of day as each user last used your app).
    /// - If send_after is used, this takes effect after the send_after time has elapsed.
    func delayed_option(_ value : delayed_options) {
        parameters["delayed_option"] = value.rawValue
    }
    
    /// Use with delayed_option=timezone
    /// parameter - time : Example: "9:00AM"
    func delivery_time_of_day(_ time : String) {
        parameters["delivery_time_of_day"] = time
    }
    
    /// start a new segment notification
    /// - return a new instance of TexioSpecificNotification
    static func SegmentNotification() -> TexioSegmentNotification {
        return TexioSegmentNotification()
    }
    
    /// start a new filtered notification
    /// - return a new instance of TexioFiltersNotifications
    static func FileteredNotification() -> TexioFiltersNotifications {
        return TexioFiltersNotifications()
    }
    
    /// start a new specific notification
    /// - return a new instance of TexioSpecificNotification
    static func SpecificNotificaiton() -> TexioSpecificNotification {
        return TexioSpecificNotification()
    }
    
    func send() {
        
        
       
        
        let httpHeader = ["Content-Type" : "application/json",
                          "charset" : "utf-8",
                          "Authorization" : "Basic \(TexioNotification.Credentials.API_KEY)"]
        
        let app_id = TexioNotification.Credentials.APP_ID
        
        parameters["app_id"] = app_id
        
        TexioHTTP.makeRequest(httpUrl, parameters, header: httpHeader, .POST)
        
    }
    
    /// The following are languages supported by OneSignal
    enum LanguageCode : String {
        case English            = "en"
        case Arabic             = "ar"
        case Catalan            = "ca"
        case ChineseSimplified  = "zh-Hans"
        case ChineseTraditional = "zh-Hant"
        case Croatian           = "hr"
        case Czech              = "cs"
        case Danish             = "da"
        case Dutch              = "nl"
        case Estonian           = "et"
        case Finnish            = "fi"
        case French             = "fr"
        case Georgian           = "ka"
        case Bulgarian          = "bg"
        case German             = "de"
        case Greek              = "el"
        case Hindi              = "hi"
        case Hebrew             = "he"
        case Hungarian          = "hu"
        case Indonesian         = "id"
        case Italian            = "it"
        case Japanese           = "ja"
        case Korean             = "ko"
        case Latvian            = "lv"
        case Lithuanian         = "lt"
        case Malay              = "ms"
        case Norwegian          = "nb"
        case Persian            = "fa"
        case Polish             = "pl"
        case Portuguese         = "pt"
        case Romanian           = "ro"
        case Russian            = "ru"
        case Serbian            = "sr"
        case Slovak             = "sk"
        case Spanish            = "es"
        case Swedish            = "sv"
        case Thai               = "th"
        case Turkish            = "tr"
        case Ukrainian          = "uk"
        case Vietnamese         = "vi"
        
    }
    
}

class TexioSegmentNotification : TexioNotification {
    
    enum Preset {
        case all
        case active
        case inActive
        
        var string : String {
            switch self {
            case .active : return "Active Users"
            case .inActive : return "Inactive Users"
            case .all : return "All"
            }
        }
    }
    
    
    /// choose from preset segments
    /// - parameter value : a list of preset segments
    func preSet(_ value : Preset) {
        include([value.string])
    }
    
    /// The segment names you want to target. Users in these segments will receive a notification. This targeting parameter is only compatible with excluded_segments
    /// - parameter included_users : the iuncluded segments
    func include(_ included_users : [String]) {
        self.parameters["included_segments"] = included_users
    }
    
    /// Segment that will be excluded when sending. Users in these segments will not receive a notification, even if they were included in included_segments. This targeting parameter is only compatible with included_segments.
    /// - parameter excluded_users : the excluded segments
    func exclude(_ excluded_users : [String]) {
        self.parameters["excluded_segments"] = excluded_users
    }
    
}

class TexioFiltersNotifications : TexioNotification {
    
    /// required relations
    enum Relations {
        case greater
        case smaller
        case equal
        case notEqual
        case exists
        case notExists
        
        var sign : String {
            switch self {
            case .equal: return "="
            case .notEqual: return "!="
            case .greater: return ">"
            case .smaller: return "<"
            case .exists : return "exists"
            case .notExists : return "not_exists"
            }
        }
        
    }
    
    /// Filer users based on their last session
    /// - parameter relation : ">" or "<"
    /// - parameter hoursAgo : number of hours before or after the users last session. Example: "1.1"
    func last_session(relation : Relations, hoursAgo : Double) {
        self.filters.append([
            "last_session" : [
                "relation"  : relation.sign,
                "hours_ago" : hoursAgo
                ]
            ])
    }
    
    /// Filer users based on their first session
    /// - parameter relation : ">" or "<"
    /// - parameter hoursAgo : number of hours before or after the users first session. Example: "1.1"
    func first_session(relation : Relations, hoursAgo : Double) {
        self.filters.append([
            "first_session" : [
                "relation"  : relation.sign,
                "hours_ago" : hoursAgo
                ]
            ])
    }
    
    /// Filer users based on the number of their sessions
    /// - parameter relation : ">", "<", "=" or "!="
    /// - parameter hoursAgo : number sessions. Example: "1"
    func session_count(relation : Relations, value : Int){
        self.filters.append([
            "session_count" : [
                "relation" : relation.sign,
                 "value" : value
                ]
            ])
    }
    
    /// Filter users based on the seconds the user has been in the app
    /// - parameter relation : ">" or "<"
    /// - parameter value : Time in seconds the user has been in your app. Example: "3600"
    func session_time(relation : Relations, value : Int) {
        self.filters.append([
            "session_time" : [
                "relation" : relation.sign,
                "value" : value
                ]
            ])
    }
    
    /// Filter users based on the amount spent in the app
    /// - parameter relation : ">", "<", or "="
    /// - parameter value : Amount in USD a user has spent on IAP (In App Purchases). Example: "0.99"
    func amount_spent(relation : Relations, value : USD){
        self.filters.append([
            "amount_spent" : [
                "relation" : relation.sign,
                "value" : value
                ]
            ])
    }
    
    /// Filter users based on the amount spent in the app
    /// - parameter relation : ">", "<", or "="
    /// - parameter key : SKU purchased in your app as an IAP (In App Purchases). Example: "com.domain.100coinpack"
    /// - parameter value : value of SKU to compare to. Example: "0.99"
    func bought_sku(relation : Relations, key : String, value : String){
        self.filters.append([
            "bought_sku" : [
                "relation" : relation.sign,
                "key" : key,
                "value" : value
                ]
            ])
    }
    
    /// Filter users based on the tags
    /// - parameter relation : ">", "<", "=", "!=", "exists" or "not_exists"
    /// - parameter key : Tag key to compare.
    /// - parameter value : Tag value to compare. Not required for "exists" or "not_exists"
    func tag(relation : Relations, key : String, value : String){
        self.filters.append([
            "tag" : [
                "relation" : relation.sign,
                "key" : key,
                "value" : value
                ]
            ])
    }
    
    /// Filter users based on their language code
    /// - parameter relation : "=" or "!="
    /// - parameter value : 2 character language code. Example: "en"
    func language(relation : Relations, value : LanguageCode) {
        self.filters.append([
            "language" : [
                "relation" : relation.sign,
                "value" : value.rawValue
                ]
            ])
    }
    
    /// Filter users based on their app version
    /// - parameter relation : ">", "<", "=" or "!="
    /// - parameter value : app version. Example: "1.0.0"
    func app_version(relation : Relations, value : String){
        self.filters.append([
            "app_version" : [
                "relation" : relation.sign,
                "value" : value
                ]
            ])
    }
    
    /// Filter users based on their location
    /// - parameter radius : radius in meters
    /// - parameter lat : latitude
    /// - parameter lon : longitude
    func location(radius : Double, lat : Double, lon : Double){
        self.filters.append([
            "location" : [
                "radius" : radius,
                "lat" : lat,
                "lon" : lon
                ]
            ])
    }
    
    /// Filter users based on their email
    /// - parameter email : email address
    func email(email : String) {
        self.filters.append([
            "email" : [
               "email" : email
               ]
            ])
    }
    
    enum Operations {
        case or; case and
        var string : String {
            switch self {
            case .and : return "AND"
            case .or : return "OR"
            }}}
    
    /// Filter entries use AND by default; insert {"operator": "OR"} between entries to OR the parameters together.
    func operation(_ operaton : Operations) {
        self.filters.append([
            "operator" : operaton.string
            ])
    }
    
}

class TexioSpecificNotification : TexioNotification {
    
    /// Specific players to send your notification to.
    var users : [String]?
    
    override func send() {
        
        if users == nil { users = [] }
        self.filters.append([
            "include_player_ids" : users!
            ])
        super.send()
    }
    
}


























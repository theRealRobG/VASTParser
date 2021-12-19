import XCTest
@testable import VASTParser

let inline = """
        <InLine>
            <AdSystem>FreeWheel</AdSystem>
            <AdTitle>Peacock Test - EL_CI</AdTitle>
            <Error>
                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&iw=&uxnw=171224&uxss=sg791194&uxct=4&et=e&cn=%5BERRORCODE%5D]]></Error>
            <Impression id='FWi_38604759.0'>
                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=defaultImpression&et=i&_cc=38604759,24989088,,,1585129517,1&tpos=354&iw=&uxnw=171224&uxss=sg791194&uxct=4&metr=1031&init=1&asid=238460940&ssid=15339143&vcid2=12345678-90ab-cdef-ghij-klmnopqrstuvwxyz_9a64df39e6d6b84232c69f7265888b76&pingids=1089]]></Impression>
            <Impression id='FWi_38604759.0.1'>
                <![CDATA[https://sb.scorecardresearch.com/p?c1=3&c2=28881558&c3=38604755&c4=6294735&c5=38604758&c12=&ns_ad_vevent=v_start&ns_ad_pcd=15&ns__t=269544036&ns__p=269544036&ns_st_pr=USA%3A%20Pearson%3A%20Full%20Episode&ns_st_ge=&ns_st_pu=NBCU%3A%20Peacock%3A%20On%20Domain%3A%20Mobile%3A%20App%3A%20On%20Demand&ns_st_ep=USA%3A%20The%20Rival%5E&ns_st_ct=NBCU%3A%20Peacock%3A%20On%20Domain%3A%20Mobile%3A%20Android%3A%20App%3A%20On%20Demand&cs_vp_sv=1&rn=269544036&ccr=1&ccrsdk=1&c6=midroll&ns_ap_device=&ns_ap_pn=]]></Impression>
        </InLine>
"""

final class VASTParserTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let test = Test(parsingBehaviour: ParsingBehaviour(strictness: .loose))
        do {
            let inLine = try test.parse(xmlString: inline)
            print(inLine)
        } catch {
            let nsError = error as NSError
            print(nsError.code, nsError.localizedDescription, nsError.userInfo)
        }
    }
}

import Foundation

let vast = """
<VAST version='3.0' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'
      xsi:noNamespaceSchemaLocation='vast.xsd'>
    <Ad id='38604759.140227733096960' sequence='1'>
        <InLine>
            <AdSystem>FreeWheel</AdSystem>
            <AdTitle>Peacock Test - EL_CI</AdTitle>
            <Error>
                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&iw=&uxnw=171224&uxss=sg791194&uxct=4&et=e&cn=%5BERRORCODE%5D]]></Error>
            <Impression id='FWi_38604759.0'>
                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=defaultImpression&et=i&_cc=38604759,24989088,,,1585129517,1&tpos=354&iw=&uxnw=171224&uxss=sg791194&uxct=4&metr=1031&init=1&asid=238460940&ssid=15339143&vcid2=12345678-90ab-cdef-ghij-klmnopqrstuvwxyz_9a64df39e6d6b84232c69f7265888b76&pingids=1089]]></Impression>
            <Impression id='FWi_38604759.0.1'>
                <![CDATA[https://sb.scorecardresearch.com/p?c1=3&c2=28881558&c3=38604755&c4=6294735&c5=38604758&c12=&ns_ad_vevent=v_start&ns_ad_pcd=15&ns__t=269544036&ns__p=269544036&ns_st_pr=USA%3A%20Pearson%3A%20Full%20Episode&ns_st_ge=&ns_st_pu=NBCU%3A%20Peacock%3A%20On%20Domain%3A%20Mobile%3A%20App%3A%20On%20Demand&ns_st_ep=USA%3A%20The%20Rival%5E&ns_st_ct=NBCU%3A%20Peacock%3A%20On%20Domain%3A%20Mobile%3A%20Android%3A%20App%3A%20On%20Demand&cs_vp_sv=1&rn=269544036&ccr=1&ccrsdk=1&c6=midroll&ns_ap_device=&ns_ap_pn=]]></Impression>
            <Creatives>
                <Creative AdID='38604759' id='6294735'>
                    <Linear>
                        <Duration>00:00:15</Duration>
                        <TrackingEvents>
                            <Tracking event='complete'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=complete&et=i&_cc=&tpos=354&init=1&iw=&uxnw=171224&uxss=sg791194&uxct=4&metr=1031]]></Tracking>
                            <Tracking event='firstQuartile'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=firstQuartile&et=i&_cc=&tpos=354&init=1&iw=&uxnw=171224&uxss=sg791194&uxct=4&metr=1031]]></Tracking>
                            <Tracking event='midpoint'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=midPoint&et=i&_cc=&tpos=354&init=1&iw=&uxnw=171224&uxss=sg791194&uxct=4&metr=1031]]></Tracking>
                            <Tracking event='thirdQuartile'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=thirdQuartile&et=i&_cc=&tpos=354&init=1&iw=&uxnw=171224&uxss=sg791194&uxct=4&metr=1031]]></Tracking>
                            <Tracking event='mute'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=_mute&et=s&_cc=&tpos=354]]></Tracking>
                            <Tracking event='unmute'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=_un-mute&et=s&_cc=&tpos=354]]></Tracking>
                            <Tracking event='collapse'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=_collapse&et=s&_cc=&tpos=354]]></Tracking>
                            <Tracking event='expand'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=_expand&et=s&_cc=&tpos=354]]></Tracking>
                            <Tracking event='pause'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=_pause&et=s&_cc=&tpos=354]]></Tracking>
                            <Tracking event='resume'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=_resume&et=s&_cc=&tpos=354]]></Tracking>
                            <Tracking event='rewind'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=_rewind&et=s&_cc=&tpos=354]]></Tracking>
                            <Tracking event='acceptInvitation'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=_accept-invitation&et=s&_cc=&tpos=354]]></Tracking>
                            <Tracking event='close'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=_close&et=s&_cc=&tpos=354]]></Tracking>
                        </TrackingEvents>
                        <VideoClicks>
                            <ClickTracking id='FWc_38604759.0'>
                                <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&auid=&cn=defaultClick&et=c&_cc=&tpos=354]]></ClickTracking>
                        </VideoClicks>
                        <MediaFiles>
                            <MediaFile delivery='streaming' height='0' id='24989088'
                                       type='application/x-mpegURL' width='0'>
                                <![CDATA[https://mssl.fwmrm.net/m/1/171224/79/6294735/US049572H_ENT_MEZZ_HULU_1836859_626/US049572H_ENT_MEZZ_HULU_1836859_626.m3u8]]></MediaFile>
                        </MediaFiles>
                    </Linear>
                </Creative>
            </Creatives>
            <Extensions>
                <Extension type='FreeWheel'>
                    <CreativeParameters>
                        <CreativeParameter creativeId='6294735' name='Conviva Ad Insights'
                                           type='Linear'>
                            <![CDATA[{   "id": "38605319",   "position": "midroll",   "mediaFileApiFramework": "",   "sequence": "1",   "creativeId": "6293946",   "creativeName": "030G112NFL1110H",   "breakId": "midroll_558.0.812272640",   "advertiser": "Craig Test",   "advertiserCategory": "",   "advertiserId": "663501",   "campaignName": "Peacock Test - A",   "sitesection": "NBCU: Peacock: On Domain: Mobile: Android: App: On Demand",   "vcid2": "",   "prof": "169843:playmaker_30fps_cmaf_web" }]]></CreativeParameter>
                        <CreativeParameter creativeId='6294735' name='_fw_advertiser_name'
                                           type='Linear'><![CDATA[Craig Test]]></CreativeParameter>
                        <CreativeParameter creativeId='6294735' name='ccr_measurement' type='Linear'>
                            <![CDATA[https://sb.scorecardresearch.com/p?c1=3&c2=28881558&c3=38604755&c4=6294735&c5=38604758&c12=&ns_ad_vevent=v_start&ns_ad_pcd=15&ns__t=269544036&ns__p=269544036&ns_st_pr=USA: Pearson: Full Episode&ns_st_ge=&ns_st_pu=NBCU: Peacock: On Domain: Mobile: App: On Demand&ns_st_ep=USA: The Rival^&ns_st_ct=NBCU: Peacock: On Domain: Mobile: Android: App: On Demand&cs_vp_sv=1&rn=269544036&ccr=1&ccrsdk=1&c6=midroll&ns_ap_device=&ns_ap_pn=]]></CreativeParameter>
                        <CreativeParameter creativeId='6294735' name='creativeApi_apiFramework'
                                           type='Linear'><![CDATA[]]></CreativeParameter>
                        <CreativeParameter creativeId='6294735' name='hulu_campaign_id' type='Linear'>
                            <![CDATA[38604755]]></CreativeParameter>
                        <CreativeParameter creativeId='6294735' name='hulu_ccr' type='Linear'>
                            <![CDATA[campaignName=Peacock%20Test%20-%20EL_CI;campaignId=38604755;placementName=Peacock%20Test%20-%20EL_CI;placementId=38604758;creativeName=US049572H;creativeId=6294735;networkId=]]></CreativeParameter>
                        <CreativeParameter creativeId='6294735' name='industry' type='Linear'>
                            <![CDATA[Painkillers Prescription ]]></CreativeParameter>
                        <CreativeParameter creativeId='6294735' name='moat' type='Linear'>
                            <![CDATA[171224;171224;663501;38604755;38604756;;38604758;59101;g17399516;g788030;15339143;238460940;PCK_USA_ANV_4015036;6294735;24989088;15;midroll;;169843:playmaker_30fps_cmaf_web;cpx-non;1585129517131554013]]></CreativeParameter>
                        <CreativeParameter creativeId='6294735' name='moat_callback' type='Linear'>
                            <![CDATA[https://29773.v.fwmrm.net/ad/l/1?s=a163&n=171224%3B171224&t=1585129517131554013&f=&r=171224&adid=38604759&reid=24989088&arid=0&iw=&uxnw=171224&uxss=sg791194&uxct=4&absid=&trigid=&et=i&cn=concreteEvent]]></CreativeParameter>
                        <CreativeParameter creativeId='6294735' name='moat_on_youtube' type='Linear'>
                            <![CDATA[171224;171224;663501;38604755;38604756;;38604758;59101;g17399516;g788030;15339143;238460940;PCK_USA_ANV_4015036;6294735;24989088;15;midroll;;169843:playmaker_30fps_cmaf_web;cpx-non;1585129517131554013]]></CreativeParameter>
                    </CreativeParameters>
                </Extension>
            </Extensions>
        </InLine>
    </Ad>
</VAST>
"""

class VASTParser {
    func parse(data: Data) {
        print("STARTING PARSE")
        VASTParsingContext.parse(data: data) { _ in }
        print("FINISHED PARSE")
    }
    
    func parse(xmlString: String) {
        print("STARTING PARSE")
        VASTParsingContext.parse(xmlString: xmlString) { _ in }
        print("FINISHED PARSE")
    }
}

class VASTParsingContext: NSObject {
    private let xmlParser: XMLParser
    private let completion: (Result<Any, Error>) -> Void
    
    private init(xmlParser: XMLParser, completion: @escaping (Result<Any, Error>) -> Void) {
        self.xmlParser = xmlParser
        self.completion = completion
    }
    
    @discardableResult
    static func parse(data: Data, completion: @escaping (Result<Any, Error>) -> Void) -> VASTParsingContext {
        let xmlParser = XMLParser(data: data)
        let context = VASTParsingContext(xmlParser: xmlParser, completion: completion)
        xmlParser.delegate = context
        xmlParser.parse()
        return context
    }
    
    @discardableResult
    static func parse(xmlString: String, completion: @escaping (Result<Any, Error>) -> Void) -> VASTParsingContext? {
        guard let data = xmlString.data(using: .utf8) else {
            completion(
                .failure(
                    NSError(
                        domain: "VASTParserError",
                        code: 101,
                        userInfo: [NSLocalizedDescriptionKey: "Could not convert xmlString to Data"]
                    )
                )
            )
            return nil
        }
        return parse(data: data, completion: completion)
    }
}

extension Optional where Wrapped == String {
    var orNA: String { self ?? "N/A" }
}

extension VASTParsingContext: XMLParserDelegate {
    // MARK: - Handling XML
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("did start document")
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("did end document")
    }
    
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        print("did start element | name: \(elementName) ; namespaceURI: \(namespaceURI.orNA) ; qualifiedName: \(qName.orNA) ; attributes: \(attributeDict)")
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("did end element | name: \(elementName) ; namespaceURI: \(namespaceURI.orNA) ; qualifiedName: \(qName.orNA)")
    }
    
    func parser(_ parser: XMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String) {
        print("did start mapping prefix | prefix: \(prefix) ; namespaceURI: \(namespaceURI)")
    }
    
    func parser(_ parser: XMLParser, didEndMappingPrefix prefix: String) {
        print("did end mapping prefix | prefix: \(prefix)")
    }
    
    func parser(_ parser: XMLParser, resolveExternalEntityName name: String, systemID: String?) -> Data? {
        print("resolve external entity name | name: \(name) ; systemID: \(systemID.orNA)")
        return nil
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parse error occurred | error: \(parseError)")
    }
    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print("validation error occurred | error: \(validationError)")
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("found characters | characters: \(string)")
    }
    
    func parser(_ parser: XMLParser, foundIgnorableWhitespace whitespaceString: String) {
        print("found ignorable whitespace | whitespace: \(whitespaceString)")
    }
    
    func parser(_ parser: XMLParser, foundProcessingInstructionWithTarget target: String, data: String?) {
        print("found processing instruction with target | target: \(target) ; data: \(data.orNA)")
    }
    
    func parser(_ parser: XMLParser, foundComment comment: String) {
        print("found comment | comment: \(comment)")
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        print("found CDATA | CDATA: \(CDATABlock)")
    }
    
    // MARK: - Handling the DTD
    
    func parser(
        _ parser: XMLParser,
        foundAttributeDeclarationWithName attributeName: String,
        forElement elementName: String,
        type: String?,
        defaultValue: String?
    ) {
        print("found attribute declaration | attributeName: \(attributeName) ; elementName: \(elementName) ; type: \(type.orNA) ; defaultValue: \(defaultValue.orNA)")
    }
    
    func parser(_ parser: XMLParser, foundElementDeclarationWithName elementName: String, model: String) {
        print("found element declaration | elementName: \(elementName) ; model: \(model)")
    }
    
    func parser(_ parser: XMLParser, foundExternalEntityDeclarationWithName name: String, publicID: String?, systemID: String?) {
        print("found external entity declaration | name: \(name) ; publicID: \(publicID.orNA) ; systemID: \(systemID.orNA)")
    }
    
    func parser(_ parser: XMLParser, foundInternalEntityDeclarationWithName name: String, value: String?) {
        print("found internal entity declaration | name: \(name) ; value: \(value.orNA)")
    }
    
    func parser(
        _ parser: XMLParser,
        foundUnparsedEntityDeclarationWithName name: String,
        publicID: String?,
        systemID: String?,
        notationName: String?
    ) {
        print("found unparsed entity declaration | name: \(name) ; publicID: \(publicID.orNA) ; systemID: \(systemID.orNA), notationName: \(notationName.orNA)")
    }
    
    func parser(_ parser: XMLParser, foundNotationDeclarationWithName name: String, publicID: String?, systemID: String?) {
        print("found notation declaration | name: \(name) ; publicID: \(publicID.orNA) ; systemID: \(systemID.orNA)")
    }
}

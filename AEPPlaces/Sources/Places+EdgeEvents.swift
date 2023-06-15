/*
 Copyright 2023 Adobe. All rights reserved.
 This file is licensed to you under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License. You may obtain a copy
 of the License at http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software distributed under
 the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
 OF ANY KIND, either express or implied. See the License for the specific language
 governing permissions and limitations under the License.
 */

import AEPCore
import AEPServices
import Foundation

extension Places {

    func sendExperienceEventToEdge(event: Event, poi: PointOfInterest, withRegionEventType type: PlacesRegionEvent) {

        // add eventType and prescribed data for the experience info
        let poiInteraction: [String: Any] = [
            PlacesConstants.XDM.Key.POI_DETAIL: createXDMPOIDetail(poi: poi)
        ]

        let xdmMap: [String: Any] = [
            PlacesConstants.XDM.Key.EVENT_TYPE: type.experienceEventType,
            PlacesConstants.XDM.Key.PLACE_CONTEXT: [
                PlacesConstants.XDM.Key.POI_INTERACTION: poiInteraction
            ]
        ]

        // Creating xdm edge event data
        let xdmEventData: [String: Any] = [
            PlacesConstants.XDM.Key.XDM: xdmMap
        ]

        // create the mask for storing event history
        let mask = [
            "xdm.eventType"
        ]

        // Creating xdm edge event with request content source type
        let event = Event(name: PlacesConstants.EventName.Request.LOCATION_TRACKING,
                          type: EventType.edge,
                          source: EventSource.requestContent,
                          data: xdmEventData,
                          mask: mask)
        dispatch(event: event)
    }

    private func createXDMPOIDetail(poi: PointOfInterest) -> [String: Any] {
        let poiDetail: [String: Any] = [
            PlacesConstants.XDM.Key.POI_ID: poi.identifier,
            PlacesConstants.XDM.Key.POI_NAME: poi.name,
            PlacesConstants.XDM.Key.POI_METADATA: createPOIMetadata(poi: poi)
        ]
        return poiDetail
    }

    private func createPOIMetadata(poi: PointOfInterest) -> [String: Any] {
        var list = [[String: Any]]()

        for (metaKey, metaValue) in poi.metaData {
            let metaTuple: [String: Any] = [
                PlacesConstants.XDM.Key.KEY: metaKey,
                PlacesConstants.XDM.Key.VALUE: metaValue
            ]

            list.append(metaTuple)
        }

        let metadata: [String: Any] = [PlacesConstants.XDM.Key.LIST: list]
        return metadata
    }

}

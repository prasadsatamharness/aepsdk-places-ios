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
    
    static let MASK_EVENT_TYPE_PATH = "xdm.eventType"
    static let MASK_POIID_PATH = "xdm.placeContext.POIinteraction.poiDetail.poiID"

    /// Sends an experience event to the edge server for the specified geofence entry/exit location event.
    ///
    /// - Parameters:
    ///   - event: The region event representing geofence entry/exit.
    ///   - poi: The PointOfInterest object associated with the event.
    ///   - type: The PlacesRegionEvent representing the region event type (entry or exit).
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
            Places.MASK_EVENT_TYPE_PATH,
            Places.MASK_POIID_PATH
        ]

        // Creating xdm edge event with request content source type
        let event = Event(name: PlacesConstants.EventName.Request.LOCATION_TRACKING,
                          type: EventType.edge,
                          source: EventSource.requestContent,
                          data: xdmEventData,
                          mask: mask)
        dispatch(event: event)
    }

    /// Creates an XDM (Experience Data Model) representation of a Point of Interest (POI) detail based on the provided POI object.
    ///
    /// - Parameter poi: The PointOfInterest object for which the XDM POI detail needs to be created.
    /// - Returns: A dictionary containing the XDM representation of the POI detail, following the XDM specification.
    private func createXDMPOIDetail(poi: PointOfInterest) -> [String: Any] {
        // Create a dictionary representing the XDM POI detail
        let poiDetail: [String: Any] = [
            PlacesConstants.XDM.Key.POI_ID: poi.identifier,
            PlacesConstants.XDM.Key.POI_NAME: poi.name,
            PlacesConstants.XDM.Key.POI_METADATA: createPOIMetadata(poi: poi)
        ]
        
        // Return the XDM POI detail dictionary
        return poiDetail
    }

    /// Creates metadata for a Point of Interest (POI) based on the provided POI object.
    ///
    /// - Parameter poi: The PointOfInterest object for which the metadata needs to be created.
    /// - Returns: A dictionary containing the metadata for the POI, with keys and values following the XDM specification.
    private func createPOIMetadata(poi: PointOfInterest) -> [String: Any] {
        var list = [[String: Any]]()

        // Iterate over the metadata key-value pairs of the POI
        for (metaKey, metaValue) in poi.metaData {
            // Create a dictionary representing a metadata tuple
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

Alias: DCM = http://dicom.nema.org/resources/ontology/DCM
Alias: SCT = http://snomed.info/sct
Alias: LOINC =  http://loinc.org
Alias: DCMIdType = http://hl7.org/fhir/uv/radiation-dose-summary/CodeSystem/dicom-identifier-type
Alias: HL7IdType = http://terminology.hl7.org/CodeSystem/v2-0203

Profile:        TID1410MeasurementGroupProfile
Parent:         Observation
Id:             tid-1410-measurement-group
Title:          "DICOM SR Planar ROI Measurement Group Mapping to Observation"
Description:    "DICOM SR Planar ROI Measurement Group Mapping to Observation"

* ^abstract = true
* insert DICOMSRStructureDefinitionContent

* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "type"
* identifier ^slicing.rules = #open
* identifier ^slicing.ordered = false
* identifier ^slicing.description = "Identifiers for the measurement group"

* identifier contains observationUID 0..* MS
* identifier[observationUID].type = DCMIdType#observation-uid "Observation UID"
* identifier[observationUID].system = "urn:dicom:uid"
* identifier[observationUID].value 1..1
* identifier[observationUID] ^short = "The unique identifier for the measurement group."

// Associated ServiceRequest
* basedOn ^slicing.discriminator.type = #type
* basedOn ^slicing.discriminator.path = "reference"
* basedOn ^slicing.rules = #open
* basedOn ^slicing.description = "Description of the related ServiceRequest"

* basedOn contains serviceRequestRef 0..1 MS
* basedOn[serviceRequestRef] only Reference(ServiceRequest)
* basedOn[serviceRequestRef] ^short = "Description of the related ServiceRequest"
* basedOn[serviceRequestRef].identifier.type 1..1
* basedOn[serviceRequestRef].identifier.type = HL7IdType#ACSN "Accession ID"
* basedOn[serviceRequestRef].identifier.value 1..1
* basedOn[serviceRequestRef].identifier ^short = "The accession number related to the performed study"

// Associated Imaging Study
* partOf ^slicing.discriminator.type = #type
* partOf ^slicing.discriminator.path = "reference"
* partOf ^slicing.rules = #open
* partOf ^slicing.description = "Description of the related ImagingStudy" 

* partOf contains imagingStudyRef 1..1 MS
* partOf[imagingStudyRef] only Reference(ImagingStudy)
* partOf[imagingStudyRef] ^short = "Related ImagingStudy"
* partOf[imagingStudyRef].identifier.type 1..1
* partOf[imagingStudyRef].identifier.type = DCMIdType#study-instance-uid "Study Instance UID"
* partOf[imagingStudyRef].identifier.system = "urn:dicom:uid"
* partOf[imagingStudyRef].identifier.value 1..1
* partOf[imagingStudyRef].identifier ^short = "Identifier related to Study Instance UID"

* category MS
* category = DCM#125007 "Measurement Group

* code MS
* code -> "Value of DTID 1410 Content Item with Concept Name 121071, DCM, 'Finding'"

* subject only Reference(Patient)
* subject 1..1 MS

* focus ^slicing.discriminator.type = #pattern
* focus ^slicing.discriminator.path = "type"
* focus ^slicing.rules = #open
* focus ^slicing.ordered = false
* focus ^slicing.description = "Observation foci"

* focus contains bodyStructure 0..* MS
* focus[bodyStructure] only Reference(ImagingSelection)
* focus[bodyStructure].identifier.type 1..1
* focus[bodyStructure].identifier.type = DCMIdType#tracking-uid "Tracking UID"
* partOf[imagingStudyRef].identifier.system = "urn:dicom:uid"
* partOf[imagingStudyRef].identifier.value 1..1
* partOf[imagingStudyRef].identifier ^short = "A unique identifier used for tracking a finding or feature, potentially across multiple reporting objects, over time"

* focus contains imageRegion 0..* MS
* focus[imageRegion] only Reference(ImagingSelection)
* focus[imageRegion] ^short = "Image Region"
* focus[imageRegion].category = DCM#111030 "Image Region"
* focus[imageRegion].code -> "Value of DTID 1410 Content Item with Concept Name 130400, DCM, 'Geometric Purpose of Region'"
* focus[imageRegion].instance.uid -> "Referenced SOP Instance UID (0008,1155)"
* focus[imageRegion].imageRegion.regionType -> "Graphic Type (0070,0023)"
* focus[imageRegion].imageRegion.coordinateType = "2D"
* focus[imageRegion].imageRegion.coordinates -> "Graphic Data (0070,0022)"

* focus contains referencedSegmentationFrame 0..* MS
* focus[referencedSegmentationFrame] only Reference(ImagingSelection)
* focus[referencedSegmentationFrame] ^short = "Referenced Segmentation Frame"
* focus[referencedSegmentationFrame].category = DCM#121214 "Referenced Segmentation Frame"
* focus[referencedSegmentationFrame].code -> "Value of DTID 1410 Content Item with Concept Name 130400, DCM, 'Geometric Purpose of Region'"
* focus[referencedSegmentationFrame].instance.uid -> "Referenced SOP Instance UID (0008,1155)"
* focus[referencedSegmentationFrame].instance.sopClass = sopClass = 1.2.840.10008.5.1.4.1.1.66.4 // Segmentation Storage
* focus[referencedSegmentationFrame].instance.segmentList -> "Referenced Segment Number (0062,000B)"

// Repeat for other image reference types

// Observation Date Time
* effective[x] only dateTime
* effective[x] 1..1 MS
* effective[x] ^short = "Irradiation Start Date Time"
* effective[x] -> "Observation DateTime (0040,A032)"

* interpretation MS
* interpretation -> "$QualType, $QualModType"

Alias: DCM = http://dicom.nema.org/resources/ontology/DCM
Alias: SCT = http://snomed.info/sct
Alias: LOINC =  http://loinc.org
Alias: DCMIdType = http://hl7.org/fhir/uv/dicom-sr/CodeSystem/dicom-identifier-type
Alias: HL7IdType = http://terminology.hl7.org/CodeSystem/v2-0203

Profile:        ImagingMeasurementProfile
Parent:         Observation
Id:             imaging-measurement
Title:          "Observation - DICOM SR Imaging Measurement Mapping to Observation"
Description:    "DICOM SR Imaging Measurement Mapping to Observation"

* ^abstract = true
* insert DICOMSRStructureDefinitionContent

* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "type"
* identifier ^slicing.rules = #open
* identifier ^slicing.ordered = false
* identifier ^slicing.description = "Identifiers for the measurement"

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
* category = DCM#125007 "Measurement Group"

* code MS

* subject only Reference(Patient)
* subject 1..1 MS

* focus ^slicing.discriminator.type = #pattern
* focus ^slicing.discriminator.path = "type"
* focus ^slicing.rules = #open
* focus ^slicing.ordered = false
* focus ^slicing.description = "Observation foci"

* focus contains trackingUidBodyStructure 0..* MS
* focus[trackingUidBodyStructure] only Reference(BodyStructure)
* focus[trackingUidBodyStructure].identifier.type 1..1
* focus[trackingUidBodyStructure].identifier.type = DCMIdType#tracking-uid "Tracking UID"
* focus[trackingUidBodyStructure].identifier.system = "urn:dicom:uid"
* focus[trackingUidBodyStructure].identifier.value 1..1
* focus[trackingUidBodyStructure].identifier ^short = "A unique identifier used for tracking a finding or feature, potentially across multiple reporting objects, over time"

// Observation Date Time
* issued 1..1 MS
* issued ^short = "Observation Date Time"

* method 0..1 MS

* device 1..1 MS
* device only Reference(AlgorithmIdentificationProfile or GeneralEquipmentProfile)
* device ^short = "Algorithm Identification or General Equipment Device"

* interpretation MS
* referenceRange MS

* bodyStructure MS
* bodyStructure only Reference(DICOMSRFindingSiteBodyStructureProfile)

* valueQuantity MS

Mapping: dicom-sr-for-TID300MeasurementProfile
Id: dicom-sr-tid-300
Title: "DICOM SR TID 300 Measurement"
Source: ImagingMeasurementProfile
Target: "https://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_A.html#sect_TID_300"
Description: "The TID300Measurement can be extracted from TID 300 - Measurement."
* -> "TID300(Measurement)"
* identifier[observationUID] -> "tag(0040,A171) [Observation UID]"
* subject -> "tag(0010,0020) [Patient ID]"
* code -> "TID300.$Measurement.tag(0040,A043) [Concept Name Code Sequence]"
* issued -> "tag(0040,A032) [Observation DateTime]"
* method -> "TID1501.EV(370129005, SCT, Measurement Method)"
* device -> "TID1501.EV(121071, DCM, Finding)"
* valueQuantity -> "TID300.$Measurement.tag(0040,A300) [Measured Value Sequence]"

Mapping: dicom-sr-for-TID1419MeasurementProfile
Id: dicom-sr-tid-1419
Title: "DICOM SR TID 1419 Measurement"
Source: ImagingMeasurementProfile
Target: "https://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_A.html#sect_TID_1419"
Description: "The TID1419Measurement can be extracted from TID 1419 - ROI Measurements."
* -> "TID1419(ROIMeasurement)"
* identifier[observationUID] -> "tag(0040,A171) [Observation UID]"
* subject -> "tag(0010,0020) [Patient ID]"
* code -> "TID1419.$Measurement.tag(0040,A043) [Concept Name Code Sequence]"
* issued -> "tag(0040,A032) [Observation DateTime]"
* method -> "TID1501.EV(370129005, SCT, Measurement Method)"
* device -> "TID1501.EV(121071, DCM, Finding)"
* valueQuantity -> "TID1419.$Measurement.tag(0040,A300) [Measured Value Sequence]"

Mapping: dicom-sr-for-TID1420MeasurementProfile
Id: dicom-sr-tid-1420
Title: "DICOM SR TID 1420 Measurement"
Source: ImagingMeasurementProfile
Target: "https://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_A.html#sect_TID_1420"
Description: "The TID1419Measurement can be extracted from TID 1420 - Measurements Derived From Multiple ROI Measurements."
* -> "TID1420(DerivedMeasurement)"
* identifier[observationUID] -> "tag(0040,A171) [Observation UID]"
* subject -> "tag(0010,0020) [Patient ID]"
* code -> "TID1420.CID7465.tag(0040,A043) [Concept Name Code Sequence]"
* issued -> "tag(0040,A032) [Observation DateTime]"
* method -> "TID1501.EV(370129005, SCT, Measurement Method)"
* device -> "TID1501.EV(121071, DCM, Finding)"
* valueQuantity -> "TID1420.CID7465.tag(0040,A300) [Measured Value Sequence]"
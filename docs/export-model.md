# Export Model

## Overview
The Export model defines an XML document rooted at `Export` in namespace `urn:commissioning:export:1.0`.

## Structure
- `Export` (required)
  - Attribute: `formatVersion` (required)
  - `Header` (required)
    - `ExportId` (required, string)
    - `GeneratedAt` (required, dateTime)
    - `Environment` (required, string)
  - `Records` (required)
    - `Record` (one or more)
      - `RecordId` (required, string)
      - `EntityType` (required, string)
      - `Payload` (required, string)
      - `Checksum` (optional, string)

## Notes
- The `Payload` field can contain serialized business content.
- `Checksum` is optional and may be used for integrity verification.

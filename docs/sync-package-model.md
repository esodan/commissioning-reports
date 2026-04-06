# Sync Package Model

## Overview
The Sync Package model defines an XML document rooted at `SyncPackage` in namespace `urn:commissioning:sync-package:1.0`.

## Structure
- `SyncPackage` (required)
  - Attribute: `version` (required)
  - `Metadata` (required)
    - `PackageId` (required, string)
    - `CreatedAt` (required, dateTime)
    - `SourceSystem` (required, string)
  - `Items` (required)
    - `Item` (one or more)
      - `ItemId` (required, string)
      - `Name` (required, string)
      - `Status` (required, string)
      - `UpdatedAt` (required, dateTime)

## Notes
- All elements are namespace-qualified.
- Dates use XML Schema `dateTime` format.
- `Item` cardinality is at least one to prevent empty packages.

# Business Rules

## General
1. Every XML document must validate against its corresponding XSD schema.
2. Schema/version attributes (`version`, `formatVersion`) must be populated.
3. Identifiers (`PackageId`, `ExportId`, `ItemId`, `RecordId`) must be unique within each document.

## Synchronization Rules
1. `SyncPackage/Metadata/CreatedAt` must be in UTC.
2. `Items/Item` must contain at least one entry.
3. `UpdatedAt` must be greater than or equal to `CreatedAt` for each item.

## Export Rules
1. `Export/Header/GeneratedAt` must be in UTC.
2. `Records/Record` must contain at least one entry.
3. `Checksum`, when present, must be computed from `Payload` using a documented algorithm.

## Interoperability Rules
1. Producers and consumers must agree on namespace and version before exchanging files.
2. Unknown elements should be rejected unless an extension policy is documented.

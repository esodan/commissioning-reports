# Domain Model

## Purpose
This document describes the core domain entities used by the commissioning reporting exchange format.

## Core Entities
- **SyncPackage**: A transport container for synchronized entities from a source system.
- **Export**: A flattened representation of records generated for downstream consumption.
- **Metadata/Header**: Audit details such as identifier, generation timestamp, and system context.
- **Item/Record**: The atomic data unit moved through synchronization and export workflows.

## Key Relationships
1. A **SyncPackage** contains one **Metadata** block and one or more **Item** entries.
2. An **Export** contains one **Header** block and one or more **Record** entries.
3. **Item** data may be transformed into **Record** data for distribution.

## Vocabulary
- **Source System**: Upstream application that publishes synchronized data.
- **Downstream Consumer**: System that consumes exported records.
- **Version**: Schema or document format indicator used for compatibility checks.

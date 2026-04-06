# Business Rules

## 1. Local catalog resolution when `Catalog` is absent in `SyncPackage`

If a `SyncPackage` omits `Catalog`, the receiver must resolve references against its local catalog cache/store.

- The package remains processable.
- Missing local references are marked unresolved (not silently dropped).
- Resolution attempts should be repeatable when new catalog data arrives.

## 2. Allow local progress with pending unresolved assignments

Execution workflows may continue locally when some assignments remain unresolved.

- Create and persist affected runtime objects with unresolved markers.
- Permit data capture and draft progress.
- Defer only actions that require fully resolved references.

This avoids blocking field work due to temporary sync gaps.

## 3. Block export while unresolved catalog references exist

Export is a stricter boundary than local execution.

- If any export-scoped entity references unresolved catalog items, export must fail validation.
- The failure should report each unresolved reference explicitly.
- Export retries are allowed once resolution completes.

## 4. Persist `TestEvaluation` explicitly

`TestEvaluation` must be stored as a first-class persisted record, not inferred transiently from measurements at read-time.

Reasons:

- preserves exact decision outcome at execution time,
- supports approvals/signoff workflows,
- enables independent audit and reprocessing.

## 5. One `Report` can contain many `Test`

Cardinality rule:

- `Report (1) -> (N) Test`

A single report aggregates multiple executed tests for an asset, scope, or commissioning phase.

## 6. One `Test` can contain many `Measurement`

Cardinality rule:

- `Test (1) -> (N) Measurement`

A test may capture multiple values across time, channels, phases, or retries.

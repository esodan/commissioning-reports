# Sync Package Model

## Purpose of `SyncPackage`

`SyncPackage` is the canonical exchange unit for synchronizing shared definitions and references between systems/environments.

Its purpose is to:

- move definition data in a deterministic, replay-safe format,
- keep local execution systems aligned on identifiers and source provenance,
- permit selective synchronization without forcing runtime execution state transfer.

## Included entities

A `SyncPackage` includes synchronization-layer entities, typically:

- `Asset` identities (at minimum reference keys used by tests),
- `TestDefinition`,
- `EvaluationDefinition`,
- catalog/provenance metadata when available,
- linkage metadata (such as `definitionSource`).

Execution records (`Report`, `Test`, `Measurement`, `TestEvaluation`) are not the primary payload of a sync package.

## Reference rules

Reference integrity is constrained by stable keys:

- `assetRef -> Asset.CIM_ID`
- `testDefinitionRef -> TestDefinition.gguid`

These rules ensure references survive transport, storage, and merging across systems.

For asset payloads, `Asset.CIM_ID` and `Asset.IFC_ID` are internal references that anchor the asset
to its extension blocks. Business rules:
- `Asset.CIM_ID` must be equal to `Asset.CIMExtensions/mRID`.
- `Asset.IFC_ID` must be equal to `Asset.IFCExtensions/GlobalId`.
- `CIM_ID` and `IFC_ID` should be immediately followed by their corresponding `CIMExtensions` and
  `IFCExtensions` blocks in the asset payload.

## Role of `definitionSource`

`definitionSource` records where a definition originated (e.g., platform baseline vs local/user-defined).

It is used to:

- drive update/merge behavior,
- prevent accidental overwrites of user-authored content by platform updates,
- support provenance and trust decisions,
- aid debugging when different environments contain divergent definitions.

## `platform` tests vs `user` tests

`platform` tests:

- come from centrally managed definitions,
- are distributed broadly through synchronization,
- are typically governed and versioned by product/platform maintainers.

`user` tests:

- are authored locally or tenant-specifically,
- may be synchronized within a limited scope,
- should remain isolated from automatic platform definition replacement unless explicitly promoted.

The distinction is essential for safe update policies and preserving local customization.

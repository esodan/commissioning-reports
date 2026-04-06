# Export Model

## Purpose of `Export`

`Export` is the outbound payload for delivering execution results and context to downstream consumers (external systems, archival stores, compliance workflows).

Unlike `SyncPackage`, export focuses on **historical execution truth** rather than definition catalog synchronization.

## Export XML structure

The export XML is a multi-report payload defined by the current export schema.

- `<Export>` root metadata (`version`, optional `generatedAt`)
- one or more nested `<Report>` elements with report identity, folio, creation time, and report status
- optional `<ProjectRef>` plus required `<AssetRef>` context inside each report
- nested `<Tests>` containing one or more `<Test>` elements per report
- nested `<Measurements>` per test
- optional nested `<TestEvaluation>` per test, including `ValidityCriteria` when needed
- optional report-level and test-level `<EvidenceList>`, where each evidence item can carry either
  an external `URI` or inline base64-encoded `EmbeddedContent`
- optional `PreparedBy` and `Signature` elements for signoff context

This structure preserves both machine readability and traceability.

## Preserving historical test/evaluation context

Historical meaning is preserved by exporting:

- immutable execution timestamps and identifiers,
- the test identifiers used at run time (`gguid`, optional `platformTestId`, and type/name fields),
- evaluation records as separate persisted objects,
- sufficient rule context to reproduce outcome interpretation through `ValidityCriteria` and computed values.

As a result, downstream systems can distinguish “what happened” from “what the current catalog says now”.

## Inline evidence support

Evidence can now travel in two modes:

- referenced mode using `URI` when the file is hosted or archived externally,
- embedded mode using `EmbeddedContent` when the file bytes must travel inside the XML payload.

For embedded evidence:

- the content is encoded as base64,
- `sizeBytes` must describe the decoded binary size,
- `SHA256` should describe the decoded binary content,
- exactly one of `URI` or `EmbeddedContent` must be present for each evidence item.

Embedded evidence is useful for offline interchange and self-contained archival bundles, but it
increases XML size significantly compared with external references.

## Why `ValidityCriteria` travels in export payload

`ValidityCriteria` must travel with exports because acceptance logic can change after execution.

Including it in payloads ensures:

- historical outcomes remain explainable even if central criteria evolve,
- re-audits can reproduce original pass/fail/quality decisions,
- recipients do not need a synchronized catalog snapshot to interpret the exported outcome,
- legal/compliance retention includes both observed data and the rule set applied.

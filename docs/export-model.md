# Export Model

## Purpose of `Export`

`Export` is the outbound payload for delivering execution results and context to downstream consumers (external systems, archival stores, compliance workflows).

Unlike `SyncPackage`, export focuses on **historical execution truth** rather than definition catalog synchronization.

## Export XML structure

The export XML should be organized as a context-first document with explicit references:

- `<Export>` root metadata (version, createdAt, producer)
- `<Report>` nodes for each exported report
- nested `<Test>` nodes per report
- nested `<Measurement>` nodes per test
- nested/associated `<TestEvaluation>` nodes per test
- embedded or referenced definition context (`TestDefinition`, `EvaluationDefinition`, `ValidityCriteria`)
- identity references (`assetRef`, `testDefinitionRef`) using stable keys

This structure preserves both machine readability and traceability.

## Preserving historical test/evaluation context

Historical meaning is preserved by exporting:

- immutable execution timestamps and identifiers,
- the definition identifiers used at run time,
- evaluation records as separate persisted objects,
- sufficient rule context to reproduce outcome interpretation.

As a result, downstream systems can distinguish “what happened” from “what the current catalog says now”.

## Why `ValidityCriteria` travels in export payload

`ValidityCriteria` must travel with exports because acceptance logic can change after execution.

Including it in payloads ensures:

- historical outcomes remain explainable even if central criteria evolve,
- re-audits can reproduce original pass/fail/quality decisions,
- recipients do not need perfect catalog synchronization to interpret evidence,
- legal/compliance retention includes both observed data and the rule set applied.

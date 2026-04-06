# Domain Model

## Conceptual entities

The commissioning domain uses a small set of entities with clear responsibilities:

- **Asset**: the equipment or system under test (identified by `CIM_ID`).
- **TestDefinition**: the reusable blueprint that describes *what* to test and *how to evaluate*.
- **EvaluationDefinition**: the evaluation block embedded in a `TestDefinition` that defines aggregation and acceptance criteria.
- **Export**: the transport container used to deliver one or more reports to downstream systems.
- **Report**: a container for a commissioning session or deliverable.
- **Test**: an execution instance of a `TestDefinition` within a report.
- **Measurement**: raw/normalized observed values captured during a test.
- **TestEvaluation**: the interpreted outcome of measurements, optionally carrying the criteria and computed values used during evaluation.

## Synchronization model vs execution model

The model is intentionally split into two layers:

- **Synchronization model** (catalog and definitions):
  - `Asset` (identity and references)
  - `TestDefinition`
  - embedded `EvaluationDefinition`
  - optional catalog metadata and source provenance
- **Execution model** (runtime and history):
  - `Export`
  - `Report`
  - `Test`
  - `Measurement`
  - `TestEvaluation`

This separation keeps distributed synchronization stable and idempotent while allowing local execution to progress independently over time.

Within the current export schema, one `Export` can contain one or more `Report` elements, and each `Report` contains its own asset context, tests, measurements, and optional evaluation/evidence/signature data.

## Why `TestDefinition` != `Test`

`TestDefinition` and `Test` are deliberately distinct because they represent different lifecycles:

- `TestDefinition` is versioned reference knowledge shared across environments.
- `Test` is a time-bound event in a specific report context.
- Many `Test` records can be created from one `TestDefinition`.
- Historical test records must remain immutable even if definitions evolve.

If these were merged, updates to definitions could corrupt historical meaning of previously executed tests.

## Why `Measurement` and `TestEvaluation` are separate

Separating observation from interpretation supports:

- **Re-evaluation**: the same measurements can be re-scored if criteria change.
- **Auditability**: preserved raw evidence (`Measurement`) plus explicit judgement (`TestEvaluation`).
- **Partial workflows**: measurements may exist before a final evaluation is produced.
- **Multiple interpretations**: one measurement set can support multiple evaluation passes.

## Why `EvaluationDefinition` is explicit

`EvaluationDefinition` is modeled explicitly inside each `TestDefinition` so evaluation logic is not hidden inside ad-hoc test payloads:

- keeps synchronization payloads self-describing at the test-definition level,
- ensures deterministic interpretation across systems,
- enables version tracking and provenance,
- allows clear distinction between “data captured” and “rule used to score it”.

This explicitness is required for traceability and regulatory-grade reporting.

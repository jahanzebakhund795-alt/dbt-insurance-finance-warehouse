# dbt Insurance Finance Warehouse

A newly built portfolio implementation for Jahanzeb Akhund, aligned with the data architecture and engineering work described in his resume. All example data is synthetic. This repository is independent sample work; it does not contain employer code, claim a historical deployment, or reproduce resume performance metrics.

## Implemented system

A dbt/DuckDB warehouse implements typed staging, policy dimensions, premium and claim facts, incremental claim loads, policy SCD snapshots, data quality gates, and loss-ratio marts. Premiums and claims are aggregated at policy grain before joining, preventing fact-to-fact multiplication. dbt generates executable lineage and documentation artifacts.

[Architecture diagram and design review](docs/ARCHITECTURE.md)

## Run

Use Python 3.11 for the documented development environment.

```sh
python3 -m venv .venv
. .venv/bin/activate
pip install -e ".[test]"
pytest -q
python -m insurance_warehouse.pipeline
# Re-run for incremental/replay verification:
python -m insurance_warehouse.pipeline
```

## Design and operating limits

Amounts use integer cents. The ratio is incurred losses divided by written premiums, not an actuarial earned-premium measure. This is analytics sample code, not accounting or regulatory reporting. Claim incremental loads require monotonic updated_at timestamps; a full refresh handles historical restatements. Snapshots capture observed changes only when dbt snapshot runs. DuckDB is a single-process local deployment; warehouse migration requires adapter-specific validation.

See [the operating guide](docs/OPERATIONS.md) for recovery, deployment, and validation boundaries. An optional GitHub Actions definition is in `docs/ci-template.yml`; enabling it requires installing it under `.github/workflows/` with workflow permission.

## References

- [dbt incremental models](https://docs.getdbt.com/docs/build/incremental-models)
- [dbt snapshots](https://docs.getdbt.com/docs/build/snapshots)

## Executed validation

2 pytest tests passed. The complete dbt seed/run/snapshot/test/docs pipeline ran twice: seven models, one snapshot, and all 19 dbt data tests passed. Post-run assertions verified fact grains, the 0.4 policy loss ratio, empty-claim handling, and three current policy snapshots.

[Full validation evidence and limits](VALIDATION.md)

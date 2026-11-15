# Validation evidence

Prepared November 15, 2026.

- **2 pytest tests passed** using Python 3.9.6.
- The complete dbt seed/run/snapshot/test/docs pipeline ran twice: seven models, one snapshot, and all 19 dbt data tests passed. Post-run assertions verified fact grains, the 0.4 policy loss ratio, empty-claim handling, and three current policy snapshots.
- The tested runtime used dbt-core 1.10.23, dbt-duckdb 1.9.6, and DuckDB 1.4.5. Resolve and validate a supported toolchain for the target production environment; no external cloud warehouse was tested.

Source Python and YAML configurations were parsed. Docker and Java were unavailable on the preparation machine; a parsed configuration is not an executed deployment. The documented Python 3.11 containers are supplied for reproducible integration checks and were not run here.

## Reproduce

```sh
python3 -m venv .venv
. .venv/bin/activate
pip install -e ".[test]"
pytest -q
```

See the README for optional full-stack commands and `reports/validation-summary.json` for the recorded local result.

import duckdb
with duckdb.connect('output/insurance.duckdb',read_only=True) as db:
    assert db.execute('SELECT COUNT(*) FROM dim_policy').fetchone()[0]==3
    assert db.execute('SELECT COUNT(*) FROM fact_premium').fetchone()[0]==4
    assert db.execute('SELECT COUNT(*) FROM fact_claim').fetchone()[0]==3
    assert db.execute("SELECT written_premium_loss_ratio FROM mart_policy_loss WHERE policy_id='P001'").fetchone()[0]==0.4
    assert db.execute("SELECT claim_count,incurred_cents FROM mart_policy_loss WHERE policy_id='P003'").fetchone()==(0,0)
    assert db.execute('SELECT COUNT(*) FROM snapshots.policy_history WHERE dbt_valid_to IS NULL').fetchone()[0]==3
print('Warehouse assertions passed: fact grains, loss ratio, empty claims, current snapshot.')

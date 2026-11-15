from pathlib import Path
import duckdb

def test_aggregate_before_join_prevents_fanout():
    with duckdb.connect() as db:
        db.execute("CREATE TABLE premium AS SELECT * FROM read_csv_auto('seeds/premiums.csv')")
        db.execute("CREATE TABLE claim AS SELECT * FROM read_csv_auto('seeds/claims.csv')")
        correct=db.execute('SELECT SUM(amount_cents) FROM premium').fetchone()[0]
        fanout=db.execute('SELECT SUM(amount_cents) FROM premium JOIN claim USING(policy_id)').fetchone()[0]
        assert correct==450000
        assert fanout!=correct
        result=db.execute("WITH p AS (SELECT policy_id,SUM(amount_cents) p FROM premium GROUP BY 1), c AS (SELECT policy_id,SUM(incurred_cents) c FROM claim GROUP BY 1) SELECT p.p,c.c,c.c*1.0/p.p FROM p JOIN c USING(policy_id) WHERE policy_id='P001'").fetchone()
        assert result==(200000,80000,0.4)

def test_region_loss_ratio_is_premium_weighted():
    with duckdb.connect() as db:
        weighted,unweighted=db.execute('SELECT SUM(loss)*1.0/SUM(premium),AVG(loss*1.0/premium) FROM (VALUES (80000,200000),(0,50000)) t(loss,premium)').fetchone()
        assert weighted==0.32 and unweighted==0.2

import json
import os
from pathlib import Path
import subprocess
import duckdb

def main():
    Path('output').mkdir(exist_ok=True)
    env=dict(os.environ,DBT_PROFILES_DIR=str(Path.cwd()))
    for command in ['seed','run','snapshot','test','docs generate']:
        subprocess.run(['dbt',*command.split()],env=env,check=True)
    with duckdb.connect('output/insurance.duckdb',read_only=True) as db:
        rows=db.execute('SELECT policy_id,written_premium_cents,incurred_cents FROM mart_policy_loss ORDER BY policy_id').fetchall()
    print(json.dumps({'policy_loss_summary':rows},indent=2))
if __name__=='__main__':
    main()

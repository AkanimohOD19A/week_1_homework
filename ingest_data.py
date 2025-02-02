import argparse
import os
import pandas as pd
import pyarrow.parquet as pq
import pyarrow as pa
from sqlalchemy import create_engine

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url
    print("type of port", type(port))
    chunk_size = 100000
    # download the Parquet file
    outputFile = "output.parquet"
    # os.system(f"wget {url} -O {outputFile}")
    os.system(f"curl -o {outputFile} {url} ")
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    engine.connect()
    parquet_file = pq.ParquetFile(outputFile)
    count = 0
    for batch in parquet_file.iter_batches(batch_size=chunk_size):
        count += 1
        print(f"Writing chunk {count} of size {len(batch)}")
        chunk_df = pa.Table.from_batches([batch]).to_pandas(split_blocks=True, self_destruct=True)
        chunk_df.to_sql(name="yellow_taxi_data", con=engine, if_exists="append")
        # break

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Ingest Parquet data to Postgres")
    parser.add_argument('--password', help='password for postgres')
    parser.add_argument('--user', help='user name for postgres')
    parser.add_argument('--host', help='host for postgres')
    parser.add_argument('--port', help='port for postgres')
    parser.add_argument('--db', help='database name for postgres')
    parser.add_argument('--table_name', help='name of the table where we will write the results to')
    parser.add_argument('--url', help='url of the Parquet file')
    args = parser.parse_args()
    main(args)
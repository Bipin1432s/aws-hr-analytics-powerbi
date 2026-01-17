import awswrangler as wr
import pandas as pd

BUCKET = "bipin-hr-analytics" 
RAW_PATH = f"s3://{BUCKET}/raw/*.csv"
PROCESSED_BASE = f"s3://{BUCKET}/processed/employees/"

def lambda_handler(event, context):

    df = wr.s3.read_csv(RAW_PATH)

    df.columns = df.columns.str.lower().str.replace(" ", "_")
    df = df.dropna()

    wr.s3.to_parquet(
        df=df,
        path=PROCESSED_BASE,
        partition_cols=["department"],
        dataset=True,
        index=False
    )

    return {
        "statusCode": 200,
        "body": "ETL completed: Data written as partitioned Parquet by department"
    }

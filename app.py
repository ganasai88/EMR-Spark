import argparse
from pyspark.sql import SparkSession
from pyspark.sql.functions import col
import json


def main(file_path: str):
    spark = (
        SparkSession
        .builder
        .master('yarn')
        .appName("Spark Pipeline Example")
        .getOrCreate()
    )

    # Load JSON configuration file
    with open(file_path) as file:
        json_data = json.load(file)

    # Extract input file details
    file_input = json_data["file_input"]

    for file in file_input:
        # Load CSV file into DataFrame
        df = spark.read.option("header", "true").csv(file["file_path"])

        # Rename columns
        df = df.select(
            col("Name").alias("Restaurant_Name"),
            col("Violation Type").alias("Violation Level"),
        )

        # Create a temporary view for SQL queries
        df.createOrReplaceTempView(file["table_name"])

    # Get the SQL transformation queries from the JSON config
    GROUP_BY_QUERY = json_data["transform"]

    for group in GROUP_BY_QUERY:
        # Perform the transformation (SQL query execution)
        transform_data = spark.sql(group["sql"])

        # Logs the result
        print(f"Number of rows in SQL query with red violations: {transform_data.count()}")

    # Get output file details for saving the transformed data
    file_output = json_data["file_output"]

    for file in file_output:
        # Save transformed data to Parquet
        transform_data.write.mode("overwrite").csv(file["file_path"])


if __name__ == "__main__":
    # Set up argument parsing
    parser = argparse.ArgumentParser()
    parser.add_argument('--config', required=True, help='Path to the json file path')
    args = parser.parse_args()

    # Call main function with the provided file path
    main(args.config)

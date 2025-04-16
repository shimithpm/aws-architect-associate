from pyspark.context import SparkContext
from awsglue.context import GlueContext

sc = SparkContext()
glueContext = GlueContext(sc)
logger = glueContext.get_logger()

def main():
    logger.info("Starting ETL job")
    
    # Your Spark transformations here
    dynamic_frame = glueContext.create_dynamic_frame.from_catalog(
        database="your_db",
        table_name="your_table"
    )
    
    # Example transformation
    transformed_frame = dynamic_frame.apply_mapping([
        ("id", "int", "id", "int"),
        ("name", "string", "full_name", "string")
    ])
    
    # Write output
    glueContext.write_dynamic_frame.from_options(
        frame=transformed_frame,
        connection_type="s3",
        connection_options={"path": "s3://your-output-bucket"},
        format="parquet"
    )

if __name__ == "__main__":
    main()
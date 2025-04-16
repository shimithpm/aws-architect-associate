import os
import json
import snowflake.connector

def lambda_handler(event, context):
    # Get credentials from environment variables
    sf_config = {
        'user': os.environ['SNOWFLAKE_USER'],
        'password': os.environ['SNOWFLAKE_PASSWORD'],
        'account': os.environ['SNOWFLAKE_ACCOUNT'],
        'warehouse': os.environ['SNOWFLAKE_WAREHOUSE'],
        'database': os.environ['SNOWFLAKE_DATABASE'],
        'schema': os.environ['SNOWFLAKE_SCHEMA']
    }
    
    try:
        # Connect to Snowflake
        conn = snowflake.connector.connect(**sf_config)
        cursor = conn.cursor()
        
        # Execute query
        cursor.execute("SELECT CURRENT_TIMESTAMP()")
        result = cursor.fetchone()
        
        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Successfully connected to Snowflake',
                'timestamp': str(result[0])
            })
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error: {str(e)}')
        }
    finally:
        if 'conn' in locals():
            conn.close()
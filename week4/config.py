import os
from pathlib import Path

GOOGLE_DRIVE_MOUNT_POINT = "/content/drive"
INPUT_FILE = Path(
    os.getenv(
        "TAXI_INPUT_FILE",
        "/content/drive/MyDrive/yellow_tripdata_2015-01.csv",
    )
)
OUTPUT_FILE = Path(
    os.getenv(
        "TAXI_OUTPUT_FILE",
        "/content/drive/MyDrive/taxi_output.parquet",
    )
)
API_URL = os.getenv("API_URL", "https://jsonplaceholder.typicode.com/posts")
API_OUTPUT_FILE = Path(os.getenv("API_OUTPUT_FILE", "/content/api_data.json"))
LOG_FILE = Path(os.getenv("LOG_FILE", "/content/ingestion.log"))

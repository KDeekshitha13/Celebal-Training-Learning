import argparse
import os

from config import (
    API_OUTPUT_FILE,
    API_URL,
    GOOGLE_DRIVE_MOUNT_POINT,
    INPUT_FILE,
    LOG_FILE,
    OUTPUT_FILE,
)
from src.api_data import fetch_and_save_api_data
from src.ingestion import ingest_data
from src.logging_config import configure_logging


def mount_google_drive() -> None:
    if os.getenv("COLAB_RELEASE_TAG"):
        from google.colab import drive

        drive.mount(GOOGLE_DRIVE_MOUNT_POINT)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=str, default=str(INPUT_FILE))
    parser.add_argument("--output", type=str, default=str(OUTPUT_FILE))
    parser.add_argument("--api-output", type=str, default=str(API_OUTPUT_FILE))
    args = parser.parse_args()

    mount_google_drive()
    configure_logging(LOG_FILE)
    cleaned_df = ingest_data(args.input, args.output)
    print("Final shape:", cleaned_df.shape)
    print(cleaned_df.head())

    api_data = fetch_and_save_api_data(API_URL, args.api_output)
    print("API data fetched successfully!")
    print("Total records:", len(api_data))
    print(api_data[:2])
    print("API data saved successfully as JSON!")


if __name__ == "__main__":
    main()

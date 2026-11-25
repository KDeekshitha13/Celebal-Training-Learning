import logging
from pathlib import Path

import pandas as pd

from config import INPUT_FILE, OUTPUT_FILE

from .cleaning import clean_taxi_data

logger = logging.getLogger(__name__)


def ingest_data(
    input_file: str | Path = INPUT_FILE,
    output_file: str | Path = OUTPUT_FILE,
) -> pd.DataFrame:
    try:
        logger.info("Reading CSV file: %s", input_file)
        df = pd.read_csv(input_file)
        logger.info("CSV file loaded successfully")

        df = clean_taxi_data(df)
        logger.info("Column names cleaned")
        logger.info("Duplicate records removed")
        logger.info("Missing values handled")
        logger.info("Numeric and date columns converted")
        logger.info("Negative amount validation passed")
        logger.info("Invalid date ranges removed")

        df.to_parquet(output_file, engine="pyarrow", index=False)
        logger.info("Data saved as Parquet: %s", output_file)
        logger.info("Data ingestion completed successfully")
        print("Ingestion completed successfully!")
        return df
    except Exception:
        logger.exception("Data ingestion failed")
        raise

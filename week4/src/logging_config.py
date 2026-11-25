import logging
from pathlib import Path

from config import LOG_FILE


def configure_logging(log_file: str | Path = LOG_FILE) -> None:
    logging.basicConfig(
        filename=log_file,
        level=logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
        force=True,
    )

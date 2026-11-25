import json
import logging
from pathlib import Path
from typing import Any

import requests

from config import API_OUTPUT_FILE, API_URL

logger = logging.getLogger(__name__)


def fetch_and_save_api_data(
    url: str = API_URL, output_file: str | Path = API_OUTPUT_FILE
) -> list[dict[str, Any]]:
    try:
        response = requests.get(url)
        response.raise_for_status()
        data = response.json()

        with Path(output_file).open("w", encoding="utf-8") as file:
            json.dump(data, file, indent=4)

        logger.info("API data fetched and saved to %s", output_file)
        return data
    except Exception:
        logger.exception("Failed to fetch or save API data from %s", url)
        raise

import pandas as pd

from src.cleaning import clean_column_names, handle_null_values, remove_duplicates


def test_column_names_are_lowercase_stripped_and_use_underscores() -> None:
    df = pd.DataFrame(columns=[" Vendor ID ", " Fare Amount "])

    cleaned = clean_column_names(df)

    assert list(cleaned.columns) == ["vendor_id", "fare_amount"]


def test_duplicate_rows_are_removed() -> None:
    df = pd.DataFrame({"vendorid": [1, 1, 2], "fare_amount": [10, 10, 20]})

    cleaned = remove_duplicates(df)

    assert cleaned.to_dict("records") == [
        {"vendorid": 1, "fare_amount": 10},
        {"vendorid": 2, "fare_amount": 20},
    ]


def test_null_values_drop_missing_vendor_fill_numeric_median_and_text_unknown() -> None:
    df = pd.DataFrame(
        {
            "vendorid": [1, None, 2],
            "fare_amount": [10.0, 99.0, None],
            "store_and_fwd_flag": ["N", "Y", None],
        }
    )

    cleaned = handle_null_values(df)

    assert cleaned["vendorid"].tolist() == [1.0, 2.0]
    assert cleaned["fare_amount"].tolist() == [10.0, 10.0]
    assert cleaned["store_and_fwd_flag"].tolist() == ["N", "Unknown"]

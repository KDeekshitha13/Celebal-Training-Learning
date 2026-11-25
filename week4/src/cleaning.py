import pandas as pd

AMOUNT_COLUMNS = [
    "fare_amount",
    "extra",
    "mta_tax",
    "tip_amount",
    "tolls_amount",
    "improvement_surcharge",
    "total_amount",
]
DATE_COLUMNS = ["tpep_pickup_datetime", "tpep_dropoff_datetime"]


def clean_column_names(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    df.columns = df.columns.str.lower().str.strip().str.replace(" ", "_")
    return df


def remove_duplicates(df: pd.DataFrame) -> pd.DataFrame:
    return df.drop_duplicates().copy()


def handle_null_values(df: pd.DataFrame) -> pd.DataFrame:
    df = df.dropna(subset=["vendorid"]).copy()

    for column in df.columns:
        if df[column].isnull().any():
            if pd.api.types.is_numeric_dtype(df[column]):
                df[column] = df[column].fillna(df[column].median())
            else:
                df[column] = df[column].fillna("Unknown")

    return df


def convert_numeric_columns(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    numeric_columns = df.select_dtypes(include=["int64", "float64"]).columns
    df[numeric_columns] = df[numeric_columns].astype(float)
    return df


def convert_date_columns(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    for column in DATE_COLUMNS:
        df[column] = pd.to_datetime(df[column], errors="coerce")
    return df


def validate_amounts(df: pd.DataFrame) -> None:
    for column in AMOUNT_COLUMNS:
        if (df[column] < 0).any():
            raise ValueError(f"Negative values found in {column}")


def remove_invalid_date_ranges(df: pd.DataFrame) -> pd.DataFrame:
    return df[df["tpep_dropoff_datetime"] >= df["tpep_pickup_datetime"]].copy()


def clean_taxi_data(df: pd.DataFrame) -> pd.DataFrame:
    df = clean_column_names(df)
    df = remove_duplicates(df)
    df = handle_null_values(df)
    df = convert_numeric_columns(df)
    df = convert_date_columns(df)
    validate_amounts(df)
    return remove_invalid_date_ranges(df)

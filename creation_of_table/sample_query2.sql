USE taxi_sample;

LOAD DATA LOCAL INFILE
'/Users/katakamdeekshitha/Downloads/archive (5)/yellow_tripdata_2015-01.csv'
INTO TABLE taxi_table
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
  
CREATE DATABASE IF NOT EXISTS worldwidebank;

use worldwidebank;

CREATE EXTERNAL TABLE IF NOT EXISTS worldwidebank.ww_customers(
                                    Gender               STRING
                                  , Title                STRING
                                  , GivenName            STRING
                                  , MiddleInitial        STRING
                                  , Surname              STRING
                                  , Number               INT
                                  , NameSet              STRING
                                  , StreetAddress        STRING
                                  , City                 STRING
                                  , State                STRING
                                  , StateFull            STRING
                                  , ZipCode              STRING
                                  , Country              STRING
                                  , CountryFull          STRING
                                  , EmailAddress         STRING
                                  , Username             STRING
                                  , Password             STRING
                                  , TelephoneNumber      STRING
                                  , TelephoneCountryCode INT
                                  , MothersMaiden        STRING
                                  , Birthday             STRING
                                  , Age                  INT
                                  , TropicalZodiac       STRING
                                  , CCType               STRING
                                  , CCNumber             STRING
                                  , CVV2                 STRING
                                  , CCExpires            STRING
                                  , NationalID           STRING
                                  , MRN                  STRING
                                  , InsuranceID          STRING
                                  , EyeColor             STRING
                                  , Occupation           STRING
                                  , Company              STRING
                                  , Vehicle              STRING
                                  , Domain               STRING
                                  , BloodType            STRING
                                  , Weight               DOUBLE
                                  , Height               DOUBLE
                                  , Latitude             DOUBLE
                                  , Longitude            DOUBLE
                                ) ROW FORMAT DELIMITED
                                  FIELDS TERMINATED BY ','
                                  STORED AS TEXTFILE
                                  LOCATION 's3a://pvidal-oregon/hortoniadata/ww_customers/'
                                  tblproperties("skip.header.line.count"="1");



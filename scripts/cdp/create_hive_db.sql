CREATE DATABASE IF NOT EXISTS worldwidebank LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/worldwidebank';

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
                                  LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/worldwidebank/ww_customers' 
                                  tblproperties("skip.header.line.count"="1");

CREATE EXTERNAL TABLE IF NOT EXISTS worldwidebank.us_customers(
                                    Number               STRING
                                  , Gender               STRING
                                  , Title                STRING
                                  , GivenName            STRING
                                  , MiddleInitial        STRING
                                  , Surname              STRING
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
                                  , TelephoneCountryCode STRING
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
                                   LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/worldwidebank/us_customers'
                                   tblproperties("skip.header.line.count"="1");

CREATE EXTERNAL TABLE IF NOT EXISTS worldwidebank.eu_countries (
                                    CountryName STRING
                                  , CountryCode STRING
                                  , Region STRING
                                 ) ROW FORMAT DELIMITED
                                   FIELDS TERMINATED BY ','
                                   STORED AS TEXTFILE
                                   LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/eu_countries';


CREATE DATABASE IF NOT EXISTS finance LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/finance';

CREATE EXTERNAL TABLE IF NOT EXISTS finance.tax_2009 (
                                    ssn STRING
                                  , fed_tax INT
                                  , state_tax INT
                                  , local_tax INT
                                 ) ROW FORMAT DELIMITED
                                   FIELDS TERMINATED BY ','
                                   STORED AS TEXTFILE
                                   LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/finance/tax_2009';

CREATE EXTERNAL TABLE IF NOT EXISTS finance.tax_2010 (
                                   ssn STRING
                                 , fed_tax INT
                                 , state_tax INT
                                 , local_tax INT
                                ) ROW FORMAT DELIMITED
                                  FIELDS TERMINATED BY ','
                                  STORED AS TEXTFILE
                                  LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/finance/tax_2010';

CREATE EXTERNAL TABLE IF NOT EXISTS finance.tax_2015 (
                                   ssn STRING
                                 , fed_tax INT
                                 , state_tax INT
                                 , local_tax INT
                                ) ROW FORMAT DELIMITED
                                  FIELDS TERMINATED BY ','
                                  STORED AS TEXTFILE
                                  LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/finance/tax_2015';

CREATE DATABASE IF NOT EXISTS cost_savings COMMENT 'Cost Savings Database' LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/cost_savings';

CREATE EXTERNAL TABLE IF NOT EXISTS cost_savings.claim_savings(
                                     ReportDate DATE
                                   , Name STRING
                                   , SequenceID INT
                                   , ClaimID INT
                                   , CostSavings INT
                                   , EligibilityCode DOUBLE
                                   , Latitude DOUBLE
                                   , Longitude DOUBLE
                                  ) COMMENT 'Claims Savings'
                                    ROW FORMAT DELIMITED
                                    FIELDS TERMINATED BY ','
                                    STORED AS TEXTFILE
                                    LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/cost_savings';


CREATE DATABASE IF NOT EXISTS claim COMMENT 'Claims Database' LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/claim';

CREATE EXTERNAL TABLE IF NOT EXISTS claim.provider_summary(
                                      ProviderID STRING
                                    , ProviderName STRING
                                    , ProviderStreetAddress STRING
                                    , ProviderCity STRING
                                    , ProviderState STRING
                                    , ProviderZip STRING
                                    , ProviderReferralRegion STRING
                                    , TotalDischarges INT
                                    , AverageCoveredCharges DECIMAL(10,2)
                                    , AverageTotalPayments DECIMAL(10,2)
                                    , AverageMedicarePayments DECIMAL(10,2)
                                   ) COMMENT 'Provider Summary'
                                     ROW FORMAT DELIMITED
                                     FIELDS TERMINATED BY ','
                                     STORED AS TEXTFILE
                                     LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/claim';

CREATE VIEW IF NOT EXISTS claim.prov_view AS SELECT * FROM claim.provider_summary;

CREATE VIEW IF NOT EXISTS claim.prov_view2 AS SELECT * FROM claim.provider_summary;

CREATE VIEW IF NOT EXISTS claim.claims_view AS SELECT * FROM cost_savings.claim_savings;


CREATE DATABASE IF NOT EXISTS consent_master LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/consent';

CREATE EXTERNAL TABLE IF NOT EXISTS consent_master.consent_data(
                                    Country              		STRING
                                  , CountryFull          		STRING
                                  , InsuranceID          		INT
                                  , MarketingConsent     		STRING
                                  , MarketingConsentStartDate   DATE
                                  , LoyaltyConsent     			STRING
                                  , LoyaltyConsentStartDate   	DATE
                                  , ThirdPartyConsent     		STRING
                                  , ThirdPartyConsentStartDate  DATE
                                ) ROW FORMAT DELIMITED
                                  FIELDS TERMINATED BY ','
                                  STORED AS TEXTFILE
                                  LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/consent'
				  tblproperties("skip.header.line.count"="1");


CREATE EXTERNAL TABLE IF NOT EXISTS consent_master.eu_countries(
                                    CountryCode              		STRING
                                  , CountryFull          		STRING
				                        ) ROW FORMAT DELIMITED
                                  FIELDS TERMINATED BY ','
                                  STORED AS TEXTFILE
                                  LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/eu_countries';



CREATE DATABASE IF NOT EXISTS hr LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/hr';

CREATE EXTERNAL TABLE IF NOT EXISTS hr.employees(
                                    Id          INT
                                  , Name        STRING
                                  , Age         INT
                                  , Phone       STRING
                                  , Email       STRING
                                  , DateOfBirth DATE
                                  , Region      STRING
                                  , Salary      INT
                                ) ROW FORMAT DELIMITED
                                  FIELDS TERMINATED BY ','
                                  STORED AS TEXTFILE
                                  LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/hr/employees'
                                  tblproperties("skip.header.line.count"="1");

CREATE EXTERNAL TABLE IF NOT EXISTS hr.employees_masked(
                                    Id          INT
                                  , Name        STRING
                                  , Age         INT
                                  , Phone       STRING
                                  , Email       STRING
                                  , DateOfBirth DATE
                                  , Region      STRING
                                  , Salary      INT
                                ) ROW FORMAT DELIMITED
                                  FIELDS TERMINATED BY ','
                                  STORED AS TEXTFILE
                                  LOCATION 's3a://pvidal-emr-bucket/raw/wwbankdata/rawzone/hr/employees'
                                  tblproperties("skip.header.line.count"="1");

CREATE VIEW IF NOT EXISTS hr.us_employees AS SELECT * FROM hr.employees where region='US';

CREATE VIEW IF NOT EXISTS hr.uk_employees AS SELECT * FROM hr.employees where region='UK';

CREATE VIEW IF NOT EXISTS hr.eu_employees AS SELECT * FROM hr.employees where region='EU';

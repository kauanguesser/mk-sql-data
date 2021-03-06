#
#	script file for mk-sql-data.php - oracle intefrface
#
# the tables fk_city and fk_address must exist - do create them with the statements below, please!
#


# you can use oci8 after "pecl install oci8-2.0.10" - instantclient has be installed before
database  provider is "ORACLE";

# first we add records to fk_city

reset data;
reset code;
reset actions;

filename is "output/random-fk-oracle.sql";

# ask for user name and user password
connection parameters are "192.168.1.65/XE,db2phpsite,db2phpsite,db2phpsite";

read surnames from "data/de-surnames.txt";
read prenames from "data/de-prenames.txt";
read streets from "data/de-streets.txt";
# zip codes have two columns!
read zipcodes from "data/de-zips.txt";
read text from "data/de-text.txt";

# delete all records from the table fk_address
delete clause for fk_address is "";
do delete from fk_address;

# delete all records from the table fk_city
delete clause for fk_city is "";
do delete from fk_city;

work on table fk_city;

start with record 0;

export 150 records;

use ID_CITY as unique;
use city as city;
use REVNAME as surname ;
use REVCREATOR as surname ;

set is_europe to "1";
set last_visit to randomized DATE IN PAST;
set REVDATE to randomized DATETIME IN PAST;
set REVFIRST to randomized DATETIME IN PAST;

fetch 'country_id' using `select country_id from countries`;


run the export;

# then we add records to fk_address

# reset data; - we need the data
reset code;
reset actions;

work on table fk_address;

start with record 0;

export 500 records;

use Name as surname;
use Vorname as prename;

fetch 'ID_MANDANT,ID_BUCHUNGSKREIS' using "select ID_MANDANT,ID_BUCHUNGSKREIS from BUCHUNGSKREIS";
fetch 'ID_COUNTRY' using 'select country_id from countries';
fetch 'ID_CITY' using `select ID_CITY from fk_city`;

increment 'ID_ADDRESS' depending on 'ID_MANDANT, ID_BUCHUNGSKREIS';


run the export;

# now we are done :-)

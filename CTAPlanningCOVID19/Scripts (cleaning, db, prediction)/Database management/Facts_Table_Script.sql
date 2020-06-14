USE finalproject;

######################## Insert Zipcode and date data into Facts Table ########################
# To get Each Zipcode for each date for teh first two columns in the Facts Table #

SELECT 
	d.Date,
    z.idZipcode
FROM
    Zipcode z
        CROSS JOIN
    Date_dim d;
    
DELETE FROM Facts_Tables WHERE Zipcode_idZipcode=0;


######################## Total Events ########################        
# Aggregate the total events by zipcode by date to insert into facts table on joined key date and zipcode. #

SELECT MAX(tbl.Date) as Date,MAX(tbl.Zipcode) as Zipcode,COUNT(tbl.Zipcode) as Num_of_Events
FROM (
SELECT CONCAT(e.reservation_end_date,c.Zip_codeid)as ID,e.reservation_end_date as Date,c.Zip_codeid as Zipcode,e.park_number, e.park_facility_name, e.event_type, e.Attendance,e.permit_status
	FROM Events e
LEFT JOIN
    CPD_Facilities c on e.park_number = c.Park_No
WHERE permit_status = "Approved") tbl
GROUP BY tbl.ID;

######################## Total LARGE Events ########################    
# Aggregate the total large events (greater than 10k) by zipcode by date to insert into facts table on joined key date and zipcode. #
    
SELECT MAX(tbl.Date) as Date,MAX(tbl.Zipcode) as Zipcode,COUNT(tbl.Zipcode)
FROM (
SELECT CONCAT(e.reservation_end_date,c.Zip_codeid)as ID,e.reservation_end_date as Date,c.Zip_codeid as Zipcode,e.park_number, e.park_facility_name, e.event_type, e.Attendance,e.permit_status
	FROM Events e
LEFT JOIN
    CPD_Facilities c on e.park_number = c.Park_No
WHERE permit_status = "Approved" AND
(e.event_type="Permit - Festival/Performance/12,001+ Event" OR e.Attendance >0)) tbl
GROUP BY tbl.ID;

######################## Bus Riders per Day per ZipCode ########################   
# Bus Riders per day per zipcode. This is not a perfect calculation. #
# We were only able to retrieve the data for total ridership per route. #
#So we aggregated the rides for all the bus routes that go through a zipcode and divided by number of stations in a Zipcode.  #
 
USE finalproject;

SELECT MAX(tbl.Date) as Date,MAX(tbl.Zipcode_id) as Zipcode,ROUND((SUM(tbl.Rides)/COUNT(tbl.Rides)),2) as Norm_Riders
FROM(
SELECT CONCAT(r.Date,s.Zipcode_id)as ID,r.Route, r.Date, r.Rides, s.Bus_Ridership_Bus_Ridekey, s.Bus_Stop_Locations_stop_id,s.address,s.Zipcode_id
FROM
    Bus_Ridership r
        CROSS JOIN
    Bus_Stops_and_Routes s
WHERE r.Route=s.Bus_Ridership_Bus_Ridekey) tbl
GROUP BY tbl.ID;

######################## Train Riders per Day per ZipCode ######################## 

# Bus Riders per day per zipcode. This is not a perfect calculation. #
# We were only able to retrieve the data for total ridership per route. #
#So we aggregated the rides for all the bus routes that go through a zipcode and divided by number of stations in a Zipcode.  #

USE finalproject;

SELECT MAX(tbl.Date) as Date,MAX(tbl.zip_code) as Zipcode,SUM(tbl.rides)as Total_riders
FROM(
SELECT CONCAT(date,zip_code)as ID,Date, zip_code, station_id, station_name, rides
FROM 
	Train_Station_Locations) tbl
GROUP BY tbl.ID;

######################## AVG COVID CASES ######################## 
# Covid data was provided on a weekly basis instead of a daily basis by zipcode#
# Instead of aggregating all information on a weekly basis, we decided to use the average Covid cases per day#
# This query calculates the average daily covid cases based on the weekly total per zipcode #

SELECT d.Date, c.zip_code, ROUND((c.Cases_weekly/7),2) as Avg_Daily_Cases
FROM Date_dim d
CROSS JOIN
	Covid_Cases c
WHERE d.Week_Number = c.week_number AND d.year=2020;

######################## AVG COVID DEATHS ########################  
# Covid data was provided on a weekly basis instead of a daily basis by zipcode#
# Instead of aggregating all information on a weekly basis, we decided to use the average Covid Deaths per day#
# This query calculates the average daily covid deaths based on the weekly total per zipcode #
   
SELECT d.Date, c.zip_code, ROUND((c.Deaths_weekly/7),2) as Avg_Daily_Deaths
FROM Date_dim d
CROSS JOIN
	Covid_Cases c
WHERE d.Week_Number = c.week_number AND d.year=2020;
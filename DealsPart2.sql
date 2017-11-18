# Anthony Chung
# 11/03/2017
#The purpose of this script is to practice navigating a database as well as creating custom views for query 

# Indicate that we are using the deals database
USE deals;  

# Execute a test query  
SELECT *
FROM Companies
WHERE CompanyName like "%Inc.";

# Select companies sorted by CompanyName
SELECT *
FROM Companies
ORDER BY CompanyID;

# Select deal parts with dollar value
SELECT DealName, PartNumber, DollarValue
From deals join DealParts on  (Deals.DealID = DealParts.DealID);

# Create a view that matches companies to deals
#DealName, Rolecode, CompanyName
CREATE View CompanyDeals AS
SELECT DealName,RoleCode,CompanyName
FROM Companies
	JOIN Players ON (Companies.CompanyID = Players.CompanyID)
	JOIN Deals ON (Players.DealID = Deals.DealID)
ORDER BY DealName;
# A test of the CompanyDeals view
SELECT * FROM CompanyDeals;



# Create a view that shows DealValues by Number of Parts
CREATE View DealValues AS
SELECT deals.DealID, sum(DollarValue) As TotalDollarValue, count(PartNumber) As NumbersOfParts
FROM deals
	JOIN DealParts ON (Deals.DealID = DealParts.DealID)
group by deals.DealID;
# A test of the DealValues view
SELECT * FROM DealValues;


# Create a view that shows DealSummary
# Select Deals.DealID, DealName, Number of players, Total dollar valu,e number of parts for each deal
#CREATE view DealSummary As 
SELECT Deals.DealID, DealName, count(PlayerID) As NumberofPlayers, sum(DollarValue) As TotalDollarValue, count(PartNumber) As NumberOfParts
FROM deals
	JOIN DealParts ON (Deals.DealID = DealParts.DealID)
	JOIN Players ON  (Deals.DealID = Players.DealID)
group by deals.DealID;
#Select all from Deal Summary
SELECT * from DealSummary order by DealID;

#Create a view that shows DealsByType
#connect type code to dealtypes to  dealparts
create view DealsByType As
Select TypeCodes.typecode, count(dealtypes.DealID) As NumberOfDeals, sum(DollarValue) As TotalValueOfDeal
From TypeCodes
	left join dealtypes on (typecodes.typecode = dealtypes.TypeCode)
	left join deals on (dealtypes.dealID = deals.dealID)
	left join dealparts on (deals.dealID = dealparts.dealID)
group by TypeCodes.typecode;
#A test on DealsByType
select * FROM dealsbytype;

#Create a view Dealplayers
#CompanyID, Name, and Role Code for each deal. Sort the players by the RoleSortOrder.
create view dealplayers as
select Companies.companyID, CompanyName, players.Rolecode 
from companies
	left join Players on (Companies.CompanyID = players.CompanyID)
	left join rolecodes on (players.rolecode = RoleCodes.RoleCode)
order by RoleSortOrder;
# A test on Dealplayers
select * from dealplayers;

#create a view by dealsbyfirm
#FirmID, Name, number of deals, and total value of deals for each firm.
create view dealsbyfirm as
select firms.firmID, firms.name, count(players.dealID) as NumbOfDeals, sum(TotalDollarValue) as TotalDollarValue
from Firms
	left join PlayerSupports on (firms.FirmID = PlayerSupports.firmID)
	left join players on (playersupports.PlayerID = players.PlayerID)
	join dealvalues using (dealid)
group by firms.firmID, firms.name;
#Test dealsbyfirm
select * from dealsbyfirm;


# Anthony Chung
# 11/18/2017
# Alter each table by adding a FK to each relationship

# Add FK for DealTypes to Typecode
ALTER TABLE DealTypes
ADD FOREIGN KEY (`TypeCode`)
	REFERENCES TypeCodes (`TypeCode`);

# Add FK for Dealtype to Deals with DEALID
ALTER TABLE DealTypes
	ADD FOREIGN KEY (`DealID`)
		REFERENCES Deals (`DealID`);

#Add FK for DealParts to Deals with DealID
ALTER TABLE DealParts
	ADD FOREIGN KEY (`DealID`)
		REFERENCES Deals (`DealID`);

#Add FK for Players to Deals with DealID
ALTER TABLE Players
	ADD FOREIGN KEY (`DealID`)
		REFERENCES Deals (`DealID`);

#ADD FK for Players to Companies with CompanyID
ALTER TABLE Players
	ADD FOREIGN KEY (`CompanyID`)
		REFERENCES Companies (`CompanyID`);

#ADD FK for Players to RoleCodes with Rolecode
ALTER TABLE Players
	ADD FOREIGN KEY (`RoleCode`)
		REFERENCES RoleCodes (`RoleCode`);

#ADD FK for Playersupports to players with PlayerID
ALTER TABLE PlayerSupports
	ADD FOREIGN KEY (`PlayerID`)
		REFERENCES Players (`PlayerID`);

# ADD FK for playersupports to firms with firmID
ALTER TABLE PlayerSupports
	ADD FOREIGN KEY (`FirmID`)
		REFERENCES Firms (`FirmID`);

#Add FK for playersupports to supportcodes with supportcodeID
ALTER TABLE PlayerSupports
	ADD FOREIGN KEY (`SupportCodeID`)
		REFERENCES SupportCodes (`SupportCodeID`);

ALTER TABLE DealTypes
	DROP FOREIGN KEY `dealtypes_ibfk_3`;
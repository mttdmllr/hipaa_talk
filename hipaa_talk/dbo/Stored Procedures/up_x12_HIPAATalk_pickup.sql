
CREATE PROCEDURE [dbo].[up_x12_HIPAATalk_pickup]
AS
	/***
	Author:			Chad Casady
	Date:			1/18/2011
	Description:	This script loops over all of the pickup-locations defined in the HIPAATalk database and runs the
					"up_x12_directory_pickup" stored procedure to look at each directory and pick up and parse all of the
					files in it.

	Note:			This script calls "up_x12_directory_pickup" which requires "xp_cmdshell" functionality activated, otherwise it simply will not work.
	***/

	DECLARE @location_address varchar(2000)

	DECLARE X12PickupFolder SCROLL CURSOR FOR
		SELECT DISTINCT x12_location.location_address
		FROM x12_organization_pickup_location
		INNER JOIN x12_location
			ON x12_organization_pickup_location.x12_location_id = x12_location.x12_location_id
		WHERE x12_location.active = 1

	OPEN X12PickupFolder
	FETCH NEXT FROM X12PickupFolder INTO @location_address 
	WHILE (@@fetch_status <> -1)
	BEGIN
		EXEC dbo.up_x12_directory_pickup @PickupFolder = @location_address, @ErrorDirectory = NULL

		FETCH NEXT FROM X12PickupFolder INTO @location_address 
	END

	CLOSE X12PickupFolder
	DEALLOCATE X12PickupFolder


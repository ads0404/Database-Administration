USE Vaccinations
GO

--A view that shows each vaccination place,  total number of vaccinations that could happen each day, number of vaccinations actually happening or booked each day. 



CREATE OR ALTER VIEW vaccinationsOccuring
AS
SELECT placeId, count(apptTime) as vacinations
from Appointment
	WHERE vaccineNumber IS NOT NULL
		Group BY placeId

SELECT ALL FROM vaccinationsOccuring
	GO

CREATE OR ALTER VIEW vaccinationsBookedAndOccuring
AS
SELECT Appointment.placeId, count(slot) as 'Number of Vaccinations that can happen', vacinations as 'Vaccinations happening that are booked'
from Appointment
	inner join vaccinationsOccuring on  Appointment.placeId = vaccinationsOccuring.placeId
		Group by Appointment.placeId, vaccinationsOccuring.vacinations;

SELECT ALL FROM vaccinationsBookedAndOccuring;
	GO
	
	
	
--- view for missed booking and no later booking --- include names and contact details

CREATE OR ALTER VIEW displayMissedAppointments
	AS
	SELECT preferredName, eMail, phone 
	FROM Person
		inner join Appointment ON Person.NHI = Appointment.personId
		WHERE Appointment.vaccinator IS  NULL

SELECT ALL FROM displayMissedAppointments

SELECT COUNT ALL FROM displayMissedAppointments
GO


--A view that can be used to show people broken down by age in decades as at the date of their first vaccination.  Only show people that have been vaccinated.
CREATE OR ALTER VIEW listPeopleVaccinated
AS
	SELECT preferredName, DATEDIFF(YEAR, dateOfBirth, GETDATE()) as AGE, vaccineNumber
	FROM Person
	inner join Appointment ON personId = Person.NHI
		WHERE vaccineNumber >= 1

SELECT * FROM listPeopleVaccinated
GO




--A view showing the number of sessions and the number of vaccines all vaccinators have done.  Include those vaccinators that have yet to vaccinate anybody.
CREATE OR ALTER VIEW totalVaccinesAndSessionsFromVaccinator
SELECT preferredName FROM Vaccinator
Inner join Appointment on Appointment.vaccinator = vaccinator.iRDNumber

SELECT ALL FROM totalVaccinesAndSessionsFromVaccinator
SELECT COUNT ALL FROM totalVaccinesAndSessionsFromVaccinator


-- Join to get geographic point for mapping
SELECT
    cy.CALENDAR_YEAR,
    cy.LOCATION_ID,
    cy.AGE_GROUP_PUBLIC,
    REPLACE(REPLACE(cy.[Location], ' CoC', ''), ' County', '') AS COUNTY,
    cy.EXPERIENCING_HOMELESSNESS_CNT,
    geo.geo_point
FROM 
    [dbo].[cy_age] cy
left JOIN
    [dbo].[us-county-boundaries] as geo ON REPLACE(REPLACE(cy.[Location], ' CoC', ''), ' County', '') = geo.name;


-- Add "Two or More Races" category to race_ethnicity column
SELECT 
    CALENDAR_YEAR,
    LOCATION_ID, 
    CASE 
        WHEN alone_or_in_combination = 'in_combination' THEN 'two or more races'
        ELSE RACE_ETHNICITY
    END AS race_ethnicity,
    SUM(CNT) AS CNT
FROM 
    [dbo].[cy_race]
GROUP BY 
    CALENDAR_YEAR,
    LOCATION_ID, 
    CASE 
        WHEN alone_or_in_combination = 'in_combination' THEN 'two or more races'
        ELSE RACE_ETHNICITY
    END

-- Add "Other" category to gender column
SELECT 
    CALENDAR_YEAR,
    LOCATION_ID,
	LOCATION,
    CASE
        WHEN GENDER != 'Cisgender Man' AND GENDER != 'Cisgender Woman' THEN 'Other'
        ELSE GENDER
    END AS Gender,
    SUM(EXPERIENCING_HOMELESSNESS_CNT) as CNT
FROM
    [dbo].[cy_gender]
GROUP BY 
    CALENDAR_YEAR,
    LOCATION_ID,
	LOCATION,
    CASE
        WHEN GENDER != 'Cisgender Man' AND GENDER != 'Cisgender Woman' THEN 'Other'
        ELSE GENDER
    END

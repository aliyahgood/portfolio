# Homelessness in California: A County-Level Analysis

## Overview

This project analyzes a dataset of individuals who have accessed homeless response services, examining the distribution of services across different age, race, and gender groups at the county level. An interactive Tableau dashboard was created to visualize trends and provide actionable insights for equitable resource allocation, targeted outreach, and support planning. 

## Project Links
- [Tableau Dashboard](https://public.tableau.com/app/profile/aliyah.good/viz/homelessness_in_california/HomelessnessDashboard?publish=yes/)
- [SQL Code](./CA_homelessness_data_cleaning.sql)
  
## Dataset
- **Title:** `People Receiving Homeless Response Services by Age, Race, and Gender`
- **Source:** Homelessness Data Integration System (HDIS)
  - Available at: [data.gov](https://catalog.data.gov/dataset/people-receiving-homeless-response-services-by-age-race-ethnicity-and-gender-b667d/resource/6860eb43-14bd-4b02-8843-d5e07bb510aa)
- **Contents:**
  - Homelessness Count by:
    - Age: <code>[cy_age.csv](https://github.com/aliyahgood/portfolio/blob/main/Homelessness%20in%20California/data/cy_age.csv)</code>
    - Gender: <code>[cy_gender.csv](https://github.com/aliyahgood/portfolio/blob/main/Homelessness%20in%20California/data/cy_gender.csv)</code>
    - Race: <code>[cy_race.csv](https://github.com/aliyahgood/portfolio/blob/main/Homelessness%20in%20California/data/cy_race.csv)</code>

## Tools and Technologies
- **SQL:** Data cleaning and preprocessing
- **Tableau:** Data visualization and interactive dashboard creation

## Dashboard Features
- **Choropleth Map:** Visualizes the distribution of individuals receiving homeless response services by county
- **Donut Charts:** Displays demographic breakdowns by race, gender, and age
- **Line Charts:** Shows trends in the number of individuals receiving homeless response services by demographic over time 
- **Interactive Filters:**
   - **Year:** Allows users to filter data by specific years, tracking changes over time
   - **County:** Enables users to filter data by county, offering insights at a local level

For a more in-depth exploration and to interact with the data, visit the live [Tableau Dashboard](https://public.tableau.com/app/profile/aliyah.good/viz/homelessness_in_california/HomelessnessDashboard?publish=yes/)

![Homelessness Dashboard](./CA_homelessness_dashboard.png)

## Insights and Recommendations
- Geographic Trends
  - Increase funding for shelters in high-need counties
- Demographic Disparities
  - Implement targeted programs for vulnerable demographics, such as women and seniors.
- Address systemic inequities through affordable housing initiatives and equity-focused policies.

## Challenges and Future Improvements


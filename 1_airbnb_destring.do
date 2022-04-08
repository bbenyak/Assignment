
*** First Do-file

***		i. Imports csv
*** 	ii. Handles missing values, destrings numeric characters
*** 	ii. Aggregates data to see patterns better




***		i. Create folder for assignment, move csv there and import it

cd  "C:/Users/Felhasználó/Documents/CEU/Winter 22/Coding/Assignment"

import delimited using airbnb_london_cleaned.csv, varnames(1) bindquotes(strict) encoding("utf-8") clear




*** 	ii. Check data, destring numeric characters having handled missing values


br
format %15.0f scrape_id		// so that ids can be seen when browsing dataset

foreach var of varlist review* {
	replace `var' = "" if `var' == "NA"
	destring `var', replace
}

tab neighbourhood_group_cleansed has_availability
drop neighbourhood_group_cleansed has_availability
tab license host_acceptance_rate, m
drop license state host_acceptance_rate


foreach var of varlist  host_response_rate host_listings_count host_total_listings_count bathrooms bedrooms beds square_feet price weekly_price monthly_price security_deposit cleaning_fee{
	replace `var' = "" if `var' == "NA"
	replace `var' = "" if `var' == "N/A"
	destring `var', replace
}


foreach var of varlist host_since calendar_last_scraped first_review last_review {
	ren `var' `var'_str
	gen `var' = date(`var'_str, "YMD")
}

tab bed_type
tab room_type
tab property_type
tab cancellation

compress

save airbnb_london_cleaned_destringed.dta, replace



*** 	iii. Aggregates data to see patterns better

collapse (mean) price review_scores_rating host_response_rate, by(neighbourhood_cleansed wirelessinternet washer washerdryer tv suitableforevents smokingallowed selfcheckin privatelivingroom privateentrance pool petsallowed lockonbedroomdoor laptopfriendlyworkspace kitchen internet hairdryer gym freeparkingonpremises freeparkingonstreet familykidfriendly airconditioning hourcheckin review_scores_cleanliness number_of_reviews beds bedrooms bathrooms bed_type)

br
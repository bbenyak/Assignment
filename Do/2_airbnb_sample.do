

*** Second Do-file

***		i. Checks some continuous variables whether they correlate with price 
*** 	ii. Creates a data sample for analyses


use airbnb_london_cleaned_destringed.dta, clear


***		i. Checks some continuous variables whether they correlate with price


twoway scatter price review_scores_rating || lfit price review_scores_rating

twoway scatter price host_response_rate || lfit price host_response_rate
twoway scatter host_response_rate review_scores_rating || lfit host_response_rate review_scores_rating

hist review_scores_rating
graph box review_scores_rating		// very non-normale distributions, interpret as disutility when bad

hist host_response_rate
graph box host_response_rate		// very non-normale distributions, interpret as disutility when bad	

gen negrev = 100-review_scores_rating
gen unresponsive = 100-host_response_rate

gen lognegrev = log(negrev+1)
gen logunresponsive = log(unresponsive+1)

twoway scatter logunresponsive lognegrev || lfit logunresponsive lognegrev		//not too interesting, and even less intuitive; discrete bunches still visible due to rating at 10s
drop log*

// all in all, not so much. maybe a dummy variable could be more useful


***		ii. Sample data

codebook price beds bedrooms bathrooms bed_type unresponsive negrev


keep if price != . & beds != . & bedrooms != . & bathrooms != . 

codebook neighbourhood_cleansed wirelessinternet washer washerdryer tv suitableforevents smokingallowed selfcheckin privatelivingroom privateentrance pool petsallowed lockonbedroomdoor laptopfriendlyworkspace kitchen internet hairdryer gym freeparkingonpremises freeparkingonstreet familykidfriendly airconditioning hourcheckin review_scores_cleanliness number_of_reviews beds bedrooms bathrooms bed_type		// no missing left in these, and they seem like reasonable factors to affect price

keep price negrev unresponsive neighbourhood_cleansed wirelessinternet washer washerdryer tv suitableforevents smokingallowed selfcheckin privatelivingroom privateentrance pool petsallowed lockonbedroomdoor laptopfriendlyworkspace kitchen internet hairdryer gym freeparkingonpremises freeparkingonstreet familykidfriendly airconditioning hourcheckin review_scores_cleanliness number_of_reviews beds bedrooms bathrooms bed_type

compress

save airbnb_london_sample.dta, replace



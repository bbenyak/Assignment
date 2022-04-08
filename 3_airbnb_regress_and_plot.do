
*** Third Do-file

***		i. Installs package
***		ii. Runs OLS regressions
***		iii. Plots the distribution of prices by neighbourhood as well as some of the strongest control variables



***		i. Install package 

sysdir 
sysdir set PLUS "C:\Users\Felhasználó\ado\Plus\"		// I have to change the sysdir path to install due to special characters

*ssc install estout		// installed here, commented it out so there are no issues when re-running file




***		ii. Run OLS regressions

use airbnb_london_sample.dta, clear

reg price negrev unresponsive

ren review_scores_cleanliness cleanliness
ren laptopfriendlyworkspace prolaptopworksp
ren privatelivingroom prvtlivingrm
ren privateentrance prvtentrance
ren smokingallowed smoking

twoway scatter price beds || lfit price beds, title("Number of beds at airbnb apartment and prices") saving(airbnb_london_morebeds_highcost.png, replace)

reg price beds bedrooms kitchen negrev
eststo
reg price beds bedrooms kitchen pool internet selfcheckin hourcheckin prvtlivingrm prvtentrance cleanliness
gen self24 = hourcheckin == 1 & selfcheckin == 1

reg price beds bedrooms kitchen pool internet selfcheckin self24 hourcheckin prvtlivingrm prvtentrance cleanliness
eststo

reg price beds bedrooms kitchen internet selfcheckin self24 hourcheckin prvtlivingrm prvtentrance cleanliness smoking prolaptopworksp pool gym airconditioning
eststo


esttab 
esttab using airbnb_regressions.doc, noabbrev replace
eststo clear



***		iii. Plot distribution of prices, number of beds, number of bedrooms and number of pools by neighbourhood


use airbnb_london_sample.dta, clear

bysort neighbourhood_cleansed: keep if _N > 1000

graph hbar price, over(neighbourhood_cleansed, label(labsize(vsmall))) ytitle("Average price") title("Average airbnb price by neighbourhood") saving(airbnb_london_hoods_prices.png, replace)

graph hbar beds, over(neighbourhood_cleansed, label(labsize(vsmall))) ytitle("Average number of beds") title("Average nr of airbnb beds by neighbourhood") saving(airbnb_london_hoods_beds.png, replace)

graph hbar bedrooms, over(neighbourhood_cleansed, label(labsize(vsmall))) ytitle("Average number of bedrooms") title("Average nr of airbnb bedrooms by neighbourhood") saving(airbnb_london_hoods_bedrooms.png, replace)

graph hbar pool, over(neighbourhood_cleansed, label(labsize(vsmall))) ytitle("Average number of pools") title("Average nr of airbnb pools by neighbourhood") saving(airbnb_london_hoods_pools.png, replace)



*** Master do-file


***		i. Create folder for assignment, move csv there
p
mkdir "CEU/Winter 22/Coding/Assignment"
copy "../Downloads/airbnb_london_cleaned.csv" "CEU/Winter 22/Coding/Assignment/Data/airbnb_london_cleaned.csv"

cd  "CEU/Winter 22/Coding/Assignment/Do"

***		ii. Run do-files

do 1_airbnb_destring.do

do 2_airbnb_sample.do

do 3_airbnb_regress_and_plot.do
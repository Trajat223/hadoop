-- Load the computer availability dataset
computer_availability = LOAD 'computer-availability.csv' USING PigStorage(',')
    AS (state: chararray,
        total_schools_all: int,
        total_schools_govt: int,
        total_schools_govt_aided: int,
        total_schools_pvt_unaided: int,
        total_schools_others: int,
        schools_with_computer_all: int,
        schools_with_computer_govt: int,
        schools_with_computer_govt_aided: int,
        schools_with_computer_pvt_unaided: int,
        schools_with_computer_others: int,
        percent_computer_all: float,
        percent_computer_govt: float,
        percent_computer_govt_aided: float,
        percent_computer_pvt_unaided: float,
        percent_computer_others: float);

-- Select only state and total_schools_all columns
filtered_data = FOREACH computer_availability GENERATE state, total_schools_all, total_schools_govt;

-- Sort by total_schools_all in descending order
sorted_data = ORDER filtered_data BY total_schools_all DESC;

-- Format the output as a concatenated string
formatted_output = FOREACH sorted_data GENERATE
    CONCAT('state: ', (chararray)state, ' | ',
           'total schools: ', (chararray)total_schools_all, ' | ',
           'govt schools: ', (chararray)total_schools_govt) AS Line;

-- Store the result in a CSV file
STORE formatted_output INTO '1sorted_state_and_total_schools';


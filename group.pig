-- Load the dataset
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

-- Add a grouping category based on the number of govt schools
categorized_data = FOREACH computer_availability GENERATE
    state,
    total_schools_govt,
    (total_schools_govt < 1000 ? 'Less than 1000' : '1000 or more') AS category;

-- Group data by the category
grouped_data = GROUP categorized_data BY category;

-- Generate formatted output for each group
formatted_output = FOREACH grouped_data {
    record_strings = FOREACH categorized_data GENERATE 
        CONCAT('  State: ', state, 
               ', Total Schools Govt: ', (chararray)total_schools_govt);
    
    combined_records = CONCAT('Entries:\n', 
                               BagToString(record_strings, '\n'));

    GENERATE
        CONCAT('Category: ', group) AS category,
        combined_records AS entries;
};

-- Store formatted results in a file using a single character delimiter (e.g., '|')
STORE formatted_output INTO 'output_diectory/group_data' USING PigStorage('|');


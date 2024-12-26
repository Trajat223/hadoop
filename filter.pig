-- Load datasets
data_internet = LOAD 'internet-facility.csv' USING PigStorage(',') AS (
    State:CHARARRAY,
    Total_Schools_All_Management:INT,
    Total_Schools_Govt:INT,
    Total_Schools_Govt_Aided:INT,
    Total_Schools_Pvt_Unaided:INT,
    Total_Schools_Others:INT,
    Schools_Internet_All_Management:INT,
    Schools_Internet_Govt:INT,
    Schools_Internet_Govt_Aided:INT,
    Schools_Internet_Pvt_Unaided:INT,
    Schools_Internet_Others:INT
);

data_computer = LOAD 'computer-availability.csv' USING PigStorage(',') AS (
    State:CHARARRAY,
    Total_Schools_All_Management:INT,
    Total_Schools_Govt:INT,
    Total_Schools_Govt_Aided:INT,
    Total_Schools_Pvt_Unaided:INT,
    Total_Schools_Others:INT,
    Schools_Computer_All_Management:INT,
    Schools_Computer_Govt:INT,
    Schools_Computer_Govt_Aided:INT,
    Schools_Computer_Pvt_Unaided:INT,
    Schools_Computer_Others:INT
);

-- Filter government schools with internet facilities > 10,000
govt_schools_internet = FILTER data_internet BY Schools_Internet_Govt > 10000;

-- Project required fields with formatted output
govt_schools_internet_projected = FOREACH govt_schools_internet GENERATE
    CONCAT('state: ', (chararray)State, ' | govt schools with internet > 10000: ', 
    (chararray)Schools_Internet_Govt) AS formatted_output;

-- Filter private unaided schools with computer facilities < 15,000
pvt_unaided_schools_computer = FILTER data_computer BY Schools_Computer_Pvt_Unaided < 15000;

-- Project required fields with formatted output
pvt_unaided_schools_computer_projected = FOREACH pvt_unaided_schools_computer GENERATE
    CONCAT('state: ', (chararray)State, ' | private unaided schools with computer < 15000: ', 
    (chararray)Schools_Computer_Pvt_Unaided) AS formatted_output;

-- Join datasets on State
merged_data = JOIN govt_schools_internet BY State, pvt_unaided_schools_computer BY State;

-- Format joined results with both conditions
merged_data_projected = FOREACH merged_data GENERATE 
    CONCAT(
        'state: ', (chararray)govt_schools_internet::State, 
        ' | govt schools with internet > 10000: ', (chararray)govt_schools_internet::Schools_Internet_Govt,
        ' | private unaided schools with computer < 15000: ', (chararray)pvt_unaided_schools_computer::Schools_Computer_Pvt_Unaided
    ) AS formatted_output;

-- Store the results
STORE govt_schools_internet_projected INTO 'output/govt_schools_internet' USING PigStorage('|');
STORE pvt_unaided_schools_computer_projected INTO 'output/pvt_unaided_schools_computer' USING PigStorage('|');
STORE merged_data_projected INTO 'output/merged_data' USING PigStorage('|');


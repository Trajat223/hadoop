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

-- Join datasets on State
joined_data = JOIN data_internet BY State, data_computer BY State;

-- Project necessary columns for output
joined_data_projected = FOREACH joined_data GENERATE
    data_internet::State AS State,
    data_internet::Schools_Internet_Govt AS Internet_Govt,
    data_computer::Schools_Computer_Govt AS Computer_Govt;

-- Print each output in a separate line with spaces between lines
formatted_output = FOREACH joined_data_projected GENERATE
    CONCAT('state: ', (chararray)State, ' | ',
           'govt schools with internet facility: ', (chararray)Internet_Govt, ' | ',
           'govt schools with computer facility: ', (chararray)Computer_Govt) AS Line;

-- Store the output in a file
STORE formatted_output INTO 'output/joined_data_output' USING PigStorage('\n');


# Pig Project: Filtering, Joining, Grouping, and Sorting Datasets

## Overview
This project demonstrates the use of Apache Pig to process school-related datasets. The tasks include:

- **Filtering**: Extracting data based on specific conditions.
- **Joining**: Merging multiple datasets on a common key.
- **Grouping**: Aggregating data for analysis.
- **Sorting**: Organizing data in ascending or descending order.

The project is designed to analyze and generate insights from datasets about internet and computer facilities in schools.

---

## Project Structure

```
pig-project/
├── input/
│   ├── internet-facility.csv
│   ├── computer-availability.csv
├── scripts/
│   ├── filter_schools.pig
│   ├── join_datasets.pig
│   ├── group_data.pig
│   ├── sort_data.pig
├── output/
│   ├── govt_schools_internet/
│   ├── pvt_unaided_schools_computer/
│   ├── merged_data/
│   ├── sorted_data/
├── logs/
│   ├── pig_exec.log
├── README.md
└── config/
    └── pig.properties
```

### **Description**

1. **`input/`**:
   Contains input datasets:
   - `internet-facility.csv`: Details about internet availability in schools.
   - `computer-availability.csv`: Details about computer availability in schools.

2. **`scripts/`**:
   Holds the Pig scripts for processing data:
   - **`filter_schools.pig`**: Filters data based on specific conditions.
   - **`join_datasets.pig`**: Joins datasets on a common key (State).
   - **`group_data.pig`**: Groups data for aggregation.
   - **`sort_data.pig`**: Sorts data based on specified fields.

3. **`output/`**:
   Stores the results of each operation:
   - `govt_schools_internet/`: Filtered government schools with internet facilities.
   - `pvt_unaided_schools_computer/`: Filtered private unaided schools with computer facilities.
   - `merged_data/`: Results of joined datasets.
   - `sorted_data/`: Sorted datasets.

4. **`logs/`**:
   Logs for debugging and execution tracking (e.g., `pig_exec.log`).

5. **`config/`**:
   Configuration files for Pig execution, such as reducer settings and compression options.

6. **`README.md`**:
   Documentation of the project (this file).

---

## Input Datasets

### `internet-facility.csv`
Columns:
- **State**: Name of the state.
- **Total_Schools_All_Management**: Total schools under all managements.
- **Total_Schools_Govt**: Total government schools.
- **Total_Schools_Govt_Aided**: Total government-aided schools.
- **Total_Schools_Pvt_Unaided**: Total private unaided schools.
- **Total_Schools_Others**: Total other schools.
- **Schools_Internet_All_Management**: Schools with internet under all managements.
- Additional columns for internet facilities in different management types.

### `computer-availability.csv`
Columns:
- Similar structure to `internet-facility.csv`, but with details about computer availability.

---

## Steps to Execute

1. **Setup Input Data**:
   - Place `internet-facility.csv` and `computer-availability.csv` in the `input/` directory.

2. **Run Pig Scripts**:
   - Execute each script in sequence:
     ```bash
     pig -x mapreduce scripts/filter_schools.pig
     pig -x mapreduce scripts/join_datasets.pig
     pig -x mapreduce scripts/group_data.pig
     pig -x mapreduce scripts/sort_data.pig
     ```

3. **View Output**:
   - Processed data will be stored in the `output/` directory under appropriate subdirectories.

4. **Logs**:
   - Check the `logs/` directory for execution details and error logs.

---

## Configuration

### Example `pig.properties` File
```properties
pig.exec.reducers=5
pig.tmpfilecompression=true
pig.tmpfilecompression.codec=gzip
mapreduce.job.reduces=2
```

To use this file, pass it as an option when running Pig:
```bash
pig -x mapreduce -P config/pig.properties scripts/filter_schools.pig
```

---

## Output Format

- **Filtered Data**:
  ```
  state: <state_name> | govt_schools_internet: <number>
  state: <state_name> | pvt_schools_computer: <number>
  ```

- **Joined Data**:
  ```
  state: <state_name> | govt_schools_internet: <number> | pvt_schools_computer: <number>
  ```

---

## Future Enhancements
- Add more datasets for comprehensive analysis.
- Implement more advanced Pig operations (e.g., ranking, pivoting).
- Integrate with visualization tools for better insights.


import $;

OriginalLoan := $.loanLR.file; //original dataset
ML_data := $.loanLR.MLloan; //recordset we using

export prepLR := module 
ML_loan := Record(ML_data)
    UNSIGNED4 rnd; //random number
end;

ML_loan ML_Clean(OriginalLoan le, integer cnt) := TRANSFORM
    SELF.rnd := RANDOM();
    SELF.id := (UNSIGNED8) Le.id; // Convert to UNSIGNED8
    SELF.int_rate := (UNSIGNED8) Le.int_rate;
    SELF.fico_range_low := (UNSIGNED8) Le.fico_range_low;
    SELF.loan_amnt := (DECIMAL) Le.loan_amnt;
    SELF.annual_inc := (DECIMAL) Le.annual_inc;
    SELF.dti := (DECIMAL) Le.dti;
    SELF.loan_status := $.DCTS.MapLs2Code(Le.loan_status);
END;

//Project the cleaned data
EXPORT myDataProject:= PROJECT(OriginalLoan, ML_Clean(LEFT, COUNTER));
// Sort the data based on the random number
EXPORT myDataProjectSorted := SORT(myDataProject, rnd);
//Cleaning the data by removing null values
Clean := myDataProjectSorted.id <> 0 AND myDataProjectSorted.loan_amnt <> 0 AND myDataProjectSorted.annual_inc <> 0 AND myDataProjectSorted.dti <> 0 AND myDataProjectSorted.int_rate <> 0AND myDataProjectSorted.fico_range_low <> 0;
//posing the cleaned data 
export myDataCleaned := myDataProjectSorted(Clean);
// Split the data into training, testing, and build datasets
    // EXPORT myTrainData := myDataCleaned[1..8000]; // Training data
    // EXPORT myTestData := myDataCleaned[8001..12000]; // Testing data
    // EXPORT myTrainAta := myDataCleaned[12001..20000]; // Data for building the attack model
    // EXPORT myTestAta := myDataCleaned[20001..24000]; // Testing data for the attack model
END;






    


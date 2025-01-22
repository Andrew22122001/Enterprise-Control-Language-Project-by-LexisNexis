import $;
IMPORT STD;
//output($.prepLR.myTrainData);
// STRING user_input := 'default_value';  // Set a default value
// PARAMETER(user_input);  // Mark it as a parameter
// // Use the user_input in your ECL code
// OUTPUT('The user input is: ' + user_input);
output($.prepLR.myDataCleaned(loan_amnt > 5000 ));
//output($.prepLR.myDataProjectSorted[..750]);
//output($.prepLR.myDataProjectSorted[..750]);

// Apply transformation to mask fico_range_low if it's greater than 600
// Apply transformation to mask fico_range_low if it's greater than 600
// NewRecord := RECORD
//     $.prepLR.myTrainData;  // Inherit the fields from the original dataset
//     STRING fico_range_status;  // Define the new field as a STRING to store the masked value
// END;

// MaskedData := PROJECT(
//     $.prepLR.myTrainData(loan_amnt > 5000), 
//     TRANSFORM(NewRecord, 
//         SELF.fico_range_status := IF(LEFT.fico_range_low > 600, 'Good', STD.STR(LEFT.fico_range_low)),  // Mask values > 600 with 'Good'
//         SELF := LEFT  // Copy the rest of the fields unchanged
//     )
// );

// // Output the masked data
// OUTPUT(MaskedData);


/////////////////////////
// IMPORT $;
// IMPORT STD;

// output($.prepLR.myTrainData);

// // Define a new record structure with an additional field for fico_range_status
// NewRecord := RECORD
//     $.prepLR.myTrainData;  // Inherit the fields from the original dataset
//     STRING fico_range_status;  // Define the new field as a STRING to store the masked value
// END;

// MaskedData := PROJECT(
//     $.prepLR.myTrainData(loan_amnt > 5000), 
//     TRANSFORM(NewRecord, 
//         SELF.fico_range_status := IF(LEFT.fico_range_low > 600, 'Good', 'Value: ' + LEFT.fico_range_low),  // Construct the string manually
//         SELF := LEFT  // Copy the rest of the fields unchanged
//     )
// );

// // Output the masked data
// OUTPUT(MaskedData);
// EXPORT MaskedLoanData := MaskedData;


// EXPORT MaskedLoanData := MaskedData;

// // Use the masked data for training and testing
// EXPORT myMaskedTrainData := MaskedLoanData[1..8000];  // Training data
// EXPORT myMaskedTestData := MaskedLoanData[8001..12000];  // Testing data
// EXPORT myMaskedTrainAta := MaskedLoanData[12001..20000];  // Data for building the attack model
// EXPORT myMaskedTestAta := MaskedLoanData[20001..24000];  // Testing data for the attack model

// // Calculate the range of fico_range_low (min and max)
// ficoRangeStats := RECORD
//     UNSIGNED8 fico_range_low_min;  // Min value of fico_range_low
//     UNSIGNED8 fico_range_low_max;  // Max value of fico_range_low
// END;

// // Aggregate to get the min and max of fico_range_low
// ficoRangeData := TABLE($.prepLR.myTrainData,
//                        TRANSFORM(ficoRangeStats,
//                            SELF.fico_range_low_min := MIN($.prepLR.myTrainData, fico_range_low),
//                            SELF.fico_range_low_max := MAX($.prepLR.myTrainData, fico_range_low)
//                        )
// );

// // Output the range values
// OUTPUT(ficoRangeData, NAMED('FicoRange'));


////////////////////////////////////////////


IMPORT $;
IMPORT STD;

// output($.prepLR.myDataCleaned);

// Define a new record structure excluding fico_range_low and replacing it with fico_range_masked
MaskedRecord := RECORD
    $.prepLR.myDataCleaned.rnd;           // Keep rnd
    $.prepLR.myDataCleaned.id;            // Keep id
    $.prepLR.myDataCleaned.int_rate;      // Keep int_rate
    STRING fico_range_masked;           // New field to hold the masked value (FICO category)
    $.prepLR.myDataCleaned.loan_amnt;     // Keep loan_amnt
    $.prepLR.myDataCleaned.annual_inc;    // Keep annual_inc
    $.prepLR.myDataCleaned.dti;           // Keep dti
    $.prepLR.myDataCleaned.loan_status;   // Keep loan_status
    
    
END;
// Apply the masking logic to categorize fico_range_low into the given ranges
MaskedData := PROJECT(
    $.prepLR.myDataCleaned,  // No condition on loan_amnt
    TRANSFORM(MaskedRecord, 
        SELF.fico_range_masked := IF(LEFT.fico_range_low >= 645 AND LEFT.fico_range_low < 700, '1',
                                IF(LEFT.fico_range_low >= 700 AND LEFT.fico_range_low < 750, '2',
                                IF(LEFT.fico_range_low >= 750 AND LEFT.fico_range_low < 800, '3',
                                IF(LEFT.fico_range_low >= 800 AND LEFT.fico_range_low <= 845, '4', 'unknown')))),
        SELF := LEFT  // Copy the rest of the fields unchanged
    )
);



// Output the masked data, excluding the original fico_range_low field
// OUTPUT(MaskedData);
EXPORT MaskedLoanData := module
        EXPORT myTrainData := MaskedData[1..8000]; // Training data
        EXPORT myTestData := MaskedData[8001..12000]; // Testing data
        EXPORT myTrainAta := MaskedData[12001..20000]; // Data for building the attack model
        EXPORT myTestAta := MaskedData[20001..24000]; // Testing data for the attack model
END;
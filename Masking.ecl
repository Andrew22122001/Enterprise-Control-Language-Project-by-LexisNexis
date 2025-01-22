IMPORT $;
IMPORT STD;

// Define a new record structure excluding fico_range_low and replacing it with fico_range_masked as UNSIGNED8
MaskedRecord := RECORD
    //$.prepLR.myDataCleaned.rnd;           // Keep rnd
    $.prepLR.myDataCleaned.id;             // Keep id
    $.prepLR.myDataCleaned.int_rate;       // Keep int_rate
    integer fico_range_masked;             // Use integer for numeric FICO category (1-4)
    integer loan_amnt_bracket;            // Use integer for loan amount bracket                   
    integer income_bracket;                // Use integer for income_bracket
    $.prepLR.myDataCleaned.dti;            // Keep dti
    $.prepLR.myDataCleaned.loan_status;    // Keep loan_status
END;

// Apply the masking logic to categorize fico_range_low, annual_inc, and loan_amnt into numeric brackets
MaskedData := PROJECT(
    $.prepLR.myDataCleaned,  // No condition on loan_amnt
    TRANSFORM(MaskedRecord, 
        SELF.fico_range_masked := IF(LEFT.fico_range_low >= 645 AND LEFT.fico_range_low < 700, 1,
                                IF(LEFT.fico_range_low >= 700 AND LEFT.fico_range_low < 750, 2,
                                IF(LEFT.fico_range_low >= 750 AND LEFT.fico_range_low < 800, 3,
                                IF(LEFT.fico_range_low >= 800 AND LEFT.fico_range_low <= 845, 4, 0)))),

        // Categorize annual_inc into numeric income brackets (1-6), defaulting to 0 for unknown
        SELF.income_bracket := IF(LEFT.annual_inc <= 20000, 1,      // Low income
                              IF(LEFT.annual_inc > 20000 AND LEFT.annual_inc <= 50000, 2,  // Medium-Low income
                              IF(LEFT.annual_inc > 50000 AND LEFT.annual_inc <= 100000, 3, // Medium income
                              IF(LEFT.annual_inc > 100000 AND LEFT.annual_inc <= 200000, 4, // High income
                              IF(LEFT.annual_inc > 200000 AND LEFT.annual_inc <= 1000000, 5, // Very High income
                              IF(LEFT.annual_inc > 1000000, 6, 0)))))),
        
        SELF.loan_amnt_bracket := IF(LEFT.loan_amnt >= 500 AND LEFT.loan_amnt < 1500, 1,
                              IF(LEFT.loan_amnt >= 1500 AND LEFT.loan_amnt < 2500, 2,
                              IF(LEFT.loan_amnt >= 2500 AND LEFT.loan_amnt < 3500, 3,
                              IF(LEFT.loan_amnt >= 3500 AND LEFT.loan_amnt < 4500, 4,
                              IF(LEFT.loan_amnt >= 4500 AND LEFT.loan_amnt < 5500, 5,
                              IF(LEFT.loan_amnt >= 5500 AND LEFT.loan_amnt < 6500, 6,
                              IF(LEFT.loan_amnt >= 6500 AND LEFT.loan_amnt < 7500, 7,
                              IF(LEFT.loan_amnt >= 7500 AND LEFT.loan_amnt < 8500, 8,
                              IF(LEFT.loan_amnt >= 8500 AND LEFT.loan_amnt < 9500, 9,
                              IF(LEFT.loan_amnt >= 9500 AND LEFT.loan_amnt < 10500, 10,
                              IF(LEFT.loan_amnt >= 10500 AND LEFT.loan_amnt < 11500, 11,
                              IF(LEFT.loan_amnt >= 11500 AND LEFT.loan_amnt < 12500, 12,
                              IF(LEFT.loan_amnt >= 12500 AND LEFT.loan_amnt < 13500, 13,
                              IF(LEFT.loan_amnt >= 13500 AND LEFT.loan_amnt < 14500, 14,
                              IF(LEFT.loan_amnt >= 14500 AND LEFT.loan_amnt < 15500, 15,
                              IF(LEFT.loan_amnt >= 15500 AND LEFT.loan_amnt < 16500, 16,
                              IF(LEFT.loan_amnt >= 16500 AND LEFT.loan_amnt < 17500, 17,
                              IF(LEFT.loan_amnt >= 17500 AND LEFT.loan_amnt < 18500, 18,
                              IF(LEFT.loan_amnt >= 18500 AND LEFT.loan_amnt < 19500, 19,
                              IF(LEFT.loan_amnt >= 19500 AND LEFT.loan_amnt < 20500, 20,
                              IF(LEFT.loan_amnt >= 20500 AND LEFT.loan_amnt < 21500, 21,
                              IF(LEFT.loan_amnt >= 21500 AND LEFT.loan_amnt < 22500, 22,
                              IF(LEFT.loan_amnt >= 22500 AND LEFT.loan_amnt < 23500, 23,
                              IF(LEFT.loan_amnt >= 23500 AND LEFT.loan_amnt < 24500, 24,
                              IF(LEFT.loan_amnt >= 24500 AND LEFT.loan_amnt < 25500, 25,
                              IF(LEFT.loan_amnt >= 25500 AND LEFT.loan_amnt < 26500, 26,
                              IF(LEFT.loan_amnt >= 26500 AND LEFT.loan_amnt < 27500, 27,
                              IF(LEFT.loan_amnt >= 27500 AND LEFT.loan_amnt < 28500, 28,
                              IF(LEFT.loan_amnt >= 28500 AND LEFT.loan_amnt < 29500, 29,
                              IF(LEFT.loan_amnt >= 29500 AND LEFT.loan_amnt < 30500, 30,
                              IF(LEFT.loan_amnt >= 30500 AND LEFT.loan_amnt < 31500, 31,
                              IF(LEFT.loan_amnt >= 31500 AND LEFT.loan_amnt < 32500, 32,
                              IF(LEFT.loan_amnt >= 32500 AND LEFT.loan_amnt < 33500, 33,
                              IF(LEFT.loan_amnt >= 33500 AND LEFT.loan_amnt < 34500, 34,
                              IF(LEFT.loan_amnt >= 34500 AND LEFT.loan_amnt < 35500, 35,
                              IF(LEFT.loan_amnt >= 35500 AND LEFT.loan_amnt < 36500, 36,
                              IF(LEFT.loan_amnt >= 36500 AND LEFT.loan_amnt < 37500, 37,
                              IF(LEFT.loan_amnt >= 37500 AND LEFT.loan_amnt < 38500, 38,
                              IF(LEFT.loan_amnt >= 38500 AND LEFT.loan_amnt < 39500, 39,
                              IF(LEFT.loan_amnt >= 39500 AND LEFT.loan_amnt <= 40000, 40, 0)))))))))))))))))))))))))))))))))))))))),

        SELF := LEFT  // Copy the rest of the fields unchanged
    )
);

// Output the masked data
// OUTPUT(MaskedData);

// Define the module that exports the datasets
EXPORT Masking := MODULE
    EXPORT myTrainData := MaskedData[1..8000];     // Training data
    EXPORT myTestData := MaskedData[8001..12000];  // Testing data
    EXPORT myTrainAta := MaskedData[12001..20000]; // Data for building the attack model
    EXPORT myTestAta := MaskedData[20001..24000];  // Testing data for the attack model
END;
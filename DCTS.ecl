EXPORT DCTS := MODULE 

    EXPORT Ls_DS := DATASET([
        {'Fully Paid',0},
        {'Current',0},
        {'Charged Off',1}
    ], {string loan_status, UNSIGNED1 lscode});

EXPORT LsDCT := DICTIONARY(Ls_DS, {loan_status => lscode});

EXPORT MapLs2Code(String loan_status) := lsDCT[loan_status].lscode;

END;
 

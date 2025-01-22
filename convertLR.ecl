IMPORT $;
IMPORT ML_Core;

myTrainData := $.Masking.myTrainData;
myTestData := $.Masking.myTestData;
myTrainAData := $.Masking.myTrainAta;
myTestAData := $.Masking.myTestAta;

ML_Core.ToField(myTrainData, myTrainDataNF); //matric, wi , vi, //computer needs matrix to understand
ML_Core.ToField(myTestData, myTestDataNF);
ML_Core.ToField(myTrainAData, myTrainDataANF);
ML_Core.ToField(myTestAData, myTestDataANF);

EXPORT convertLR :=  MODULE
  EXPORT myIndTrainDataNF := myTrainDataNF(number < 6); //independent
  EXPORT myDepTrainDataNF := PROJECT(myTrainDataNF(number = 6), 
                                     TRANSFORM(ML_Core.Types.DiscreteField, 
                                               SELF.number := 1,
                                               SELF := LEFT)); // dependent 
  EXPORT myIndTestDataNF := myTestDataNF(number < 6); // Number is the field number
  EXPORT myDepTestDataNF := PROJECT(myTestDataNF(number = 6), 
                                    TRANSFORM(ML_Core.Types.DiscreteField, 
                                              SELF.number := 1,
                                              SELF := LEFT));

  EXPORT myIndTrainDataANF := myTrainDataANF(number < 6); // Number is the field number
  EXPORT myDepTrainDataANF := PROJECT(myTrainDataANF(number = 6), 
                                    TRANSFORM(ML_Core.Types.DiscreteField, 
                                              SELF.number := 1,
                                              SELF := LEFT));
  EXPORT myIndTestDataANF := myTestDataANF(number < 6); // Number is the field number
  EXPORT myDepTestDataANF := PROJECT(myTestDataANF(number = 6), 
                                    TRANSFORM(ML_Core.Types.DiscreteField, 
                                              SELF.number := 1,
                                              SELF := LEFT));
END;




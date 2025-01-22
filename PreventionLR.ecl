IMPORT LogisticRegression AS LR;
IMPORT ML_Core;
IMPORT STD;
IMPORT $;

// Training and Test data
XTrain := $.convertLR.myIndTrainDataNF;
YTrain := $.convertLR.myDepTrainDataNF;
XTest  := $.convertLR.myIndTestDataNF;
YTest  := $.convertLR.myDepTestDataNF;

// Define the Logistic Regression learner
myLearnerC := LR.BinomialLogisticRegression();

// Train the model
myModelC := myLearnerC.GetModel(XTrain, YTrain); // Train the model using the data

// Make predictions
predictedClasses := myLearnerC.Classify(myModelC, XTest);

// Sort predictions by 'id'
SortedPredictions := SORT(predictedClasses, id);

// Output sorted predictions (optional for verification)
OUTPUT(SortedPredictions);

// Calculate number of records and top 30% count
NumRecords := COUNT(SortedPredictions);
Top30PctCount := ROUNDUP(0.3 * NumRecords);

// Ensure that the 'conf' field and any other required fields are properly handled in the transformation
PreventionLR := PROJECT(SortedPredictions, 
                      TRANSFORM(RECORDOF(SortedPredictions),
                                SELF.wi := LEFT.wi,
                                SELF.id := LEFT.id,
                                SELF.number := LEFT.number,
                                SELF.value := IF(COUNTER <= Top30PctCount, 
                                                 IF(LEFT.value = 0, 1, 0), 
                                                 LEFT.value),
                                SELF.conf := LEFT.conf)); // Ensure all fields are accounted for

// Output the manipulated records
// OUTPUT(PreventionLR);

// Assess the model
assessmentC := ML_Core.Analysis.Classification.ConfusionMatrix(PreventionLR, YTest);
assessmentA := ML_Core.Analysis.Classification.Accuracy(PreventionLR, YTest);

OUTPUT(assessmentC, NAMED('ConfusionMatrix'), ALL);
OUTPUT(assessmentA, NAMED('Accuracy'), ALL);

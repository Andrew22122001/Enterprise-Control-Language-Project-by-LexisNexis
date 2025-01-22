IMPORT LogisticRegression AS LR;
IMPORT ML_Core;
IMPORT $;

// Training and Test data
XTrain := $.convertLR.myIndTrainDataANF;
YTrain := $.PredictLR;

XTest  := $.convertLR.myIndTestDataANF;
YTest  := $.convertLR.myDepTestDataANF;

// Define the Logistic Regression learner
myLearnerC := LR.BinomialLogisticRegression();

// Train the model
myModelC := myLearnerC.getModel(XTrain, YTrain);

// Make predictions
predictedClasses := myLearnerC.Classify(myModelC, XTest);

// output(predictedClasses);

// Assess the model
assessmentA := ML_Core.Analysis.Classification.Accuracy(predictedClasses, YTest);
assessmentC := ML_Core.Analysis.Classification.ConfusionMatrix(predictedClasses, YTest);

// Output the results
OUTPUT(assessmentC, NAMED('ConfusionMatrix'), ALL);
OUTPUT(assessmentA, NAMED('Accuracy'), ALL);

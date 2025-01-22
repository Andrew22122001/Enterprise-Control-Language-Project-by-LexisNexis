IMPORT LogisticRegression AS LR;
IMPORT ML_Core;
IMPORT STD;
IMPORT $;

XTrain := $.convertLR.myIndTrainDataNF; // Features
YTrain := $.convertLR.myDepTrainDataNF; // Labels

// Test data for original model
XTest := $.convertLR.myIndTestDataNF; // Features
YTest := $.convertLR.myDepTestDataNF; // Labels

// Query data for original model
XQuery := $.convertLR.myIndTrainDataANF;
YQuery := $.convertLR.myDepTrainDataANF;

myLearnerC := LR.BinomialLogisticRegression();

myModelC := myLearnerC.getModel(XTrain, YTrain); // Train the model using training data

predictedClasses := myLearnerC.Classify(myModelC, XTest); // Test the model

//Output(predictedClasses);
// Query the model using a query dataset
// Export PredictLR := myLearnerC.Classify(myModelC, XQuery);



assessmentC := ML_Core.Analysis.Classification.ConfusionMatrix(predictedClasses, YTest);
assessmentA := ML_Core.Analysis.Classification.Accuracy(predictedClasses, YTest);

OUTPUT(assessmentC, NAMED('ConfusionMatrix'), ALL);
OUTPUT(assessmentA, NAMED('Accuracy'), ALL);

// MyBeta := LR.ExtractBeta(myModelC);
// OUTPUT(MyBeta,NAMED('BetaValues'));
// MyScores := LR.LogitScore(MyBeta, Xtest);
// OUTPUT(MyScores ,NAMED('ScoreValues')) ;
// MyDeviance := LR. Deviance_Detail (YTest, MyScores);
// OUTPUT(MyDeviance,NAMED('DevianceValues'));
// MyAIC := LR.Model_Deviance(MyDeviance, MyBeta) ;
// OUTPUT(MyAIC,NAMED('AIC'));
//////////////////////////////////////////////////////////////////////////////////////////////////////////////


/*import LogisticRegression as LR;
IMPORT ML_Core;
IMPORT STD;
IMPORT $;

XTrain := $.convertLR.myIndTrainDataNF; //features
YTrain := $.convertLR.myDepTrainDataNF; //labels

//test data for original model
XTest  := $.convertLR.myIndTestDataNF; //features
YTest  := $.convertLR.myDepTestDataNF; //labels

//query data for original model
XQuery := $.convertLR.myIndTrainDataANF;
YQuery := $.convertLR.myDepTrainDataANF;

myLearnerC := LR.BinomialLogisticRegression();

myModelC := myLearnerC.getModel(XTrain, YTrain); //train the model using training data, here we need to give both dependent and independent features

predictedClasses := myLearnerC.Classify(myModelC, XTest); // test the model

// query the model using a query dataset
//EXPORT MyPredict := myLearnerC.Classify(myModelC, XQuery);

assessmentC := LR.Confusion(YTest,predictedClasses);
assessmentA := LR.BinomialConfusion(assessmentC);

OUTPUT(assessmentC, NAMED('ConfusionMatrix'), ALL);
OUTPUT(assessmentA, NAMED('Accuracy'), ALL);*/


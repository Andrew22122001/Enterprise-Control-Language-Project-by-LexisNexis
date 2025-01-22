IMPORT $;
IMPORT Visualizer;
// Visualize the training and testing data
OUTPUT($.prepLR.myTrainData, NAMED('TrainingData'));
Visualizer.MultiD.column('TrainDataChart',,'TrainingData');

OUTPUT($.prepLR.myTestData, NAMED('TestingData'));
Visualizer.MultiD.column('TestDataChart',,'TestingData');

// Visualize the attack model data
OUTPUT($.prepLR.myTrainAta, NAMED('TrainAtaData'));
Visualizer.MultiD.column('TrainAtaChart',,'TrainAtaData');

OUTPUT($.prepLR.myTestAta, NAMED('TestAtaData'));
Visualizer.MultiD.column('TestAtaChart',,'TestAtaData');
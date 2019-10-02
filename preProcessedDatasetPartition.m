function [file_name1_1,file_name3_1,file_name2_1]=preProcessedDatasetPartition(balancedDatset,partition)
    %preProcessedBalancedDataset=textPreprocessing2(balancedDatset);
    [train,validation,test]=datasetPartition(balancedDatset,partition);
    classTrain=categorical(train.class);
    classValidation=categorical(validation.class);
    classTest=categorical(test.class);
    [preProcessedTrain,classTrainAfterPreprocess]=textPreprocessing(train,classTrain);
    [preProcessedValidation,classValidationAfterPreprocess]=textPreprocessing(validation,classValidation);
    [preProcessedTest,classTestAfterPreprocess]=textPreprocessing(test,classTest);
    class=classTrainAfterPreprocess;
    tweet=preProcessedTrain;
    table1 = table(tweet,class);
    file_name1_1=sprintf('train.csv');
    out1=fullfile('',file_name1_1);%% 
    writetable(table1,out1);
    
    class=classValidationAfterPreprocess;
    tweet=preProcessedValidation;
    table3 = table(tweet,class);
    file_name3_1=sprintf('validation.csv');
    out1=fullfile('',file_name3_1);%% 
    writetable(table3,out1);
    
    class=classTestAfterPreprocess;
    tweet=preProcessedTest;
    table2 = table(tweet,class);
    file_name2_1=sprintf('test.csv');
    out1=fullfile('',file_name2_1); 
    writetable(table2,out1);
end
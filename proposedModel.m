%% 
clear;
rng('default'); 
fileID = fopen('parameters.txt');
C = textscan(fileID,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','Delimiter','\n');
data=readStringdData(C{1}{1});
embedding=C{2}{1};
datasetDividePercent=str2double(C{3}{1});
trainWordEmbeddingModel=C{4}{1};
wordEmbeddingDimension=str2double(C{5}{1});
trainTestPercent=str2double(C{6}{1});
%sequenceLength=str2double(C{7}{1});
numFilters=str2double(C{7}{1});
noOfConvReluMaxLayers=str2double(C{8}{1});
windowSize=readdData(C{9}{1});
padding=str2double(C{10}{1});
dropOutLayerPercent=str2double(C{11}{1});
noOfFC=str2double(C{12}{1});
fcSize=readdData(C{13}{1});
solver=C{14}{1};
maxEpoch=str2double(C{15}{1});
miniBatchSize=str2double(C{16}{1});
numIterationsPerEpoch=str2double(C{17}{1});
fclose(fileID);
%% 
balancedDatset=mergeDataset(data); 
partition=(100-trainTestPercent)/100;
[train,validation,test]=preProcessedDatasetPartition(balancedDatset,partition);
maximumSequenceLength=chooseSequenceLength(train);
sequenceLength=maximumSequenceLength;
%% 
if((embedding==lower("fastText")) || wordEmbeddingDimension==300)
    embedding=fastTextWordEmbedding;
elseif((embedding==lower("glove")) && wordEmbeddingDimension==25)
    embedding=readWordEmbedding('glove.twitter.27B.25d.txt');    
elseif((embedding==lower("glove")) && wordEmbeddingDimension==50)
    embedding=readWordEmbedding('glove.twitter.27B.50d.txt');
elseif((embedding==lower("glove")) && wordEmbeddingDimension==100)
    embedding=readWordEmbedding('glove.twitter.27B.100d.txt');
elseif((embedding==lower("glove")) && wordEmbeddingDimension==200)
    embedding=readWordEmbedding('glove.twitter.27B.200d.txt'); 
elseif((embedding==lower("own")))    
    %embedding=ownTrainedEmbedding(balancedDatset,trainWordEmbeddingModel,wordEmbeddingDimension);
    embedding=trainWordEmbedding(normalizeWords(removeStopWords(tokenizedDocument(balancedDatset.tweet)),'style','lemma'),'Model',trainWordEmbeddingModel,'Dimension',wordEmbeddingDimension);
    %embedding=trainWordEmbedding(removeStopWords(tokenizedDocument(balancedDatset.tweet)),'Model',trainWordEmbeddingModel,'Dimension',wordEmbeddingDimension);
elseif((embedding==lower("googlenews")))    
    embedding=load('GoogleNews_words.mat');    
else
    disp('Word embdedding is must. Insert Name of Word Embedding')
end
%% 
[cnnOnlyModel,cnnRecallTrain,cnnPrecisionTrain,cnnF1Train,cnnRecallValidation,cnnPrecisionValidation,cnnF1Validation,cnnRecallTest,cnnPrecisionTest,cnnF1Test,fcTrain,fcValidation,fcTest]=cnnClassifierModelWithAdjustableParameters(train,validation,test,embedding,sequenceLength,numFilters,windowSize,noOfConvReluMaxLayers,padding,dropOutLayerPercent,noOfFC,fcSize,solver,maxEpoch,miniBatchSize,numIterationsPerEpoch);
%% 
allData=table;
allData.data=C{1}{1};
allData.embedding=C{2}{1};
allData.wordEmbeddingDimension=wordEmbeddingDimension;
allData.trainWordEmbeddingModel=trainWordEmbeddingModel;
allData.trainTestPartitionRatio=trainTestPercent;
allData.numFilters=numFilters;
allData.noOfConvReluMaxLayers=noOfConvReluMaxLayers;
allData.windowSize=C{9}{1};
allData.padding=padding;
allData.dropOutLayerPercent=dropOutLayerPercent;
allData.noOfFCLayers=noOfFC;
allData.fcSizes=C{13}{1};
allData.solver=solver;
allData.maxEpoch=maxEpoch;
allData.miniBatchSize=miniBatchSize;
allData.numIterationsPerEpoch=numIterationsPerEpoch;
allData.cnnRecallTrain=cnnRecallTrain;
allData.cnnPrecisionTrain=cnnPrecisionTrain;
allData.cnnF1Train=cnnF1Train;
allData.cnnRecallValidation=cnnRecallValidation;
allData.cnnPrecisionValidation=cnnPrecisionValidation;
allData.cnnF1Validation=cnnF1Validation;
allData.cnnRecallTest=cnnRecallTest;
allData.cnnPrecisionTest=cnnPrecisionTest;
allData.cnnF1Test=cnnF1Test;
%% 
fn='Performance Report for CNN_differnet.csv';
windowSizeString=convertToSPecificFormatForCSV(C{9}{1});
fcSizeString=convertToSPecificFormatForCSV(C{13}{1});
if isfile(fn)
    fid = fopen(fn,'a');
    fprintf( fid, '%s,%s,%d,%s,%d,%d,%d,%s,%d,%f,%d,%s,%s,%d,%d,%d,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',allData.data,allData.embedding,allData.wordEmbeddingDimension,allData.trainWordEmbeddingModel,allData.trainTestPartitionRatio,allData.numFilters,allData.noOfConvReluMaxLayers,windowSizeString,allData.padding,allData.dropOutLayerPercent,allData.noOfFCLayers,fcSizeString,allData.solver,allData.maxEpoch,allData.miniBatchSize,allData.numIterationsPerEpoch,allData.cnnRecallTrain,allData.cnnPrecisionTrain,allData.cnnF1Train,allData.cnnRecallValidation,allData.cnnPrecisionValidation,allData.cnnF1Validation,allData.cnnRecallTest,allData.cnnPrecisionTest,allData.cnnF1Test);
    fclose(fid);
else
    cHeader = {'data' 'embedding' 'embeddingDimension' 'trainWordEmbeddingModel' 'trainPercent' 'noOfFilter' 'noOfConvReluMaxLayers' 'windowSize' 'padding' 'dropOutPercent' 'noOfFcLayer' 'fcSize' 'solver' 'maxEpoch' 'miniBtachSize' 'numIterations' 'cnnRecallTrain' 'cnnPrecisionTrain' 'cnnF1Train' 'cnnRecallValidation' 'cnnPrecisionValidation' 'cnnF1Validation' 'cnnRecallTest' 'cnnPrecisionTest' 'cnnF1Test'}; %dummy header
    commaHeader = [cHeader;repmat({','},1,numel(cHeader))]; %insert commaas
    commaHeader = commaHeader(:)';
    textHeader = cell2mat(commaHeader); %cHeader in text with commas
    %write header to file
    fid = fopen(fn,'a'); 
    fprintf(fid,'%s\n',textHeader);
    fprintf( fid, '%s,%s,%d,%s,%d,%d,%d,%s,%d,%f,%d,%s,%s,%d,%d,%d,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',allData.data,allData.embedding,allData.wordEmbeddingDimension,allData.trainWordEmbeddingModel,allData.trainTestPartitionRatio,allData.numFilters,allData.noOfConvReluMaxLayers,windowSizeString,allData.padding,allData.dropOutLayerPercent,allData.noOfFCLayers,fcSizeString,allData.solver,allData.maxEpoch,allData.miniBatchSize,allData.numIterationsPerEpoch,allData.cnnRecallTrain,allData.cnnPrecisionTrain,allData.cnnF1Train,allData.cnnRecallValidation,allData.cnnPrecisionValidation,allData.cnnF1Validation,allData.cnnRecallTest,allData.cnnPrecisionTest,allData.cnnF1Test);
    fclose(fid);
end
%% 
%[oneClassOnlyModel,oneClassRecallTrain,oneClassPrecisionTrain,oneClassF1Train,oneClassRecallValidation,oneClassPrecisionValidation,oneClassF1Validation,oneClassRecallTest,oneClassPrecisionTest,oneClassF1Testt]=cnnClassifierModelWithAdjustableParameters(balancedDatset,datasetDividePercent);
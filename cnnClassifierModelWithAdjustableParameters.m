function [cnnNet,cnnRecallTrain,cnnPrecisionTrain,cnnF1Train,cnnRecallValidation,cnnPrecisionValidation,cnnF1Validation,cnnRecallTest,cnnPrecisionTest,cnnF1Test,fcTrain,fcValidation,fcTest]=cnnClassifierModelWithAdjustableParameters(train,validation,test,emb,sequenceLength,numFilter,windowSize,noOfConvReluMaxLayers,padding,dropOutLayerPercent,noOfFC,fcSize,solver,maxEpoch,sizeMiniBatch,numIterations)
    textName = "tweet";
    labelName="class";
    ttdsTrain = tabularTextDatastore(train,'SelectedVariableNames',[textName labelName]); 
    ttdsValidation = tabularTextDatastore(validation,'SelectedVariableNames',[textName labelName]); 
    ttdsTest = tabularTextDatastore(test,'SelectedVariableNames',[textName labelName]);
    classTrain = readLabels(ttdsTrain,labelName);
    classValidation = readLabels(ttdsValidation,labelName);
    classTest = readLabels(ttdsTest,labelName);
    classNames = unique(classTrain);
    tdsTrain = transform(ttdsTrain, @(data) transformTextDataGloveEmbed(data,sequenceLength,emb,classNames));
    tdsValidation = transform(ttdsValidation, @(data) transformTextDataGloveEmbed(data,sequenceLength,emb,classNames));
    tdsTest = transform(ttdsTest, @(data) transformTextDataGloveEmbed(data,sequenceLength,emb,classNames));
    
    numObservations = numel(classTrain); 
    numFeatures = emb.Dimension;
    inputSize = [1 sequenceLength numFeatures];
    numFilters = numFilter;
    ngramLengths = windowSize;
    numBlocks = noOfConvReluMaxLayers;
    numClasses = numel(classNames);
    miniBatchSize = sizeMiniBatch;
    numIterationsPerEpoch = numIterations;
    FCsizes=fcSize;
    l1=length(windowSize);
    
    layer = imageInputLayer(inputSize,'Normalization','none','Name','input');
    lgraph = layerGraph(layer);
    C=1;
    l=length(ngramLengths);
    for j = 1:numBlocks
        %for k=1:l
            if(l1==1)
                N = ngramLengths(1);
            else
                N = ngramLengths(j);
            end
            %pad=round((N-1)/2);
            block = [
                convolution2dLayer([1 N],numFilters,'Name',"conv"+C,'Padding','same')
                %batchNormalizationLayer('Name',"bn"+C)
                reluLayer('Name',"relu"+C)
                %dropoutLayer(dropOutLayerPercent,'Name',"drop"+C)
                %maxPooling2dLayer([1 sequenceLength],'Name',"max"+C)
                %maxPooling2dLayer([N N],'Name',"max"+C)
            ];

            lgraph = addLayers(lgraph,block);
            lgraph = connectLayers(lgraph,'input',"conv"+C);
            C=C+1;
        %end
    end
    layer=[depthConcatenationLayer(numBlocks,'Name','depth')];
    lgraph = addLayers(lgraph,layer);
    C=1;
    t=length(FCsizes);
    for j = 1:noOfFC
        %for k=1:t
            N = FCsizes(j);
            layers = [
                fullyConnectedLayer(N,'Name',"fc"+C)
            ];
            lgraph = addLayers(lgraph,layers);
            %lgraph = connectLayers(lgraph,"fc"+C,"fc"+C);
            C=C+1;
        %end
    end
    C=1;
    for j = 2:noOfFC
        lgraph = connectLayers(lgraph,"fc"+C,"fc"+j);
        C=C+1;
    end
    c=1;
    lgraph = connectLayers(lgraph,"depth/out","fc"+c);    
    layers = [
        softmaxLayer('Name','soft')
        classificationLayer('Name','classification')
    ];
    lgraph = addLayers(lgraph,layers); 
    lgraph = connectLayers(lgraph,"fc"+noOfFC,'soft');    
    
    C=1;
    for j = 1:numBlocks
        %N = ngramLengths(j);
        lgraph = connectLayers(lgraph,"relu"+C,"depth/in"+j);
        C=C+1;
    end
  
    figure
    plot(lgraph)
    title("CNN Architecture")
    %k=lgraph.Layers(2);
    %k = setL2Factor(k,'Weights',3);
        options = trainingOptions(solver, ...    
        'MaxEpochs',maxEpoch, ...
        'Shuffle','never', ...  
        'MiniBatchSize',miniBatchSize, ...
        'ValidationData',tdsValidation, ... 
        'ValidationFrequency',numIterationsPerEpoch,...
        'Verbose',false, ...
        'Plots','training-progress');
        %% 
    %'ValidationFrequency',numIterationsPerEpoch, ...
    cnnNet = trainNetwork(tdsTrain,lgraph,options); 
    cnnPredTrain = classify(cnnNet,tdsTrain);  
    [cnnRecallTrain,cnnPrecisionTrain,cnnF1Train]= scores(classTrain,double(string(cnnPredTrain)));
    fcTrain=featureXtract(cnnNet,tdsTrain,noOfFC);
    %% 
    cnnPredValidation = classify(cnnNet,tdsValidation);
    [cnnRecallValidation,cnnPrecisionValidation,cnnF1Validation]= scores(classValidation,double(string(cnnPredValidation)));
    fcValidation=featureXtract(cnnNet,tdsValidation,noOfFC);
    %% 
    cnnPredTest = classify(cnnNet,tdsTest);
    [cnnRecallTest,cnnPrecisionTest,cnnF1Test]= scores(classTest,double(string(cnnPredTest)));
    fcTest=featureXtract(cnnNet,tdsTest,noOfFC);
    
    
end
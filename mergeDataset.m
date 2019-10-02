function mergeData=mergeDataset(dataset) 
    datasetDirectory = 'dataset\';
    if(length(dataset)==1)
        data=dataset(1);
        if(data=="waseem") 
            dataset=readtable([datasetDirectory,'waseemData.csv'],'TextType','string');% hated text dataset prepared by Davidson et al
            ds1=dataset;
            data_binaryClassification1=convertToTwoClasses(ds1,ds1.Properties.VariableNames{3});
            balancedData1=makeBalanced(data_binaryClassification1,ds1.Properties.VariableNames{3});
            id=[balancedData1.id];
            tweet=[balancedData1.tweet];
            class=[balancedData1.label];
            mergeData = table(id,tweet,class);
        elseif(data=="davidson") 
            dataset=readtable([datasetDirectory,'labeled_data.csv'],'TextType','string');
            ds2=dataset;
            data_binaryClassification2=convertToTwoClasses(ds2,ds2.Properties.VariableNames{6});
            balancedData2=makeBalanced(data_binaryClassification2,ds2.Properties.VariableNames{6});
            %partitionedData=divideDataset(data_binaryClassification2,ds2.Properties.VariableNames{6},percent);
            id=[balancedData2.seq_number];
            tweet=[balancedData2.tweet];
            class=[balancedData2.class];
            mergeData = table(id,tweet,class);
        elseif(data=="stanford")
            dataset=readtable([datasetDirectory,'sentiment140.csv'],'TextType','string');
            ds3=dataset;
            data_binaryClassification3=convertToTwoClasses(ds3,ds3.Properties.VariableNames{1});
            balancedData3=makeBalanced(data_binaryClassification3,ds3.Properties.VariableNames{1});
            header={'id','tweet','class'};
            mergeData = table(balancedData3.Var2,balancedData3.Var6,balancedData3.Var1);
            mergeData.Properties.VariableNames = header;
        end 
    elseif(length(dataset)==2)
        dataset1=dataset(1);
        dataset2=dataset(2);
        if(((dataset1=="waseem") && (dataset2=="davidson")) || ((dataset1=="davidson") && (dataset2=="waseem")))
            dataset1=readtable([datasetDirectory,'waseemData.csv'],'TextType','string');% hated text dataset prepared by Davidson et al
            ds1=dataset1;
            dataset2=readtable([datasetDirectory,'labeled_data.csv'],'TextType','string');% abusive text dataset, cited by most people(after tweet extratoin) prepared by Waseem Zeerak.
            ds2=dataset2;

            data_binaryClassification1=convertToTwoClasses(ds1,ds1.Properties.VariableNames{3});
            balancedData1=makeBalanced(data_binaryClassification1,ds1.Properties.VariableNames{3});
            data_binaryClassification2=convertToTwoClasses(ds2,ds2.Properties.VariableNames{6});
            balancedData2=makeBalanced(data_binaryClassification2,ds2.Properties.VariableNames{6});
            
            id=[balancedData1.id;balancedData2.seq_number];
            tweet=[balancedData1.tweet;balancedData2.tweet];
            class=[balancedData1.label;balancedData2.class];

            mergeData = table(id,tweet,class);
        elseif(((dataset1=="waseem") && (dataset2=="stanford")) || ((dataset1=="stanford") && (dataset2=="waseem")))
            dataset1=readtable([datasetDirectory,'waseemData.csv'],'TextType','string');% hated text dataset prepared by Davidson et al
            ds1=dataset1;
            dataset3=readtable([datasetDirectory,'sentiment140.csv'],'TextType','string');
            ds3=dataset3;
            data_binaryClassification1=convertToTwoClasses(ds1,ds1.Properties.VariableNames{3});
            balancedData1=makeBalanced(data_binaryClassification1,ds1.Properties.VariableNames{3});
            data_binaryClassification3=convertToTwoClasses(ds3,ds3.Properties.VariableNames{1});
            balancedData3=makeBalanced(data_binaryClassification3,ds3.Properties.VariableNames{1});

            id=[balancedData1.id;balancedData3.Var2];
            tweet=[balancedData1.tweet;balancedData3.Var6];
            class=[balancedData1.label;balancedData3.Var1];

            mergeData = table(id,tweet,class);
        elseif(((dataset1=="davidson") && (dataset2=="stanford")) || ((dataset1=="stanford") && (dataset2=="davidson")))
            dataset2=readtable([datasetDirectory,'labeled_data.csv'],'TextType','string');% abusive text dataset, cited by most people(after tweet extratoin) prepared by Waseem Zeerak.
            ds2=dataset2;
            dataset3=readtable([datasetDirectory,'sentiment140.csv'],'TextType','string');
            ds3=dataset3;
            
            data_binaryClassification2=convertToTwoClasses(ds2,ds2.Properties.VariableNames{6});
            balancedData2=makeBalanced(data_binaryClassification2,ds2.Properties.VariableNames{6});
            data_binaryClassification3=convertToTwoClasses(ds3,ds3.Properties.VariableNames{1});
            balancedData3=makeBalanced(data_binaryClassification3,ds3.Properties.VariableNames{1});

            id=[balancedData2.seq_number;balancedData3.Var2];
            tweet=[balancedData2.tweet;balancedData3.Var6];
            class=[balancedData2.class;balancedData3.Var1];
            mergeData = table(id,tweet,class);
        end    
    elseif(length(dataset)==3)
        dataset1=dataset(1);
        dataset2=dataset(2);
        dataset3=dataset(3);
        if(((dataset1=="waseem") && (dataset2=="davidson") && (dataset3=="stanford")) || ((dataset1=="waseem") && (dataset2=="stanford") && (dataset3=="davidson")) || ((dataset1=="stanford") && (dataset2=="waseem") && (dataset3=="davidson")) || ((dataset1=="stanford") && (dataset2=="davidson") && (dataset3=="waseem")) || ((dataset1=="davidson") && (dataset2=="stanford") && (dataset3=="waseem")) || ((dataset1=="davidson") && (dataset2=="waseem") && (dataset3=="stanford")))
            dataset1=readtable([datasetDirectory,'waseemData.csv'],'TextType','string');% hated text dataset prepared by Davidson et al
            ds1=dataset1;
            dataset2=readtable([datasetDirectory,'labeled_data.csv'],'TextType','string');% abusive text dataset, cited by most people(after tweet extratoin) prepared by Waseem Zeerak.
            ds2=dataset2;
            dataset3=readtable([datasetDirectory,'sentiment140.csv'],'TextType','string');
            ds3=dataset3;
            data_binaryClassification1=convertToTwoClasses(ds1,ds1.Properties.VariableNames{3});
            balancedData1=makeBalanced(data_binaryClassification1,ds1.Properties.VariableNames{3});
            data_binaryClassification2=convertToTwoClasses(ds2,ds2.Properties.VariableNames{6});
            balancedData2=makeBalanced(data_binaryClassification2,ds2.Properties.VariableNames{6});
            data_binaryClassification3=convertToTwoClasses(ds3,ds3.Properties.VariableNames{1});
            balancedData3=makeBalanced(data_binaryClassification3,ds3.Properties.VariableNames{1});

            id=[balancedData1.id;balancedData2.seq_number;balancedData3.Var2];
            tweet=[balancedData1.tweet;balancedData2.tweet;balancedData3.Var6];
            class=[balancedData1.label;balancedData2.class;balancedData3.Var1];

            mergeData = table(id,tweet,class);
        end
    else
        disp('Dataset is must. Insert Name of Dataset.')        
        
    end
end
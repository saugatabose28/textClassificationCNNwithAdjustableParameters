function [trinData,validationData,testData]=datasetPartition(data,percent)
    %if(strcmp(label,"class"))
        cvp = cvpartition(data.class,'Holdout',percent);
        trinData_ = data(training(cvp),:);
        testData = data(test(cvp),:);
        
        cvp = cvpartition(trinData_.class,'Holdout',percent);
        trinData = trinData_(training(cvp),:);
        validationData = trinData_(test(cvp),:);
    %elseif(strcmp(label,"label"))
     %   cvp = cvpartition(data.label,'Holdout',percent);
      %  trinData = data(training(cvp),:);
       % testData = data(test(cvp),:);   
    %end    
end
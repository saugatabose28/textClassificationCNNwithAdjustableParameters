function [textData,reducedTrainClass]=textPreprocessing(data,class) 
    %[tokenizedTextData,dict]=tokenizeDocument(data,stopWords);
    %tokenizedTextData_ = tokenizedTextData(~cellfun(@isempty, tokenizedTextData));
    tokenizedTextData_=tokenizeDocument2(data); 
    tokenizedTextData__=cellfun(@isempty,tokenizedTextData_);
    
	[i1,j1] = find(tokenizedTextData__);       
    reducedTrainClass=class;
    reducedTrainClass(i1)=[]; 
    reducedTrain=tokenizedTextData_;
    reducedTrain(i1)=[];     
    [s1,s2]=size(reducedTrain);  
    %for i=1:s1
     %   [s3,s4]=size(reducedTrain{i});
      %  b="";
       % try
        %    for j=1:s3
         %       suggestions=checkSpelling(reducedTrain{i}{j}); 
          %      for k=1:length(suggestions)
           %         b=b+" "+suggestions{k};
            %    end
            %end        
        %catch
         %   i
          %  reducedTrain{i}                
        %end
        %reducedTrain{i}{j}=b;
    %end
    textData=cell(s1,1);    
    for i=1:s1
        textData{i}=strtrim(string(strjoin(reducedTrain{i})));
    end
    %textData=textData1;
   
end
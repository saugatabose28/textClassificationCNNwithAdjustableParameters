function [x]=ownTrainedEmbedding(balancedDatset,trainWordEmbeddingModel,wordEmbeddingDimension)
    textData=(tokenizeDocument2(balancedDatset));
    class=balancedDatset.class;
    %text_=(posText.posTextData);
    text__ = textData(~cellfun(@isempty, textData));
    
    text___=cellfun(@isempty,textData);
    [i1,j1] = find(text___);       
    reducedClass=class;
    reducedClass(i1)=[]; 
    
    [s1,s2]=size(text__);
    textData=cell(s1,1);
    for i=1:s1
        textData{i}=string(strjoin(text__{i}));
        
    end
    x=trainWordEmbedding(tokenizedDocument(textData),'Model',trainWordEmbeddingModel,'Dimension',wordEmbeddingDimension);
end
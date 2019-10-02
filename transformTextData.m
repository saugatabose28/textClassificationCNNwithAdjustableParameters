function dataTransformed = transformTextData(data,sequenceLength,emb,classNames)

% Preprocess documents.
textData = data{:,1};
%textData=lower(textData);
%my addition-1
textData=eraseURLs(regexprep(textData,'[\d@!.()?-;/:_&#_,|}{[]~`''-"%=*$]',''));

documents = removeStopWords(erasePunctuation(normalizeWords(lower(addPartOfSpeechDetails(addEntityDetails(addSentenceDetails(addLemmaDetails(tokenizedDocument((textData))))))))));
%documents = removeStopWords(erasePunctuation((tokenizedDocument((textData)))));

% Convert documents to embeddingDimension-by-sequenceLength-by-1 images.
predictors = doc2sequence(emb,documents,'Length',sequenceLength);

% Reshape images to be of size 1-by-sequenceLength-embeddingDimension.
predictors = cellfun(@(X) permute(X,[3 2 1]),predictors,'UniformOutput',false);

% Read labels.
labels = data{:,2};
responses = categorical(labels,classNames);

% Convert data to table.
dataTransformed = table(predictors,responses);

end
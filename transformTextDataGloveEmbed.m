function dataTransformed = transformTextDataGloveEmbed(data,sequenceLength,emb,classNames)

textData = data{:,1};
% Convert documents to embeddingDimension-by-sequenceLength-by-1 images.
documents=tokenizedDocument(textData);

predictors = doc2sequence(emb,documents,'Length',sequenceLength);

% Reshape images to be of size 1-by-sequenceLength-embeddingDimension.
predictors = cellfun(@(X) permute(X,[3 2 1]),predictors,'UniformOutput',false);

% Read labels.
labels = data{:,2};
responses = categorical(labels,classNames);

% Convert data to table.
dataTransformed = table(predictors,responses);

end
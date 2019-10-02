**For executing the program we need to run the file named: proposedModel.m**
A) Input has been listed in the file, named parameters.txt. The inputs are listed in as follows:
1. Name of Dataset
The value is either a single name or a combination of names seperated by comma. The names are: davidson, waseem and stanford
example1: davidson
example2: davidson, waseem
example3: davidson, waseem, stanford
b) Name of Embedding:
The value will be a string. Name of the embedding models implemented in the project: The names are: glove, fasttext and another embedding which was trained on the working dataset named as own
example1: glove
example2: fasttext
example3: own
c) Percentage by which the balanced dataset will be divided between hated tweet and non hated tweets. This value is an integer value. This variable will only be activated during calcualtion of one class classification.
example1: 50
d) Word Embedding Model for "own" word embedding:
The models which have been used for training our own word embedding are skipgram and cbow.
example1: skipgram
example2: cbow
e) Dimension of Word Embedding:
The dimension is an integer number. 
example1: 25(for glove embedding having 25 dimension)
example2: 50(for glove embedding having 50 dimension)
example3: 100(for glove embedding having 100 dimension)
example4: 200(for glove embedding having 200 dimension)
example5: 300(for fasttext embedding having 300 dimension)
example6: any integer value (for own word embedding having any dimension)
f) Percentage by which a train-validatin-test set will be created. It is an integer number
example1: 80(80% train data and 20% test data. Later, the train data will be divided as 80% train data and 20% validation data)
g) Number of filters:
It is an integer number
h) Number of convolution-relu-dropout-max layers/number of n-grams
The value is an integer number.
i) Window Size:
The window size of the convolutiona layer. The value is an integer or list of integers
example1: 4
example2: 3,4(it will only workable if number of n-grams is 2) 
example3: 2,3,4(it will only workable if number of n-grams is 3)
j) Padding:
The value is an integer only. Though in my program I have used padding vale 'same' as I have encounterd that the padding values crash the cnn architecture(in my case)
k) Percentage of drop out layer value
It is a real number
example1: 0.3
l) Number of Fully Connected Layers
It is an integer number
m) Sizes of Fully Connected Layer
The value is an integer or list of integers. The value/last value of the FC should be equal to the number of classes
example1: 2
example2: 100,200,2
n) Solving Algorithm
The value for solving algorithm is either 'adam' or 'sgdm' or 'rmsprop'
o) Number of Epochs
The value is an integer
p) Mini Batch Size:
The value is an integer
q) Number of iterations per epoch
The value is an integer
B) The result will be stored automatically in the file named, 'Performance Report for CNN_differnet.csv'

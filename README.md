**For executing the program we need to run the file named: proposedModel.m**
<br>A) Input has been listed in the file, named parameters.txt. The inputs are listed in as follows:
1. Name of Dataset
The value is either a single name or a combination of names seperated by comma. The names are: davidson, waseem and stanford
<br>example1: davidson
<br><br>example2: davidson, waseem
<br><br>example3: davidson, waseem, stanford
2. N<br>ame of Embedding:
The <br>value will be a string. Name of the embedding models implemented in the project: The names are: glove, fasttext and another embe<br>dding which was trained on the working dataset named as own
<br><br>example1: glove
<br>example2: fasttext
<br>example3: own
3. Percentage by which the balanced dataset will be divided between hated tweet and non hated tweets. This value is an integer value. This variable will only be activated during calcualtion of one class classification.
<br>example1: 50
4. Word Embedding Model for "own" word embedding:
The models which have been used for training our own word embedding are skipgram and cbow.
<br>example1: skipgram
<br>example2: cbow
5. Dimension of Word Embedding:
The dimension is an integer number. 
<br>example1: 25(for glove embedding having 25 dimension)
<br>example2: 50(for glove embedding having 50 dimension)
<br>example3: 100(for glove embedding having 100 dimension)
<br>example4: 200(for glove embedding having 200 dimension)
<br>example5: 300(for fasttext embedding having 300 dimension)
<br>example6: any integer value (for own word embedding having any dimension)
6. Percentage by which a train-validatin-test set will be created. It is an integer number
<br>example1: 80(80% train data and 20% test data. Later, the train data will be divided as 80% train data and 20% validation data)
7. Number of filters:
<br>It is an integer number
8. Number of convolution-relu-dropout-max layers/number of n-grams
<br>The value is an integer number.
9. Window Size:
The window size of the convolutiona layer. The value is an integer or list of integers
<br>example1: 4
<br>example2: 3,4(it will only workable if number of n-grams is 2) 
<br>example3: 2,3,4(it will only workable if number of n-grams is 3)
10. Padding:
<br>The value is an integer only. Though in my program I have used padding vale 'same' as I have encounterd that the padding values crash the cnn architecture(in my case)
11. Percentage of drop out layer value
It is a real number
<br>example1: 0.3
12. Number of Fully Connected Layers
It is an integer number
13. Sizes of Fully Connected Layer
The value is an integer or list of integers. The value/last value of the FC should be equal to the number of classes
<br>example1: 2
<br>example2: 100,200,2
14. Solving Algorithm
The value for solving algorithm is either 'adam' or 'sgdm' or 'rmsprop'
15. Number of Epochs
The value is an integer
16. Mini Batch Size:
The value is an integer
17. Number of iterations per epoch
The value is an integer
<br>
<br> B) The result will be stored automatically in the file named, 'Performance Report for CNN_differnet.csv'

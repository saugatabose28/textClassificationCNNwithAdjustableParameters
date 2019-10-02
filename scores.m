function [accuracy,recall,precision,f_measure]=scores(ACTUAL,PREDICTED)
    %[C1,order]=confusionmat(actual,pred)
    %plotConfMat(C1)
    %recall1=zeros(1,size(C1,1));
    %precision1=zeros(1,size(C1,1));
    %for j=1:size(C1,1)
    %    recall1(j)=C1(j,j)/sum(C1(j,:));
    %end
    %recall_hate_class=recall1(1);
    %for j=1:size(C1,1)
    %    precision1(j)=C1(j,j)/sum(C1(:,j));
    %end
    %precision_hate_class=precision1(1);
    %average_recall_train1=(sum(recall1)/size(C1,1));
    %average_precision_train1=(sum(precision1)/size(C1,1));
    %average_F1_train1=2*average_recall_train1*average_precision_train1/(average_recall_train1+average_precision_train1);
    %accuracy = sum(pred == actual)/numel(actual);
    fig = figure;
    cm = confusionchart(ACTUAL,PREDICTED,'RowSummary','row-normalized','ColumnSummary','column-normalized');

    fig_Position = fig.Position;
    fig_Position(3) = fig_Position(3)*1.5;
    fig.Position = fig_Position;
    
    idx = (ACTUAL()==1);
    p = length(ACTUAL(idx));
    n = length(ACTUAL(~idx));
    N = p+n;
    tp = sum(ACTUAL(idx)==PREDICTED(idx));
    tn = sum(ACTUAL(~idx)==PREDICTED(~idx));
    fp = n-tn;
    fn = p-tp;
    tp_rate = tp/p;
    tn_rate = tn/n;
    accuracy = (tp+tn)/N;
    sensitivity = tp_rate;
    specificity = tn_rate;
    precision = tp/(tp+fp);
    recall = sensitivity;
    f_measure = 2*((precision*recall)/(precision + recall));
    gmean = sqrt(tp_rate*tn_rate);
    
end
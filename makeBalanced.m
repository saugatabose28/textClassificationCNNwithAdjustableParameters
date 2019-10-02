function new=makeBalanced(data,labelName)
    
    if(strcmp(labelName,"class"))
        data=sortrows(data,'class','ascend');
        A=sum(data.class==0);%for davidson dataset
        [C,D]=size(data);
        B=A*2;
        new=data(1:B,1:D);
    elseif(strcmp(labelName,"label"))
        data=sortrows(data,'label','descend');
        A=sum(data.label==1);%for kaggle dataset
        [C,D]=size(data);
        B=A*2;
        new=data(1:B,1:D);
        new.label(new.label==1)=-1;
        new.label(new.label==0)=1;
        new.label(new.label==-1)=0;
    else
        data=sortrows(data,'Var1','ascend');
        A=sum(str2double(data.Var1)==0);%for davidson dataset
        [C,D]=size(data);
        B=A*2;
        new=data(1:B,1:D);
    end    
end
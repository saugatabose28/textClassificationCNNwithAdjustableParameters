function [T1]=divideDataset(data,percent)
    %if(strcmp(labelName,"class"))
        data4=sortrows(data,'class','ascend'); 
        %[C,D]=size(data4); 
        %A=sum(data4.class==0); 
        %A_=round((A*percent)/100); 
        %B=C-A_;
        %rest=100-percent;
        %B_=round((B*rest)/100);        %% 
        % after sampling, the new train dataset
        %tr1=data4(1:A_,1:D);
        %tr2=data4((A+1):(A+B_),1:D);
        %T1=[tr1;tr2];
        
        [r,s]=size(data4);
        id=find((data4.class)>0,1);
        r0=(id-1);
        r1=round(((r0)*percent)/100);
        XT=data4(1:r1,1:s);
        
        rest=100-percent;
        t=(r-id)+1;
        r1_=round((t*rest)/100);       
        v=(id+r1_)-1;
        XO=data4(id:v,1:s);
        T1=[XT;XO];
    %end
    %% 
    % after sampling, the new test/validation dataset
    %te1=data4((A_+1):A,1:D);
    %te2=data4((A+B_+1):C,1:D);
    %T2=[te1;te2];
    %% 
    %if(percent==100)
     %   [s1,s2]=size(T1);
      %  [s3,s4]=size(T2);
       % x1=s1-10;
        %T11=T1(1:x1,1:s2);
        %T12=T1(x1+1:s1,1:s2);
        %T1=T11;
        
        %x2=s3-10;
        %T2=T2(1:x2,1:s4);
        %T2=[T12;T2];
        %[s1,s2]=size(T1);
        %[s3,s4]=size(T2);
        %if(s3>s1)
         %   x3=s3-500;
          %  T2=T2(1:x3,1:s4);
        %end
    %end
    
end
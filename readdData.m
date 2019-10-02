function B= readdData(data)
    
    tokens = regexprep(data,',',' ');    
    x=strsplit(tokens);
    [a,b]=size(x);
    %B=zeros(a,b);
    if(b==1)
        B=[str2double(x{:})];
        return;
    end
    c=1;
    for i=1:b
        B(i)=str2double(x{i});
        c=c+1;
    end
end
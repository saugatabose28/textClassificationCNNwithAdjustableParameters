function B= readStringdData(data)
    
    tokens = regexprep(data,',',' ');    
    x=strsplit(tokens);
    [a,b]=size(x);
    B=strings(a,b);
    for i=1:b
        B(i)=(x{i});        
    end
end
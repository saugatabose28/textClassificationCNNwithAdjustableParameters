function B=convertToSPecificFormatForCSV(data)
    tokens = regexprep(data,',',' ');    
    x=strsplit(tokens);
    [a,b]=size(x);
    B=zeros(a,b);
    c=1;
    B="";
    if(b~=1)
        for i=1:b
            B=B+string(x{i})+"and";        
        end
    end
end
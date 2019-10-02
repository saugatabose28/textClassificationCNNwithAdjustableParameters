function x= readdData(data)
    tokens = regexprep(data,',',' ');
    x = tokens(cellfun(tokens==','));
end
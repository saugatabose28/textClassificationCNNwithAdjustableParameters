function x=convertToTwoClasses(data,labelName)
    if(strcmp(labelName,'class'))
        data.class(data.class>=1)=1;
        x=data;
    elseif(strcmp(labelName,'label'))
        data.label(data.label>=1)=1;
        x=data;
    else
        data.Var1(str2double(data.Var1)>=1)=1;
        x=data;
    end
end
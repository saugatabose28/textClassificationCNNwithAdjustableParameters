function x=featureXtract(net,data,c)
    layer = "fc"+c;
    features = activations(net,data,layer);% output of fully connected layer are extracted
    x=squeeze(features);
    x=x';
end
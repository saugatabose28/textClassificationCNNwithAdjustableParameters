function x=chooseSequenceLength(train)
    a=readtable(train,'TextType','string');
    documentLengths = doclength(tokenizedDocument(a.tweet));
    figure
    histogram(documentLengths)
    title("Document Lengths")
    xlabel("Length")
    ylabel("Number of Documents")
    x=max(documentLengths);
end
function [encoded_message] = myHuffmanEncode(source,dictionary)

alphabet_source = "";
encoded_message = "";
for i=1:numel(source)
     alphabet_source(i) = char(source(i));  % convert string source into char representation
end

for i=1:numel(source)
    index = find(contains(dictionary,alphabet_source(i)));  % find index location of source letter in our dictionary
    coding = dictionary(index,2);                           % get the letter binary coding from the dictionary
    [m,n] = size(coding);
    if (m~=0)
        encoded_message = strcat(encoded_message,coding);   % add binary coding to the encoded message 
    end
end

end


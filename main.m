function main()
tic;
% Create Symbols and Probabilities Arrays
format short;
symbols = 'a':'z';
huffman_symbols_array = strings(1,numel(symbols));
for i=1:numel(symbols)
    huffman_symbols_array(i) = convertCharsToStrings(symbols(i));
end
huffman_symbols_array = huffman_symbols_array.';
prob = [8.167, 1.492, 2.782, 4.253, 12.702, 2.228, 2.015, 6.094, 6.966, 0.153, 0.772, 4.025, 2.406, ...
       6.749, 7.507, 1.929, 0.095, 5.987, 6.328, 9.056, 2.758, 0.978, 2.360, 0.150, 1.974, 0.074]/100;  
huffman_prob = prob.';                

% Create Source A
alphabet = "";
for i=1:numel(symbols)
    alphabet{i} = symbols(i);
end
letter_indices = randsrc(1,10000,[1:numel(alphabet); prob]);
sourceA_string = [alphabet{letter_indices}];
sourceA = strings(1,strlength(sourceA_string));
for i=1:strlength(sourceA_string)
    sourceA(1,i) = sourceA_string(i);
end

% Create Source B
fid = fopen('kwords.txt');
file_txt = fscanf(fid,'%s',Inf);
fclose(fid);
temp_sourceB = lower(file_txt); % Convert uppercase letters to lowercase

accepted_iterations = 0;
for i=1:numel(temp_sourceB)     % getting rid of 274 irrelevant symbols
    if temp_sourceB(1,i) ~= "'" && temp_sourceB(1,i) ~= "-" && temp_sourceB(1,i) ~= "." && temp_sourceB(1,i) ~= "/"
       accepted_iterations = accepted_iterations + 1;
       sourceB_string(1,accepted_iterations) = temp_sourceB(1,i);
    end
end
sourceB = strings(1,strlength(sourceB_string));
for i=1:strlength(sourceB_string)
    sourceB(1,i) = sourceB_string(1,i);
end

%---------------------------------- Bullet 2 -----------------------------------------% 

fprintf("\n[------------RUNNING METRICS FOR BULLET [2/5]------------]\n");

% Huffman Dictionary
fprintf("Creating Huffman Dictionary with wikipedia probabilities...\n");
bullet2_dict = myHuffmanDictionary(huffman_symbols_array,huffman_prob);

% Find Average Letter Coding Length
letter_coding_lengths = zeros(numel(symbols),1);
average_code_length = 0;
for i=1:numel(symbols)
    letter_coding_lengths(i,1) = strlength(bullet2_dict{i,2});
    average_code_length = average_code_length + huffman_prob(i,1)*letter_coding_lengths(i,1);
end
fprintf("Average Code Length : %.2f bits/symbol\n",average_code_length);

% Huffman Encoding 
fprintf("Creating Encoded Message for Source A...\n");
my_encoded_message_A = myHuffmanEncode(sourceA,bullet2_dict);
fprintf("Creating Encoded Message for Source B...\n");
my_encoded_message_B = myHuffmanEncode(sourceB,bullet2_dict);
fprintf("Length for Source A encoded message : %d bits\n",strlength(my_encoded_message_A));
fprintf("Length for Source B encoded message : %d bits\n",strlength(my_encoded_message_B));

% Huffman Decoding
fprintf("Creating Decoded Message for Source A...\n");
my_decoded_message_A = myHuffmanDecode(my_encoded_message_A,bullet2_dict);
fprintf("Creating Decoded Message for Source B...\n");
my_decoded_message_B = myHuffmanDecode(my_encoded_message_B,bullet2_dict);

% Validation Checking
if isequal(sourceA,my_decoded_message_A) 
    fprintf("[OK!] Decoded Message is identical with Source A!\n")
else
    fprintf(2,"[ERROR!] Decoding DOES NOT MATCH with Source A!\n");
end
if isequal(sourceB,my_decoded_message_B) 
    fprintf("[OK!] Decoded Message is identical with Source B!\n")
else
    fprintf(2,"[ERROR!] Decoding DOES NOT MATCH with Source B!\n");
end

%---------------------------------- Bullet 3 -----------------------------------------% 

fprintf("\n[------------RUNNING METRICS FOR BULLET [3/5]------------]\n");

% Find new probabilities from kwords.txt
file_prob = zeros(1,numel(symbols));
for i=1:numel(symbols)
    file_prob(1,i) = length(strfind(sourceB_string,symbols(i)))/numel(sourceB);
end
huffman_prob = file_prob.';

% Re-create Huffman Dictionary using new probabilities discovered
fprintf("Creating Huffman Dictionary with new probabilities from kwords.txt...\n");
bullet3_dict = myHuffmanDictionary(huffman_symbols_array,huffman_prob);

% Find Average Letter Coding Length
letter_coding_lengths = zeros(numel(symbols),1);
average_code_length = 0;
for i=1:numel(symbols)
    letter_coding_lengths(i,1) = strlength(bullet3_dict{i,2});
    average_code_length = average_code_length + huffman_prob(i,1)*letter_coding_lengths(i,1);
end
fprintf("Average Code Length : %.2f bits/symbol\n",average_code_length);

% Huffman Encoding 
fprintf("Creating Encoded Message for Source B...\n");
my_encoded_message_B = myHuffmanEncode(sourceB,bullet3_dict);
fprintf("Length for Source B encoded message : %d bits\n",strlength(my_encoded_message_B));

% Huffman Decoding
fprintf("Creating Decoded Message for Source B...\n");
my_decoded_message_B = myHuffmanDecode(my_encoded_message_B,bullet3_dict);

% Validation Checking
if isequal(sourceB,my_decoded_message_B) 
    fprintf("[OK!] Decoded Message is identical with Source B!\n")
else
    fprintf(2,"[ERROR!] Decoding DOES NOT MATCH with Source B!\n");
end
    
%---------------------------------- Bullet 4 -----------------------------------------%  

fprintf("\n[------------RUNNING METRICS FOR BULLET [4/5]------------]\n");

%Create Extended Source A and Probabilities
huffman_extended_symbols_A = "";
huffman_extended_prob = zeros(1,numel(symbols));
pair_loops = 0;
for i=1:numel(symbols)
    for j=1:numel(symbols)
        pair_loops = pair_loops + 1;
        huffman_extended_symbols_A(pair_loops) = strcat(symbols(i),symbols(j));
        huffman_extended_prob(1,pair_loops) = prob(1,i)*prob(1,j);
    end
end
for i=1:numel(huffman_extended_symbols_A)
    extended_alphabet{i} = huffman_extended_symbols_A(i);
end
letter_indices = randsrc(1,5000,[1:numel(extended_alphabet); huffman_extended_prob]);
huffman_extended_symbols_A = huffman_extended_symbols_A.';
huffman_extended_prob = huffman_extended_prob.';
extended_source_A = [extended_alphabet{letter_indices}];

%Create extended Huffman Dictionary for 16*26 = 676 symbols
fprintf("Creating Extended Huffman Dictionary...\n");
bullet4_dict = myHuffmanDictionary(huffman_extended_symbols_A,huffman_extended_prob);

% Find Average Letter Coding Length
letter_coding_lengths = zeros(numel(huffman_extended_symbols_A),1);
average_code_length = 0;
for i=1:numel(huffman_extended_symbols_A)
    letter_coding_lengths(i,1) = strlength(bullet4_dict{i,2});
    average_code_length = average_code_length + huffman_extended_prob(i,1)*letter_coding_lengths(i,1);
end
fprintf("Average Code Length : %.2f bits/symbol\n",average_code_length);

fprintf("Creating Encoded Message for extended Source A...\n");
my_encoded_message_A = myHuffmanEncode(extended_source_A,bullet4_dict);

fprintf("Length for Source A encoded message : %d bits\n",strlength(my_encoded_message_A));

fprintf("Creating Decoded Message for extended Source A...\n");
my_decoded_message_A = myHuffmanDecode(my_encoded_message_A,bullet4_dict);

if isequal(extended_source_A,my_decoded_message_A) 
    fprintf("[OK!] Decoded Message is identical with extended Source A!\n")
else
    fprintf(2,"[ERROR!] Decoding DOES NOT MATCH with extended Source A!\n");
end

%---------------------------------- Bullet 5 -----------------------------------------%

fprintf("\n[------------RUNNING METRICS FOR BULLET [5/5]------------]\n");

% Re-create Source B as 2 character pairs pair source index
new_sourceB = strings(1,numel(sourceB_string)/2);
counter=0;
for i=1:numel(sourceB_string)/2
    if i==1
        new_sourceB(i) = strcat(sourceB_string(i),sourceB_string(i+1));
    else
        counter = counter + 1;
        new_sourceB(i) = strcat(sourceB_string(i+counter),sourceB_string(i+counter+1));
    end
end

fprintf("Using Extended Huffman Dictionary from BULLET 4...\n");
bullet5_dict = bullet4_dict;

fprintf("Creating Encoded Message for Source B...\n");
my_encoded_message_B = myHuffmanEncode(new_sourceB,bullet5_dict);
fprintf("Length for Source B encoded message : %d bits\n",strlength(my_encoded_message_B));

fprintf("Creating Decoded Message for Source B...\n");
my_decoded_message_B = myHuffmanDecode(my_encoded_message_B,bullet5_dict);

if isequal(new_sourceB,my_decoded_message_B) 
    fprintf("[OK!] Decoded Message is identical with Source B!\n")
else
    fprintf(2,"[ERROR!] Decoding DOES NOT MATCH with Source B!\n");
end

% Find new probabilities by checking in kwords.txt file
file_prob2 = zeros(1,numel(huffman_extended_symbols_A));
for i=1:numel(huffman_extended_symbols_A)       
    file_prob2(1,i) = length(strfind(sourceB_string,huffman_extended_symbols_A(i)))/numel(sourceB);
end
huffman_extended_prob2 = file_prob2.';

fprintf("Creating Extended Huffman Dictionary...\n");
bullet5_dict = myHuffmanDictionary(huffman_extended_symbols_A,huffman_extended_prob2);

% Find Average Letter Coding Length
letter_coding_lengths = zeros(numel(huffman_extended_symbols_A),1);
average_code_length = 0;
for i=1:numel(huffman_extended_symbols_A)
    letter_coding_lengths(i,1) = strlength(bullet5_dict{i,2});
    average_code_length = average_code_length + huffman_extended_prob2(i,1)*letter_coding_lengths(i,1);
end
fprintf("Average Code Length : %.2f bits/symbol\n",average_code_length);

fprintf("Creating Encoded Message for Source B...\n");
my_encoded_message_B = myHuffmanEncode(new_sourceB,bullet5_dict);
fprintf("Length for Source B encoded message : %d bits\n",strlength(my_encoded_message_B));

fprintf("Creating Decoded Message for Source B...\n");
my_decoded_message_B = myHuffmanDecode(my_encoded_message_B,bullet5_dict);

if isequal(new_sourceB,my_decoded_message_B) 
    fprintf("[OK!] Decoded Message is identical with Source B!\n")
else
    fprintf("[ERROR!] Decoding DOES NOT MATCH with Source B!\n");
end

fprintf("\n[------------SIMULATION COMPLETED------------]\n");
toc;
end
function [huffman_dictionary] = myHuffmanDictionary(huffman_symbols_array,probabilities)

search_term = huffman_symbols_array;        % keep a backup of the initial symbols array
[n,m] = size(huffman_symbols_array);
huffman_probabilities_array = zeros(n,1);   % keep a backup of the initial prob/ties array
encodings = strings(n,n);                   % array that will have all 0 & 1 in its cells    
coding_array = strings(1,n);                % array to store all binary codings
index_symbol = zeros(n,n);                  % array to store alphabet occurances in huffman array

for i=1:n
    huffman_probabilities_array(i,1) = probabilities(i,1);
end

% Sort the first (1) column of both arrays
[huffman_symbols_array,huffman_probabilities_array] = sortArray(huffman_symbols_array,huffman_probabilities_array,n,1);

for column=1:(n-1)
    huffman_probabilities_array(:,column+1) = huffman_probabilities_array(:,column);    % Copy current (left) column to the right column
    huffman_symbols_array(:,column+1) = huffman_symbols_array(:,column);                % Copy current (left) column to the right colum
    [huffman_symbols_array,huffman_probabilities_array] = sortArray(huffman_symbols_array,huffman_probabilities_array,n,column);    % Sort current column  
    [huffman_symbols_array,huffman_probabilities_array] = sortArray(huffman_symbols_array,huffman_probabilities_array,n,column+1);  % Sort next column
   % non_zero_probs = nnz(huffman_probabilities_array(:,column));                        % find number of cells that have non zero probability
    positions_to_consider = sum(huffman_probabilities_array(:,column) ~= -1);            % find number of cells that have probabilities that we should consider
    if (positions_to_consider-1 ~= -1)
        last_probability = huffman_probabilities_array(positions_to_consider,column);          % get the probability at the last column position
        pre_last_probability = huffman_probabilities_array(positions_to_consider-1,column);    % get the probability at the pre-last column position
        huffman_probabilities_array(positions_to_consider,column+1) = -1;                       % on the next column, the last non-zero value becomes -1, so it is discared 
        huffman_probabilities_array(positions_to_consider-1,column+1) = last_probability + pre_last_probability;   % on the next column, the pre-last non zero value is now a sum
        last_symbol = huffman_symbols_array(positions_to_consider,column);                     % get the last symbol in column
        pre_last_symbol=huffman_symbols_array(positions_to_consider-1,column);                 % get the pre-last symbol in column
        huffman_symbols_array(positions_to_consider,column+1) = ' ';                           % on the next column, last symbol is deleted
        concat_symbols = strcat(last_symbol,'|',pre_last_symbol);                              % on the next column, pre-last symbol is concatenated with other symbols of same path
        huffman_symbols_array(positions_to_consider-1,column+1) = concat_symbols;              % save concatenation on the next column
        encodings(positions_to_consider,column)="1";                                           % last non zero position has encoding = 0
        encodings(positions_to_consider-1,column)="0";                                         % pre-last non zero position has encoding = 1
    end
end

for i=1:n
    search_symbol = convertCharsToStrings(search_term(i));                     % convert each alphabet symbol into characters
    index_symbol(:,i) = find(contains(huffman_symbols_array,search_symbol));   % save occurances of each alphabet symbols in index_symbol array
end

for cell_index = 1:numel(huffman_symbols_array)                         % loop through all characters in huffman array
    if (encodings(cell_index)=="1" || encodings(cell_index)=="0")       % only consider symbols that have '0' or '1' as encoding (so save time!)
        for counter=1:n
            for checking = 1:size(index_symbol(:,counter))              % loop through all index position
                if (index_symbol(checking,counter) == cell_index)       % if indices match                        
                    coding_array(1,counter) = strcat(coding_array(1,counter),encodings(cell_index));    % add bit (0 or 1) to the coding array of that symbol
                end
            end
        end
    end
end

coding_array = reverse(coding_array);       % reverse all binary codings to get the correct representations

huffman_dictionary = strings(n,2);
for i=1:n
    huffman_dictionary(i,1) = search_term(i);       % first column has all alphabet symbols (either "a" or "aa" e.t.c)
    huffman_dictionary(i,2) = coding_array(1,i);    % second column has all binary codings (such as "10101" e.t.c)
end

end
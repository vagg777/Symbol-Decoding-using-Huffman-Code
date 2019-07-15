function [huffman_symbols_array,huffman_probabilities_array] = sortArray(huffman_symbols_array,huffman_probabilities_array,n,column)

for j=1:(n-1)
    for i=1:(n-1)
        if huffman_probabilities_array(i,column) < huffman_probabilities_array(i+1,column)
            temp_prob = huffman_probabilities_array(i,column);
            huffman_probabilities_array(i,column) = huffman_probabilities_array(i+1,column);
            huffman_probabilities_array(i+1,column) = temp_prob;
            temp_symb = huffman_symbols_array(i,column);
            huffman_symbols_array(i,column) = huffman_symbols_array(i+1,column);
            huffman_symbols_array(i+1,column) = temp_symb;
        end
    end
end

end
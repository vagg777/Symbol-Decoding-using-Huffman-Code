function [decoded_message] = myHuffmanDecode(encoded_message,dict)

encoded_message = char(encoded_message);    % convert to char to access characters of the string
decoded_string = "";
current_message = "";
decoded_message = "";
letters_found=0;
found=0;
[dict_size_x, dict_size_y] = size(dict);
for i=1:numel(encoded_message)
     found=0;
     current_message = strcat(current_message,encoded_message(i));  % keep constructing a binary message
     index = find(contains(dict,current_message));                  % find index location of current binary message in dictionary
     dict_index = dict(index);                                      % save the index 
     [m,n] = size(dict_index);  
     for j=1:m
         if (found == 0)
             if strlength(current_message) == strlength(dict_index(j,1))    % if we have a match
                found=1;                                                    % found = 1, do not check again in here
                letters_found = letters_found+1;                            % count the found letters
                text_letter_index = find(strcmp(dict,dict_index(j,1)));     % get the letter index
                text_letter = dict(text_letter_index-dict_size_x);          % get the letter  
                decoded_message(letters_found) = text_letter;               % add the letter to the decoded message
                current_message = "";                                       % reset the binary message
             end
         end
     end
end

end


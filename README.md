# Symbol Decoding using Huffman Code #




## 1. What is this repository for? ##

* The purpose of this project is to study the coding methodology of discrete sources in Digital Telecommunications that follow Huffman Coding.
* Our proposed model is able to compress artificial sources (e.g. random generated characters), as well as real-life sources (e.g. files that include English words).
* The model has been developed using `MATLAB` programming language. 



## 2. How is the project structured? ##

* `Source A`is a distinct memory-free source (DMS) that, based on input probabilities, contains random lowercase characters of the English alphabet. Its representation in our code is a table (`1 x 1000`), where in each cell we store the random letter of the alphabet that emerged based on the chances of occurrence. The encoding of `Source A`, since we have already created the Huffman alphabet, is for each different experiment we perform, a binary representation of approximately `42,000` digits (if randomly generated each time, the encoding length for the characters whose binary representation is in the alphabet Huffman is variable in each execution). 
    * With an average code length of `4.21 digits/symbol` and `10,000` symbols in `Source A`, having a coded message equal to `42,014` digits is a fully expected result and in theory is completely acceptable. 
    * The decoding of the encoded binary message creates a source, which in each of its positions contains the character of the alphabet for which it found precise encoding in the Huffman alphabet. 

* `Source B` is an information source with data from a text file of `3,857` English words beginning with the character `k`. In order to be able to encode `Source B` correctly, we will need to filter the source information so that uppercase and lowercase characters are not taken into account in creating the final table of `Source B` that we will use, as they do not define binary representation. from the Huffman alphabet table. Source B is therefore a representation of the text file, in which all characters are lowercase (lowercase -> uppercase conversion) and all sorts of special characters are missing, with each position in the final table (`1 x 19,110`) of `Source B` being used for a single character of the English alphabet. The encoding of `Source B`, since we have already created the Huffman alphabet, is for each different experiment we perform, a binary representation of exactly `135,482 ` digits. 
    * With an average code length of `4,21 digits/symbol` and `29,110` symbols in `Source B`, we should hypothetically have a coded message equal to `122,553` digits, which is a deviation of `12,929` symbols! 
    * Contributing to the increased coding length is the fact that all words start with the character `k`, which according to Wikipedia, has the 22nd worst performance in character probability (equal to `0,77%`) out of a total of 26 characters and in combination with the fact that the Huffman algorithm depicts the most frequently occurring fixed-length output sequences with smaller binary sequences, and the longer binary sequences are used in the less frequently referenced source sequences, the binary representation of the symbol k is `1101100`. 
    * This representation is a representation of `7` digits and so we have a non-optimal character representation in binary format, which in the file given to us, has the maximum probability of occurrence (equal to `15.6%`) and we choose to represent it with a relatively long code length, since the data mining for the odds does not come from a real estimate in the file, but from an external predefined source. 
    * The decoding of the encoded binary message creates a source, which in each of its positions contains the character of the alphabet for which it found precise encoding in the Huffman alphabet.
    

* `MyHuffmanDictionary()` function calculates coding words that Huffman Coding based on an alphabet input as a symbol source and the correspoding probabilities for this source.

	* In the case of randomly generated characters, character probabilities of the English Alphabet derive from here : https://en.wikipedia.org/wiki/Letter_frequency
	* In the case of english words, probabilities are calculated by reading the external file and calculating character occurances.
	* By default, Huffman coding requires constant sorting of the tree that includes the probabilities/coding bits pairs, a secondary function **sortArray** is used to sort the tree repetively.
    * In the end, the **MyHuffmanDictionary** functions creates a `huffman_dictionary` matrix that includes alphabet symbols and their binary coding.


* `MyHuffmanEncode()` function uses as input the equivalent discrete source (e.g. `SourceA` corresponds to randomly generated characters and `SourceB` corresponds to the external file) and the `huffman_dictionary` matrix.

    * The function converts string input into characters and generates an `encoded_message` in binary representation.
    

* `MyHuffmanDecode()` function uses as input the `encoded_message` from **myHuffmanEncode** function and the `huffman_dictionary` matrix and reveals the initial string representation of the source.

* `main()` function is the top-level functions that calls the necessary sub-functions mentioned above and initiates the simulation.

    * At first, the **main** function builds `SourceA` and `SourceB` for the simulation.
    * After creating the `huffman_dictionary`, we then use both `SourceA` and `SourceB` as sources for encoding.
    * After encoding both sources into 2 different binary streams, **myHuffmanDecode** function is used to retrieve the initial source message.
    * If the decoded message is identical with the equivalent source message, the whole procedure is marked as successful.
    





## 3. Running the simulations... ##

* **Bullet [2/5]** :
	- Creates Huffman Dictionary based on the probabilities of the English Alphabet derive from here : https://en.wikipedia.org/wiki/Letter_frequency
	- Calculates Average Coding Length
	- Creates encoding message (as a binary stream) for `SourceA`
	- Creates encoding message (as a binary stream) for `SourceB`
	- Decodes message for `SourceA` and validates if the message matches initial `SourceA` message
	- Decodes message for `SourceB` and validates if the message matches initial `SourceB` message
	- The Huffman Dictionary should look like the table below:

        | Number  | Symbol | Binary Representation |
        |----|---|-----------|
        | 1  | a | 0001      |
        | 2  | b | 001111    |
        | 3  | c | 10110     |
        | 4  | d | 00000     |
        | 5  | e | 011       |
        | 6  | f | 11010     |
        | 7  | g | 001100    |
        | 8  | h | 1001      |
        | 9  | i | 0100      |
        | 10 | j | 110110100 |
        | 11 | k | 1101100   |
        | 12 | l | 00001     |
        | 13 | m | 11000     |
        | 14 | n | 0101      |
        | 15 | o | 0010      |
        | 16 | p | 001110    |
        | 17 | q | 110110110 |
        | 18 | r | 1010      |
        | 19 | s | 1000      |
        | 20 | t | 10111     |
        | 21 | u | 10110     |
        | 22 | v | 110111    |
        | 23 | w | 11001     |
        | 24 | x | 110110101 |
        | 25 | y | 001101    |
        | 26 | z | 110110111 |

* **Bullet [3/5]** :
	- Creates Huffman Dictionary based on the character probabilities (occurances) from `kwords.txt` file
	- Calculates Average Coding Length
	- Creates encoding message (as a binary stream) for `SourceA`
	- Creates encoding message (as a binary stream) for `SourceB`
	- Decodes message for `SourceA` and validates if the message matches initial `SourceA` message
	- Decodes message for `SourceB` and validates if the message matches initial `SourceB` message
	- The Huffman Dictionary should look like the table below:

        | Number  | Symbol | Binary Representation |
        |----|---|-----------|
        | 1  | a | 0001      |
        | 2  | b | 100010    |
        | 3  | c | 000000     |
        | 4  | d | 000001    |
        | 5  | e | 101       |
        | 6  | f | 1000110    |
        | 7  | g | 010000    |
        | 8  | h | 10000     |
        | 9  | i | 111     |
        | 10 | j | 010011110 |
        | 11 | k | 001   |
        | 12 | l | 1101     |
        | 13 | m | 000011    |
        | 14 | n | 0101     |
        | 15 | o | 0110      |
        | 16 | p | 010010    |
        | 17 | q | 0100111111 |
        | 18 | r | 1100     |
        | 19 | s | 0111      |
        | 20 | t | 1001     |
        | 21 | u | 000010    |
        | 22 | v | 1000111    |
        | 23 | w | 0100110     |
        | 24 | x | 0100111110 |
        | 25 | y | 010001    |
        | 26 | z | 01001110 |

* **Bullet [4/5]** :
	- Creates the next level extended extended `SourceA` by considering as character alphabets every character pair (e.g. 'aa', 'ff', 'gr'), a total of 676 symbols
	- Creates Huffman Dictionary based on the probabilities that derive from the multiplication of each character in the pair
	- Calculates Average Coding Length
	- Creates encoding message (as a binary stream) for extended `SourceA`
	- Decodes message for `SourceA` and validates if the message matches initial extended `SourceA` message

* **Bullet [5/5]** :
	- Creates the next level extended extended `SourceB` by considering as character alphabets every character pair (e.g. 'aa', 'ff', 'gr'), a total of 676 symbols
	- Uses Huffman Dictionary based on the probabilities that derive from Bullet [4/5]
	- Calculates Average Coding Length
	- Creates encoding message (as a binary stream) for extended `SourceB`
	- Decodes message for `SourceB` and validates if the message matches initial extended `SourceB` message
	- Creates Huffman Dictionary based on the character probabilities (occurances) from kwords.txt file
	- Calculates Average Coding Length
	- Creates encoding message (as a binary stream) for extended `SourceB`
	- Decodes message for `SourceB` and validates if the message matches initial extended `SourceB` message
	
* A typical simulation should look like this:

    ![alt text](https://i.imgur.com/qNVRuZe.png)

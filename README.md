# README.md #




## What is this repository for? ##

* The purpose of this project is to study the coding methodology of discrete sources in Digital Telecommunications that follow Huffman Coding.
* Our proposed model is able to compress artificial sources (e.g. random generated characters), as well as real-life sources (e.g. files that include English words).
* The model has been developed using MATLAB programming language. 



## How is the project structured? ##

* The model uses 3 different functions in order to successfully implement Huffman Coding. 

* **MyHuffmanDictionary** function calculates coding words that Huffman Coding based on an alphabet input as a symbol source and the correspoding probabilities for this source.

	> In the case of randomly generated characters, character probabilities of the English Alphabet derive from here : https://en.wikipedia.org/wiki/Letter_frequency

	> In the case of english words, probabilities are calculated by reading the external file and calculating character occurances.

	> By default, Huffman coding requires constant sorting of the tree that includes the probabilities/coding bits pairs, a secondary function **sortArray** is used to sort the tree repetively.

    > In the end, the **MyHuffmanDictionary** functions creates a `huffman_dictionary` matrix that includes alphabet symbols and their binary coding.

* **myHuffmanEncode** function uses as input the equivalent discrete source (e.g. `SourceA` corresponds to randomly generated characters and `SourceB` corresponds to the external file) and the `huffman_dictionary` matrix.

    > The function converts string input into characters and generates an `encoded_message` in binary representation.

* **myHuffmanDecode** function uses as input the `encoded_message` from **myHuffmanEncode** function and the `huffman_dictionary` matrix and reveals the initial string representation of the source.


* **main** function is the top-level functions that calls the necessary sub-functions mentioned above and initiates the simulation.

    > At first, the **main** function builds `SourceA` and `SourceB` for the simulation.

    > `Bullet 2` refers to the simulation where we create the `huffman_dictionary` with the wikipedia probabilities...

    > After creating the `huffman_dictionary`, we then use both `SourceA` and `SourceB` as sources for encoding.

    > After encoding both sources into 2 different binary streams, **myHuffmanDecode** function is used to retrieve the initial source message.
 
    > If the decoded message is identical with the equivalent source message, the whole procedure is marked as successful.

    > A typical simulation should look like this:

    ![alt text](https://i.imgur.com/qNVRuZe.png)




## A few things about the simulations... ##

* Bullet [2/5] :
	- Creates Huffman Dictionary based on the probabilities of the English Alphabet derive from here : https://en.wikipedia.org/wiki/Letter_frequency
	- Calculates Average Coding Length
	- Creates encoding message (as a binary stream) for `SourceA`
	- Creates encoding message (as a binary stream) for `SourceB`
	- Decodes message for `SourceA` and validates if the message matches initial `SourceA` message
	- Decodes message for `SourceB` and validates if the message matches initial `SourceB` message

* Bullet [3/5] :
	- Creates Huffman Dictionary based on the character probabilities (occurances) from kwords.txt file
	- Calculates Average Coding Length
	- Creates encoding message (as a binary stream) for `SourceA`
	- Creates encoding message (as a binary stream) for `SourceB`
	- Decodes message for `SourceA` and validates if the message matches initial `SourceA` message
	- Decodes message for `SourceB` and validates if the message matches initial `SourceB` message

* Bullet [4/5] :
	- Creates the next level extended extended `SourceA` by considering as character alphabets every character pair (e.g. 'aa', 'ff', 'gr'), a total of 676 symbols
	- Creates Huffman Dictionary based on the probabilities that derive from the multiplication of each character in the pair
	- Calculates Average Coding Length
	- Creates encoding message (as a binary stream) for extended `SourceA`
	- Decodes message for `SourceA` and validates if the message matches initial extended `SourceA` message

* Bullet [5/5] :
	- Creates the next level extended extended `SourceB` by considering as character alphabets every character pair (e.g. 'aa', 'ff', 'gr'), a total of 676 symbols
	- Uses Huffman Dictionary based on the probabilities that derive from Bullet [4/5]
	- Calculates Average Coding Length
	- Creates encoding message (as a binary stream) for extended `SourceB`
	- Decodes message for `SourceB` and validates if the message matches initial extended `SourceB` message
	- Creates Huffman Dictionary based on the character probabilities (occurances) from kwords.txt file
	- Calculates Average Coding Length
	- Creates encoding message (as a binary stream) for extended `SourceB`
	- Decodes message for `SourceB` and validates if the message matches initial extended `SourceB` message
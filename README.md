# README.md #





## What is this repository for? ##

* The purpose of this project is to study the coding methodology of discrete sources in Digital Telecommunications that follow Huffman Coding.
* Our proposed model is able to compress artificial sources (e.g. random generated characters), as well as real-life sources (e.g. files that include English words).
* The model has been developed using MATLAB programming language. 



## How is the project structured? ##

* The model . 

* We do not have permissions to access anything on the site unless we login.

* Since this is a Company Management Site, the `Login Page` **DOES NOT OFFER** a `Register` option.

	> Why? If any random person could quickly create an account, he would have instant access to our database!!!

* For the `Login Confirmation`, no external plugin was used.

	> A linear search is executed in the `database` and a message is returned upon success or failure.
        
* When we finally login to the site, we are redirected to the `Home Page`, where a welcome message is shown, notifying the user about the contents of the site. 

* To access the `Employee` and `Department` Tables, the `Navigation Bar` on top of the site must be used.





## A few things about managing the site... ##

* For the `Employee` Table, you can :
	- Add a new `employee`
    - Update an existing `employee`
    - Delete an existing `employee`
    - Sort the Table with `Ascending` or `Descending` Order

* For the `Department` Table, you can :
	- Add a new `department`
    - Update an existing `department`
    - Delete an existing `department`
    - Sort the Table with `Ascending` or `Descending` Order

* Both Tables are sortable thanks to the `Tablesorter Plugin ` by Christian Bach.

	> Plugin's Documentation : http://tablesorter.com/docs/

	> Plugin's Project Path : `web-app/js/Tablesorter`

* To make Table Management easier, a `Scrollbar` has been added to both tables.

	> Why? To make our lives easier when we have a large amount of data to manage!!!

* Every `input` field in the site has `autocomplete = OFF` to avoid input data being completed by its own.

	> Why? If `autocomplete = ON` for the login form, it would be very easy for anyone to login, knowing just the first letter a random `username`, since the `password` would be autocompleted!!!
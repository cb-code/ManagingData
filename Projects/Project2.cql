--------------------------------------------------------------------------------
					Project 2 | Expanded Cassandra DB
					Sem: Fall 20 | 5400 Managing Data 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
					UNI: chb2132 | Name: C. Blanchard
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
1| Chosen interface: 'CQL notebook'
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
2| Expanded Keyspace Design
--------------------------------------------------------------------------------

Expanded Cassandra Digital Library-

	Keyspace will now have four column-families:

		2.1| ebooks
		
		2.2| users

		2.3| checkouts

		2.4| comments
			-Virtual library of Assignment 4 has added a new social media feature
			-Users can now post and view comments about books they have checked out

	----------------------------------------------------------------------------
	2.1| Column-Family: ebooks
	----------------------------------------------------------------------------

		Each row contains all of the specified information on each book:

			1| Book_id
				TYPE INT: PRIMARY KEY

			2| Title
				TYPE TEXT

			3| primary_author
				TYPE TEXT

			4| secondary_authors (if any)
				TYPE LIST: ORDERED ELEMENT COLLECTION (since author names)

			5| publication_date
				TYPE DATE

			6| page_count
				TYPE INT

			7| publisher
				TYPE TEXT

			8| translator (if any)
				TYPE TEXT

			For non-fiction books:

			9| key_topics (list)
				TYPE SET: UNORDERED ELEMENT COLLECTION

			For works of fiction (incl. poems, plays, novels, story collections):

			9| key_topics: 'Fiction'
				TYPE SET: UNORDERED ELEMENT COLLECTION
			
	----------------------------------------------------------------------------
	2.2| Column-Family: users
	----------------------------------------------------------------------------

		Each row contains all of the specified information on each user:

			1| User_id
				TYPE INT: PRIMARY KEY

			2| Name
				TYPE TEXT

			3| phone
				TYPE TEXT

			4| address
				TYPE TEXT

			5| university_affiliation (if any)
				TYPE TEXT

	----------------------------------------------------------------------------
	2.3| Column-Family: checkouts
	----------------------------------------------------------------------------

		Each row contains a checkout event. Columns include:

			1| Event_id
				TYPE INT: PRIMARY KEY

			2| User_id: user(User_id)
				TYPE INT

			3| Name: user(Name)
				TYPE TEXT

			4| university_affiliation: users(university_affiliation)
				TYPE TEXT

			5| Book_id: ebooks(Book_id)
				TYPE INT

			6| Title: ebooks(Title)
				TYPE TEXT

			7| key_topics: ebooks(key_topics)
				TYPE SET: UNORDERED ELEMENT COLLECTION

			8| Checkout_start: date of checkout, start of rental period
				TYPE DATE

			9| Checkout_end: end of rental period/book expiration date
				TYPE DATE

			[Note: Checkout_end is pre-set to 30 days after Checkout_start]

	----------------------------------------------------------------------------
	2.4| Column-Family: comments
	----------------------------------------------------------------------------

		Each row contains an instanced user comment on a particular book.
		Columns for the comments column-family collection include:

			1| Comment_id
				TYPE INT: PRIMARY KEY

			2| User_id
				TYPE INT

			3| Name: users(Name)
				TYPE TEXT

			4| Book_id
				TYPE INT

			5| Title: ebooks(Title)
				TYPE TEXT

			6| Comment_date: the date of the comment posting
				TYPE DATE : PRIMARY KEY

			7| Comment_val: the actual text provided as the user comment
				TYPE TEXT

--------------------------------------------------------------------------------
2| KEYSPACE [CODE]
--------------------------------------------------------------------------------

	CREATE KEYSPACE CuVirtualLibrary WITH REPLICATION = {
			'class' : 'SimpleStrategy',
			'replication_factor' : 1
	};

--------------------------------------------------------------------------------
3| COLUMN FAMILY [CODE]
--------------------------------------------------------------------------------

	USE CuVirtualLibrary;

		CREATE TABLE ebooks(
			Book_id int,
			Title text,
			primary_author text,
			secondary_authors list<text>,
			publication_date date,
			page_count int,
			publisher text,
			translator text,
			key_topics set<text>,
			primary key (Book_id)
		);

		CREATE TABLE users(
			User_id int,
			Name text,
			phone text,
			address text,
			university_affiliation text,
			primary key (User_id)
		);

		CREATE TABLE checkouts(
			Event_id int,
			User_id int,
			Name text,
			university_affiliation text,
			Book_id int,
			Title text,
			key_topics set<text>,
			Checkout_start date,
			Checkout_end date,
			primary key (Event_id)
		);

		CREATE TABLE comments(
			Comment_id int,
			User_id int,
			Name int,
			Book_id int,
			Title text,
			Comment_date date,
			Comment_val text,
			primary key (Comment_id, Comment_date)
		);


--------------------------------------------------------------------------------
4| CODE [COLLECTION VALUE INSERTION]
--------------------------------------------------------------------------------

	----------------------------------------------------------------------------
	4.1| BOOK VALUE INSERTION [CODE]
	----------------------------------------------------------------------------

	USE CuVirtualLibrary;

	// Inserting ebook values:

	INSERT INTO ebooks(Book_id, Title, primary_author, secondary_authors, 
			publication_date, page_count, publisher, translator, key_topics)
		VALUES(116, 'ML for Dummies', 'Roaree', ['Alma Mater'], '2000-01-01', 
			209, 'Columbia Press', 'Lee Bollinger', {'Machine Learning'});

	INSERT INTO ebooks(Book_id, Title, primary_author, secondary_authors, 
			publication_date, page_count, publisher, key_topics)
		VALUES(42, 'Intro To Algorithms', 'Lemon Schubert', ['Alfred Schwartz'], 
			'1990-03-15', 1415, 'Springer', {'Machine Learning'});

	INSERT INTO ebooks(Book_id, Title, primary_author, secondary_authors, 
			publication_date, page_count, publisher, key_topics)
		VALUES(1984, 'Brave New World', 'Big Brother', ['Little Sister'], 
			'1948-11-20', 404, 'Penguin Press', {'Fiction'});

	----------------------------------------------------------------------------
	4.2| USER VALUE INSERTION [CODE]
	----------------------------------------------------------------------------

	USE CuVirtualLibrary;

	// Inserting user values:

	INSERT INTO users(User_id, Name, phone, address, university_affiliation)
		VALUES(1, 'Phineas Schmirtz', '212-222-2121', '2900 Broadway Avenue', 
			'Pace University');

	INSERT INTO users(User_id, Name, phone, address, university_affiliation)
		VALUES(2, 'Ferb Schmirtz', '212-333-2334', '2900 Broadway Avenue', 
			'Pace University');

	INSERT INTO users(User_id, Name, address)
		VALUES(3, 'Kanye West', '5050 Broadway Avenue');

	INSERT INTO users(User_id, Name, phone, address, university_affiliation)
		VALUES(4, 'Ruth Bader Ginsburg', '212-555-5324', '1 Broad Street', 
			'Columbia University');

	INSERT INTO users(User_id, Name, phone, address, university_affiliation)
		VALUES(5, 'Mister Bean', '1-800-888-1443', '1337 McBean Rd', 
			'Beaner University');

	----------------------------------------------------------------------------
	4.3| CHECKOUT EVENT VALUE INSERTION [CODE]
	----------------------------------------------------------------------------

	USE CuVirtualLibrary;

	// Inserting checkout values:

	INSERT INTO checkouts(Event_id, User_id, Name, university_affiliation, 
			Book_id, Title, key_topics, Checkout_start, Checkout_end)
		VALUES(1, 5, 'Mister Bean', 'Beaner University', 116, 'ML For Dummies', 
			{'Machine Learning'}, '2020-03-02', '2020-04-01');

	INSERT INTO checkouts(Event_id, User_id, Name, university_affiliation, 
			Book_id, Title, key_topics, Checkout_start, Checkout_end)
		VALUES(2, 5, 'Mister Bean', 'Beaner University', 42, 
			'Intro To Algorithms', {'Machine Learning'}, '2020-03-12',
			'2020-04-12');

	INSERT INTO checkouts(Event_id, User_id, Name, university_affiliation, 
			Book_id, Title, key_topics, Checkout_start, Checkout_end)
		VALUES(3, 3, 'Kanye West', 116, 'ML For Dummies', {'Machine Learning'}, 
			'2020-03-15', '2020-04-15');

	INSERT INTO checkouts(Event_id, User_id, Name, university_affiliation, 
			Book_id, Title, key_topics, Checkout_start, Checkout_end)
		VALUES(4, 5, 'Mister Bean', 'Beaner University', 1984, 'Brave New World', 
			{'Fiction'}, '2020-03-21', '2020-04-21');

	INSERT INTO checkouts(Event_id, User_id, Name, university_affiliation, 
			Book_id, Title, key_topics, Checkout_start, Checkout_end)
		VALUES(5, 2, 'Ferb Schmirtz', 'Pace University', 42, 
			'Intro To Algorithms', {'Machine Learning'}, '2020-04-01',
			'2020-05-01');

	----------------------------------------------------------------------------
	4.4| USER COMMENTS VALUE INSERTION [CODE]
	----------------------------------------------------------------------------

	USE CuVirtualLibrary;

	// Inserting user comments values:

	----------------------------------------------------------------------------
	/*INSERT INTO checkouts(Event_id, User_id, Name, university_affiliation, 
			Book_id, Title, key_topics, Checkout_start, Checkout_end)
		VALUES(1, 5, 'Mister Bean', 'Beaner University', 116, 'ML For Dummies', 
			{'Machine Learning'}, '2020-03-02', '2020-04-01');*/
	----------------------------------------------------------------------------

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val)
		VALUES(1, 5, 'Mister Bean', 116, 'ML For Dummies', '2020-03-02', 
			'Excited to become an ML-Pro!');

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val) 
		VALUES(2, 5, 'Mister Bean', 116, 'ML For Dummies', '2020-03-12', 
			'This book is a bit difficult, but still loving it!');

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val) 
		VALUES(3, 5, 'Mister Bean', 116, 'ML For Dummies', '2020-03-22', 
			'This book SUCKS!');

	----------------------------------------------------------------------------
	/*INSERT INTO checkouts(Event_id, User_id, Name, university_affiliation, 
			Book_id, Title, key_topics, Checkout_start, Checkout_end)
		VALUES(2, 5, 'Mister Bean', 'Beaner University', 42, 
			'Intro To Algorithms', {'Machine Learning'}, '2020-03-12',
			'2020-04-12');*/

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val)
		VALUES(4, 5, 'Mister Bean', 42, 'Intro To Algorithms', '2020-03-12', 
			'Excited to become an Algo-Pro!');

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val)
		VALUES(5, 5, 'Mister Bean', 42, 'Intro To Algorithms', '2020-03-17', 
			'Honestly, this book is not very well written--imo...');

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val)
		VALUES(6, 5, 'Mister Bean', 42, 'Intro To Algorithms', '2020-03-22', 
			'ALGOS kind of suck--thinking of a career in the arts!!');

	----------------------------------------------------------------------------
	/*INSERT INTO checkouts(Event_id, User_id, Name, university_affiliation, 
			Book_id, Title, key_topics, Checkout_start, Checkout_end)
		VALUES(3, 3, 'Kanye West', 116, 'ML For Dummies', {'Machine Learning'}, 
			'2020-03-15', '2020-04-15');*/
	----------------------------------------------------------------------------

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val)
		VALUES(7, 3, 'Kanye West', 116, 'ML For Dummies', '2020-03-15', 
			'Hoping this book is EASY to understand after Intro2Algs!!');

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val)
		VALUES(8, 3, 'Kanye West', 116, 'ML For Dummies', '2020-03-22', 
			'Book is very obvious--think that my neural net is past this.');

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val)
		VALUES(9, 3, 'Kanye West', 116, 'ML For Dummies', '2020-03-25', 
			'ML is most definitely 4 Dummmies. Aced this book, no doubt.');

	----------------------------------------------------------------------------
	/*INSERT INTO checkouts(Event_id, User_id, Name, university_affiliation, 
			Book_id, Title, key_topics, Checkout_start, Checkout_end)
		VALUES(4, 5, 'Mister Bean', 'Beaner University', 1984, 'Brave New World', 
			{'Fiction'}, '2020-03-21', '2020-04-21');*/
	----------------------------------------------------------------------------

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val)
		VALUES(10, 5, 'Mister Bean', 1984, 'Brave New World', '2020-03-21', 
			'Got this book after reading the awesome and fun book, "1984"'!);

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val)
		VALUES(11, 5, 'Mister Bean', 1984, 'Brave New World', '2020-03-28', 
			'Not sure where the book is going--1984 was a very cheerful book.');

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val)
		VALUES(12, 5, 'Mister Bean', 1984, 'Brave New World', '2020-04-01', 
			'Okay um, this book is somewhat unsettling...a warning to all.');

	----------------------------------------------------------------------------
	/*INSERT INTO checkouts(Event_id, User_id, Name, university_affiliation, 
			Book_id, Title, key_topics, Checkout_start, Checkout_end)
		VALUES(5, 2, 'Ferb Schmirtz', 'Pace University', 42, 
			'Intro To Algorithms', {'Machine Learning'}, '2020-04-01',
			'2020-05-01');*/
	----------------------------------------------------------------------------

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val)
		VALUES(13, 2, 'Ferb Schmirtz', 42, 'Intro To Algorithms', '2020-04-01', 
			'FERB WUZ HERE!');

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val)
		VALUES(14, 2, 'Ferb Schmirtz', 42, 'Intro To Algorithms', '2020-04-08', 
			'This book has been so helpful in algos class!');

	INSERT INTO comments(Comment_id, User_id, Name, Book_id, Title, Comment_date, 
		Comment_val)
		VALUES(15, 2, 'Ferb Schmirtz', 42, 'Intro To Algorithms', '2020-04-11', 
			'Shoutout to my favorite textbook of the semester, hands-down!');

--------------------------------------------------------------------------------
5| DATABASE QUERIES [CODE]
--------------------------------------------------------------------------------

	USE CuVirtualLibrary;

	----------------------------------------------------------------------------
	Query 1| Which books have been checked out since such and such date?
	----------------------------------------------------------------------------

	// Using the example date of 2020-03-20, our query would be written as:

		SELECT Book_id, Title, Checkout_start FROM checkouts
		WHERE Checkout_start >= '2020-03-20' ALLOW FILTERING;

	----------------------------------------------------------------------------
	Query 2| Which users have checked out such and such book?
	----------------------------------------------------------------------------

	// Using the example book of 'ML for Dummies', our query is written as:

		SELECT User_id, Name FROM checkouts
		WHERE Title = 'ML for Dummies' ALLOW FILTERING;
		
	----------------------------------------------------------------------------
	Query 3| How many books does the library have on such and such topic?
	----------------------------------------------------------------------------

	// Using the example topic of 'Fiction', our query would then be written as:

		SELECT count(*) AS number_books FROM ebooks
		WHERE key_topics CONTAINS 'Fiction' ALLOW FILTERING;

	----------------------------------------------------------------------------
	Query 4| Which users from 'Columbia University' have checked out books on 
				'Machine Learning' between such and such date?
	----------------------------------------------------------------------------

	// Using the example dates of 2020-03-15 to 2020-04-01, our query would be:

		SELECT User_id, Name from checkouts
		WHERE key_topics CONTAINS 'Machine Learning' AND
		Checkout_start >= '2020-03-15' AND
		Checkout_start <= '2020-04-01' AND
		university_affiliation = 'Columbia University'
		ALLOW FILTERING;

	----------------------------------------------------------------------------
	Query 5| What did any user comment about such and such book between such and 
				such dates, ordered from the most recent to the least recent?
	----------------------------------------------------------------------------

	// Using the example book of 'Intro to Algorithms' and the example dates of
	// 2020-03-15 to 2020-04-01, our query would then be written as:

		SELECT Title, Name, Comment_val, Comment_date FROM comments
		WHERE Title = 'Intro to Algorithms' AND
		Comment_date >= '2020-03-15' AND
		Comment_date <= '2020-03-31' 
		ORDER BY Comment_date DESC
		ALLOW FILTERING;
 
	----------------------------------------------------------------------------
	Query 6| Show a given user their comments about such and such book
	----------------------------------------------------------------------------

	// Using the example user of 'Mister Bean', the query would be written as:

		SELECT Title, Comment_val FROM comments
		WHERE Name = 'Mister Bean'
		ALLOW FILTERING;
		
--------------------------------------------------------------------------------
									//EOF   
--------------------------------------------------------------------------------

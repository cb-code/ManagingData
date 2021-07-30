
----------------------------------------------------------------------------
					Assignment 4 | Cassandra Database
					Sem: Fall 20 | 5400 Managing Data 
----------------------------------------------------------------------------

----------------------------------------------------------------------------
					UNI: chb2132 | Name: C. Blanchard
----------------------------------------------------------------------------

----------------------------------------------------------------------------
1| Keyspace Design
----------------------------------------------------------------------------

Cassandra Digital Library-

	Keyspace will have three column-families:

		1.1| ebooks
		
		1.2| users

		1.3| checkouts

	----------------------------------------------------------------------------
	1.1| Column-Family: ebooks
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
	1.2| Column-Family: users
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
	1.3| Column-Family: checkouts
	----------------------------------------------------------------------------

		Each row contains a checkout event. Columns include:

			1| Event_id
				TYPE INT: PRIMARY KEY

			2| User_id: users(User_id)
				TYPE INT

			3| Name: users(Name)
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
2| KEYSPACE [CODE]
----------------------------------------------------------------------------

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

----------------------------------------------------------------------------
4| CODE [COLLECTION VALUE INSERTION]
----------------------------------------------------------------------------

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
5| DATABASE QUERIES [CODE]
----------------------------------------------------------------------------

USE CuVirtualLibrary;

	----------------------------------------------------------------------------
	Query 1| Which books have been checked out since such and such date?
	----------------------------------------------------------------------------

	// Using the example date of 2020-03-20, our query would be written as:

		SELECT Book_id, Title, Event_date FROM checkouts
		WHERE Event_date >= '2020-03-20' ALLOW FILTERING;

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
		Event_date >= '2020-03-15' AND
		Event_date <= '2020-04-01' AND
		university_affiliation = 'Columbia University'
		ALLOW FILTERING;


--------------------------------------------------------------------------------
									//EOF   
--------------------------------------------------------------------------------

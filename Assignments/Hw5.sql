--------------------------------------------------------------------------------
					Assignment 5 | MongoDB Database
					Sem: Fall 20 | 5400 Managing Data 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
					UNI: chb2132 | Name: C. Blanchard
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
1| Keyspace Design
--------------------------------------------------------------------------------

MongoDB Digital Library--

	Keyspace will have three column-families:

		1.1| ebooks

		2.1| users

		3.1| checkouts

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

			2| User_id: user(User id)
				TYPE INT

			3| Name: user(name)
				TYPE TEXT

			4| university_affiliation: user(university affiliation)
				TYPE TEXT

			5| Book_id: book(Book id)
				TYPE INT

			6| Title: book(Title)
				TYPE TEXT

			7| key_topics: book(key topic list)
				TYPE SET: UNORDERED ELEMENT COLLECTION

			8| Event_date: date of checkout event
				TYPE DATE

--------------------------------------------------------------------------------
2| MongoDB DATABASE CREATION [CODE]
--------------------------------------------------------------------------------

	use mydb

--------------------------------------------------------------------------------
3| MongoDB COLLECTION CREATON + VALUE INSERTION [CODE]
--------------------------------------------------------------------------------

	----------------------------------------------------------------------------
	3.1| EBOOKS COLLECTION [CODE]
	----------------------------------------------------------------------------

	// Inserting ebooks values:


	db.ebooks.insertMany([

		{'Book_id' : 116, 'Title' : 'ML for Dummies', 'primary_author' : 
		'Roaree', 'secondary_authors' : ['Alma Mater'], 'publication_date' :
		'2000-01-01', 'page_count' : 209, 'publisher' : 'Columbia Press', 
		'translator' : 'Lee Bollinger', 'key_topics' : ['Machine Learning']},

		{'Book_id' : 42, 'Title' : 'Intro To Algorithms', 'primary_author' : 
		'Lemon Schubert', 'secondary_authors' : ['Alfred Schwartz'], 
		'publication_date' : '1990-03-15', 'page_count' : 1415, 'publisher' : 
		'Springer', 'key_topics' : ['Machine Learning']},

		{'Book_id' : 1984, 'Title' : 'Brave New World', 'primary_author' : 
		'Big Brother', 'secondary_authors' : ['Little Sister'], 'publication_date' :
		'1948-11-20', 'page_count' : 404, 'publisher' : 'Penguin Press', 
		'key_topics' : ['Fiction']},

	]);

	----------------------------------------------------------------------------
	3.2| USERS COLLECTION [CODE]
	----------------------------------------------------------------------------

	// Inserting users values:

	db.users.insertMany([

		{'User_id' : 1, 'Name' : 'Phineas Schmirtz', 'phone' : '212-222-2121', 
		'address' : '2900 Broadway Avenue', 'university_affiliation' : 
		'Pace University'},

		{'User_id' : 2, 'Name' : 'Ferb Schmirtz', 'phone' : '212-333-2334', 
		'address' : '2900 Broadway Avenue', 'university_affiliation' : 
		'Pace University'},

		{'User_id' : 3, 'Name' : 'Kanye West', 'address' : 
		'5050 Broadway Avenue'},

		{'User_id' : 4, 'Name' : 'Ruth Bader Ginsburg', 'phone' : '212-555-5324', 
		'address' : '1 Broad Street', 'university_affiliation' : 
		'Columbia University'},

		{'User_id' : 5, 'Name' : 'Mister Bean', 'phone' : '1-800-888-1443', 
		'address' : '1337 McBean Rd', 'university_affiliation' : 
		'Beaner University'},

	]);

	----------------------------------------------------------------------------
	3.3| CHECKOUTS COLLECTION [CODE]
	----------------------------------------------------------------------------

	// Inserting checkouts values:

	db.checkouts.insertMany([

		{'Event_id' : 1, 'User_id' : 5, 'Name' : 'Mister Bean', 
		'university_affiliation' : 'Beaner University', 'Book_id' : 116, 
		'Title' : 'ML For Dummies', 'key_topics' : ['Machine Learning'], 
		'Event_date' : '2020-03-02'}, 

		{'Event_id' : 2, 'User_id' : 5, 'Name' : 'Mister Bean', 
		'university_affiliation' : 'Beaner University', 'Book_id' : 42, 
		'Title' : 'Intro To Algorithms', 'key_topics' :  ['Machine Learning'],
		'Event_date' : '2020-03-12'},

		{'Event_id' : 3, 'User_id' : 3, 'Name' : 'Kanye West', 
		'Book_id' : 116, 'Title' : 'ML For Dummies', 'key_topics' : 
		['Machine Learning'], 'Event_date' : '2020-03-15'}, 

		{'Event_id' : 4, 'User_id' : 5, 'Name' : 'Mister Bean', 
		'university_affiliation' : 'Beaner University', 'Book_id' : 1984,
		'Title' : 'Brave New World', 'key_topics' : ['Fiction'], 
		'Event_date' : '2020-03-21'}, 

		{'Event_id' : 5, 'User_id' : 2, 'Name' : 'Ferb Schmirtz', 
		'university_affiliation' : 'Pace University', 'Book_id' : 42, 
		'Title' : 'Intro To Algorithms', 'key_topics' : ['Machine Learning'], 
		'Event_date' : '2020-04-01'}, 

	]);

	----------------------------------------------------------------------------
	3.4| DATABASE COLLECTIONS [CODE]
	----------------------------------------------------------------------------

	// Accessing each collection (ebooks, users, checkouts) as a check:

	db.ebooks.find()

	db.users.find()

	db.checkouts.find()

----------------------------------------------------------------------------
4| DATABASE QUERIES [CODE]
----------------------------------------------------------------------------

	----------------------------------------------------------------------------
	Query 1| Which books have been checked out since such and such date?
	----------------------------------------------------------------------------

	// Using the example date of 2020-03-20, our query would be written as:

		db.checkouts.find({'Event_date' : {$gte: '2020-03-20'}});

	----------------------------------------------------------------------------
	Query 2| Which users have checked out such and such book?
	----------------------------------------------------------------------------

	// Using the example book of 'ML for Dummies', our query is written as:

		db.checkouts.find({'Title' : 'ML for Dummies'});

	----------------------------------------------------------------------------
	Query 3| How many books does the library have on such and such topic?
	----------------------------------------------------------------------------

	// Using the example topic of 'Fiction', our query would then be written as:

		db.ebooks.aggregate([
			{$match : {'key_topics' : {$in : ['Fiction']}}},
			{$count : 'count_books'}
		]);
		
	----------------------------------------------------------------------------
	Query 4| Which users from 'Columbia University' have checked out books on 
				'Machine Learning' between such and such date?
	----------------------------------------------------------------------------

	// Using the example dates of 2020-03-15 to 2020-04-01, our query would be:

		db.checkouts.find({$and: [
			{'Event_date' : {$gte: '2020-03-15', $lte: '2020-04-01'}},
			{'university_affiliation' : 'Columbia University'},
			{'key_topics' : {$in : ['Machine Learning']}}
		]});

--------------------------------------------------------------------------------
									//EOF   
--------------------------------------------------------------------------------

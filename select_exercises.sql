#Create a new file called select_exercises.sql. Do your work for this exercise in that file.

#Use the albums_db database.

show databases;

use albums_db;
SELECT database();

#Explore the structure of the albums table.

show tables;
describe albums;

# The name of all albums by Pink Floyd

select name AS 'Albums by Pink Floyd'
from albums
where artist = 'Pink Floyd';

# The year Sgt. Pepper's Lonely Hearts Club Band was released

select release_date
from albums
where name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

# The genre for the album Nevermind

select *
from albums
where name = 'Nevermind';

# Which albums were released in the 1990s

select *
from albums
where release_date between 1990 and 1999
order by release_date;

# Which albums had less than 20 million certified sales

select *
from albums
where sales < 20.0
order by sales;

# All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?

select name,
	   genre
from albums
where genre like '%rock%';

# The reason these query results don't return any 'Hard Rock' or 'Progressive Rock' is because when searching for genre...
# the search only brings back a whole string not part of a string. To get these results, you would need to search for "Hard rock" or "Progressive rock"
# To fix this issues, you need to use a wildcard operator as the code shows above and will show all genres with 'rock'
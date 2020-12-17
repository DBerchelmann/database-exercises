show databases;

use albums_db;

# The name of all albums by Pink Floyd

select *
from albums
where artist = 'Pink Floyd';

# The year Sgt. Pepper's Lonely Hearts Club Band was released

select release_date
from albums
where name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

# The genre for the album Nevermind

select genre
from albums
where name = 'Nevermind';

# Which albums were released in the 1990s

select *
from albums
where release_date >= 1990
order by release_date;

# Which albums had less than 20 million certified sales

select *
from albums
where sales < 20.0
order by sales;

# All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?

select *
from albums
where genre = 'rock';

# The reason these query results don't return any 'Hard Rock' or 'Progressive Rock' is because the genre..
# column didn't include those labels to further identify the albums
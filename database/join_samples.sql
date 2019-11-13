# 1. artist names and album names - artist table + album table
DESCRIBE artist;
DESCRIBE album;
SELECT artist_name, album_name 
FROM artist INNER JOIN album USING (artist_id);


# 2. artists and tracks
SELECT artist_name, track_name 
FROM artist INNER JOIN track USING (artist_id);


# 3. artists and the number of tracks
SELECT artist_name, count(*) AS num_tracks 
FROM artist INNER JOIN track USING (artist_id)
GROUP BY artist_id;


# 4. Track name, date/time played for all tracks that have been played
DESCRIBE played;
SELECT track_name, played 
FROM track INNER JOIN played USING (artist_id, album_id, track_id);


# 5. Including songs that haven't been played:
SELECT track_name, played 
FROM track LEFT JOIN played USING (artist_id, album_id, track_id);

# 5a. can add WHERE played IS NOT NULL to get back to the INNER JOIN.
SELECT track_name, played 
FROM track LEFT JOIN played USING (artist_id, album_id, track_id) 
WHERE played IS NOT NULL;


# 6. Track name, times played, total time played for all songs that have been played
SELECT track_name, count(*) as num, sum(track_time) as total 
FROM track INNER JOIN played USING (artist_id, album_id, track_id)
GROUP BY artist_id, album_id, track_id;


# 7. To see all songs (including those that haven't been played)
# Suppose we take (6) and replase the INNER JOIN with a LEFT JOIN
SELECT track_name, count(*) as num, sum(track_time) as total 
FROM track LEFT JOIN played USING (artist_id, album_id, track_id)
GROUP BY artist_id, album_id, track_id;
# the 'num' and 'total' fields aren't correct for the songs 
# that haven't played.

# fixing the problems ..
SELECT track_name, count(played) as num, track_time*count(played) as total 
FROM track LEFT JOIN played USING (artist_id, album_id, track_id) 
GROUP BY artist_id, album_id, track_id;

# back to only those that have been played, but still using the left join
SELECT track_name, count(played) as num, track_time*count(played) as total 
FROM track LEFT JOIN played USING (artist_id, album_id, track_id) 
GROUP BY artist_id, album_id, track_id
HAVING num > 0;

# 8. 6 With Artist name - 3 tables: artist, track, played
SELECT artist_name, track_name, count(played) as num, sum(track_time) as total 
FROM track 
INNER JOIN played USING (artist_id, album_id, track_id)
INNER JOIN artist USING (artist_id) 
GROUP BY artist_id, album_id, track_id;


# 9. All airplanes and the flights that each has flown;
SELECT RegistrationNumber, ModelNumber, FlightNumber
FROM airplane INNER JOIN flight USING (registrationnumber) 
ORDER BY registrationnumber;


# 10.  All airplanes and the number of flights that each has flown;
SELECT RegistrationNumber, ModelNumber, count(flightnumber) AS Num
FROM airplane INNER JOIN flight USING (registrationnumber)
GROUP BY registrationnumber;


# Flights originating in Atlanta that have remaining capacity
# Flight
# Airplane - capacity
# Booking - bookings for the flight
# 11. start with flights and planes
SELECT flightnumber, origin, registrationnumber, capacity 
FROM flight INNER JOIN airplane USING (registrationnumber)
WHERE origin = 'Atlanta';

# 12. add bookings (caution -- this is a long record set - includes 
# all bookings for all flights from ATL
SELECT flightnumber, origin, registrationnumber, capacity, emailaddress 
FROM flight INNER JOIN airplane USING (registrationnumber) 
INNER JOIN booking USING (flightnumber)
WHERE origin = 'Atlanta';

# 13. group by flight number and add booking count
SELECT flightnumber, origin, registrationnumber, 
capacity, count(emailaddress) as bookings
FROM flight INNER JOIN airplane USING (registrationnumber) 
INNER JOIN booking USING (flightnumber)
WHERE origin = 'Atlanta' GROUP BY flightnumber;

# 14. add remaining capacity field
SELECT flightnumber, origin, registrationnumber, capacity, 
count(emailaddress) as bookings, capacity - count(emailaddress) AS remaining 
FROM flight 
INNER JOIN airplane USING (registrationnumber) 
INNER JOIN booking USING (flightnumber)
WHERE origin = 'Atlanta' GROUP BY flightnumber;

# 15. Filter to those having capacity
SELECT flightnumber, origin, registrationnumber, capacity, 
count(emailaddress) as bookings, capacity - count(emailaddress) AS remaining 
FROM flight 
INNER JOIN airplane USING (registrationnumber) 
INNER JOIN booking USING (flightnumber)
WHERE origin = 'Atlanta' GROUP BY flightnumber HAVING remaining > 0;


USE IG_CLONE;

# 2.We want to reward the user who has been around the longest, Find the 5 oldest users.
SELECT 
    USERNAME, CREATED_AT
FROM
    USERS
ORDER BY CREATED_AT
LIMIT 5;

# 3.To understand when to run the ad campaign, figure out the day of the week most users register on? 
SELECT * FROM USERS;
SELECT DAYOFWEEK(CREATED_AT)AS WEEKDAY,COUNT(*) FROM USERS 
GROUP BY DAYOFWEEK(CREATED_AT) ORDER BY COUNT(*) DESC;

# 4.To target inactive users in an email ad campaign, find the users who have never posted a photo.
SELECT * FROM USERS;
SELECT * FROM PHOTOS
SELECT ID,USERNAME FROM USERS WHERE ID NOT IN(SELECT USER_ID FROM PHOTOS)

# 5.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
SELECT * FROM LIKES
SELECT * FROM PHOTOS
SELECT * FROM USERS
SELECT U.USERNAME,P.ID,P.IMAGE_URL,COUNT(*) AS TOTAL_LIKES FROM LIKES L JOIN PHOTOS P
ON L.PHOTO_ID=P.ID JOIN USERS U ON P.USER_ID=U.ID 
GROUP BY P.ID ORDER BY TOTAL_LIKES DESC limit 1

# 6.The investors want to know how many times does the average user post.
SELECT * FROM USERS
SELECT * FROM PHOTOS
SELECT ROUND((SELECT COUNT(*) FROM PHOTOS)/(SELECT COUNT(*) FROM USERS),2) AS AVG 

# 7.A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
SELECT * FROM TAGS
SELECT * FROM PHOTO_TAGS
SELECT TAG_NAME,COUNT(TAG_NAME) AS TOTAL FROM TAGS T JOIN PHOTO_TAGS PT
ON T.ID=PT.TAG_ID GROUP BY T.ID ORDER BY TOTAL DESC LIMIT 5

# 8.To find out if there are bots, find users who have liked every single photo on the site.
SELECT * FROM USERS 
SELECT * FROM LIKES
SELECT * FROM PHOTOS
SELECT U.ID,USERNAME,COUNT(*) AS TOTAL_LIKES FROM USERS U
JOIN LIKES L ON U.ID = L.USER_ID GROUP BY U.ID
HAVING TOTAL_LIKES =(SELECT COUNT(*) FROM PHOTOS) 

# 9.To know who the celebrities are, find users who have never commented on a photo.
SELECT * FROM USERS
SELECT * FROM COMMENTS
SELECT USERNAME,C.COMMENT_TEXT FROM USERS U LEFT JOIN COMMENTS C ON
U.ID=C.USER_ID WHERE C.USER_ID IS NULL

# 10.Now it's time to find both of them together, find the users who have never commented on any photo 
#    or have commented on every photo.
SELECT * FROM USERS
SELECT * FROM COMMENTS
SELECT * FROM PHOTOS

WITH CTE AS
(
SELECT U.ID,U.USERNAME,C.COMMENT_TEXT FROM USERS U LEFT JOIN COMMENTS C ON
U.ID=C.USER_ID WHERE C.USER_ID IS NULL
),
CTE1 AS
(
SELECT U.ID,USERNAME,COUNT(*) AS TOTAL_COMMENT FROM USERS U JOIN COMMENTS C 
ON U.ID = C.USER_ID GROUP BY U.ID
HAVING TOTAL_COMMENT = (SELECT COUNT(*) FROM PHOTOS)
)
SELECT * FROM CTE UNION SELECT * FROM CTE1







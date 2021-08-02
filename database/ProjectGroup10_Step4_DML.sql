-- SQL Statements (Data Manipulation Queries)
--
-- Campuses Entity Table
--
/*Query to select all records from the Campuses table*/
SELECT * FROM Campuses ORDER BY campus_id ASC;

/*Query to add a new campus to the Campuses table with the % character being used to 
denote the variables that will have data from the backend programming language*/
INSERT INTO Campuses(campus_name, campus_city, campus_country, campus_online) 
VALUES (%campus_name, %campus_city, %campus_country, %campus_online);

/*Query to update an existing set of records to the Campuses table with % character being used 
to denote the variables that will have data from the backend programming language*/
UPDATE Campuses SET campus_name = %campus_name, campus_city = %campus_city, campus_country = %campus_country, campus_online = %campus_online 
WHERE campus_id = %campus_id;

/*Query to delete any records from the Campuses table given a particular campus_id, with the 
% character being used to denote the variable that will have data from the backend 
programming language*/
DELETE FROM Campuses WHERE campus_id = %campus_id;
--
-- Instructors Entity Table
--
/*Query to select all records from the instructors table*/
SELECT * FROM Instructors ORDER BY instructor_id ASC;

/*Query to insert a new instructor into the Instructors table with the % character being used to 
denote the variables that will have data from the backend programming language*/
INSERT INTO Instructors(instructor_first_name, instructor_last_name, campus_id) 
VALUES (%instructor_first_name, %instructor_last_name, %campus_id);

/*Query to delete any records from the Instructors table given a particular instructor_id, with the 
% sign being used to denote the variables that will have data from the backend programming language*/
DELETE FROM Instructors WHERE instructor_id = %instructor_id;
--
-- Students Entity Table
--
/*Query to aggregate the records by campus_id to get the number of students registered to 
each campus*/
SELECT campus_id, COUNT(*) AS count FROM Students GROUP BY campus_id ORDER BY campus_id ASC;

/*Query to select all records from the Students table*/
SELECT * FROM Students ORDER BY student_id ASC;

/*Query to insert a new student into the Students table with the % character being used to 
denote the variables that will have data from the backend programming language*/
INSERT INTO Students(student_first_name, student_last_name, campus_id) 
VALUES (%student_first_name, %student_last_name, %campus_id);

/*Query to delete any records from the Students table given a particular student id with the % 
character used to denote the variables that will have data from the backend programming language*/
DELETE FROM Students WHERE student_id = %student_id;
--
-- Courses Entity Table
--
/*Query to select all records from the Courses table*/
SELECT * FROM Courses ORDER BY course_id ASC;

/*Query to delete any records from the Courses table given a particular course_id, with the 
% character being used to denote the variables that will have data from the backend 
programming language*/
DELETE FROM Courses WHERE course_id = %course_id;

/*Query to insert a new course into the Courses table with the % character being used to 
denote the variables that will have data from the backend programming language*/
INSERT INTO Courses(course_name) VALUES (%course_name);
--
-- Sections Entity Table
--
/*Query to select all records from the Sections table with the corresponding name attributes for each foreign key (e.g. course_name for course_id)*/
SELECT section_id, c.course_id, course_name, i.instructor_id, CONCAT(instructor_first_name, ' ', instructor_last_name) as instructor_name, ca.campus_id, campus_name
FROM Sections s
JOIN Courses c ON s.course_id = c.course_id
JOIN Instructors i ON s.instructor_id = i.instructor_id
JOIN Campuses ca ON s.campus_id = ca.campus_id
ORDER BY section_id ASC;

/*Queries for search filter*/
SELECT DISTINCT course_name FROM Courses ORDER BY course_name ASC;
SELECT DISTINCT campus_name FROM Campuses ORDER BY campus_name ASC;
SELECT DISTINCT section_id FROM Sections ORDER BY section_id ASC;

/*Query to select all records from the Sections table given a particular section_id, a course_name, or a campus_name, with the % character being used to denote the variables that will have data from the backend programming language;
This is to select results from searching by section_id, course_name, or campus_name*/
SELECT section_id, c.course_id, course_name, i.instructor_id, CONCAT(instructor_first_name, ' ', instructor_last_name) as instructor_name, ca.campus_id, campus_name \
FROM Sections s \
JOIN Courses c ON s.course_id = c.course_id \
JOIN Instructors i ON s.instructor_id = i.instructor_id \
JOIN Campuses ca ON s.campus_id = ca.campus_id \
WHERE section_id = %s OR c.course_name like %s OR ca.campus_name like %s \
ORDER BY section_id ASC;

/*Query to select all records from Sections table*/
SELECT * FROM Sections ORDER BY section_id ASC;

/*Queries for client side validation*/
SELECT course_id, course_name FROM Courses ORDER BY course_name ASC;
SELECT campus_id, campus_name FROM Campuses ORDER BY campus_name ASC;
SELECT instructor_id, CONCAT(instructor_first_name, ' ', instructor_last_name) AS instructor_name FROM Instructors ORDER BY instructor_name ASC;

/*Query to insert a new section into the Sections table with the % character being used to denote the variables that will have data from the backend programming language*/
INSERT INTO Sections(course_id, instructor_id, campus_id) VALUES (%course_id, %instructor_id, %campus_id);

/*Query to delete any records from the Sections table given a particular section_id, with the % character being used to denote the variable that will have data from the backend programming language*/
DELETE FROM Sections WHERE section_id = %section_id;
--
-- Students_Sections M:M Intersection Table
--
/*Query to select any records from the Students_Sections table with the corresponding name attributes for each foreign key (e.g. course_name for course_id), with the % character being used to denote the variables that will have data from the backend programming language*/
SELECT ss.student_id, CONCAT(student_first_name, ' ', student_last_name) as student_name, se.section_id, c.course_name, CONCAT(instructor_first_name, ' ', instructor_last_name) as instructor_name, ca.campus_name \
FROM Students_Sections ss \
JOIN Students s ON ss.student_id = s.student_id \
JOIN Sections se ON se.section_id = ss.section_id \
JOIN Courses c ON c.course_id = se.course_id \
JOIN Instructors i ON i.instructor_id = se.instructor_id\
JOIN Campuses ca ON ca.campus_id = i.campus_id \
ORDER BY student_id,section_id ASC;

/*Query to select student name as one string from the Students table*/
SELECT CONCAT(student_first_name, ' ', student_last_name) AS student_name FROM Students ORDER BY student_name ASC;

/*Query to select student_id from the Students table for given student_first_name and student_last_name, with the % character being used to denote the variables that will have data from the backend programming language*/
SELECT student_id FROM Students WHERE student_first_name = %student_first_name and student_last_name = %student_last_name;

/* Query to verify if student's registered campus and the section's campus match*/
SELECT campus_id FROM Students WHERE student_id = %student_id;
SELECT campus_id FROM Sections WHERE section_id = %section_id;

/*Query to insert a record for the Students_Sections table for a particular student_id and a section_id, with the % character being used to denote the variables that will have data from the backend programming language*/
INSERT INTO Students_Sections(student_id, section_id) VALUES (%student_id, %section_id);

/*Query to delete any records from the Students_Sections table given a particular student_id and section_id, with the % character being used to denote the variables that will have data from the backend programming language*/
DELETE FROM Students_Sections WHERE student_id = %student_id and section_id = %section_id;
--
-- Courses_Campuses M:M Intersection Table
--
/*Query to insert a new set of records into the Courses_Campuses table based on a given 
campus_id, with the % character being used to denote the variables that will have data from 
the backend programming language*/
INSERT INTO Courses_Campuses(course_id, campus_id) SELECT course_id, campus_id FROM courses t1 CROSS JOIN campuses t2 WHERE t2.campus_id = %campus_id;

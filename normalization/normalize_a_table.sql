/*
Scenario 3: Normalize a Repeating Group
You have a StudentGrades table:
(student_id, student_name, course_1, grade_1, course_2, grade_2, course_3, grade_3)
Tasks:
- Identify the repeating groups violating 1NF.
The courses and grades are repeating (1,2,3...) this violates 1NF because each
column needs to be atomic.
- Explain how this design limits flexibility (e.g., what if a student has 4 courses?).
We can't expand the columns if a student has more courses, so the table
is limited and not flexible.
- Write the schema for normalized tables that fix this.
- Specify primary keys and foreign keys in your design.
*/

CREATE TABLE IF NOT EXISTS students (
	student_id SERIAL PRIMARY KEY, 
	student_name VARCHAR (100) NOT NULL

);

CREATE TABLE IF NOT EXISTS courses (
	course_id SERIAL PRIMARY KEY,
	course_name TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS students_courses_grades (
	student_id INT NOT NULL REFERENCES students(student_id),
	course_id INT NOT NULL REFERENCES courses(course_id),
	grade NUMERIC (5, 2) NOT NULL,
	PRIMARY KEY (student_id, course_id)
);



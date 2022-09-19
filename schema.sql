-- ************************************** "public".workspaces

CREATE TABLE "public".workspaces
(
 "id"    SERIAL,
 title varchar(50) NOT NULL,
 CONSTRAINT PK_workspaces PRIMARY KEY ( "id" )
);

-- ************************************** "public".job_openings

CREATE TABLE "public".job_openings
(
 "id"    SERIAL,
 workspace integer NOT NULL,
 title     varchar(50) NOT NULL,
 active    boolean NOT NULL,
 CONSTRAINT PK_job_openings PRIMARY KEY ( "id" ),
 CONSTRAINT FK_1 FOREIGN KEY ( workspace ) REFERENCES "public".workspaces ( "id" )
);

CREATE INDEX FK_1 ON "public".job_openings
(
 workspace
);

-- ************************************** "public".tests

CREATE TABLE "public".tests
(
 "id"    SERIAL,
 title   varchar(50) NOT NULL,
 created timestamp NOT NULL,
 version integer NOT NULL,
 CONSTRAINT PK_tests PRIMARY KEY ( "id" ),
 CONSTRAINT AK_2 UNIQUE ( title, version )
);

-- ************************************** "public".JT_job_opening_tests

CREATE TABLE "public".JT_job_opening_tests
(
 test        integer NOT NULL,
 job_opening integer NOT NULL,
 CONSTRAINT "PK_ JT_job_opening_tests" PRIMARY KEY ( test, job_opening ),
 CONSTRAINT FK_2 FOREIGN KEY ( test ) REFERENCES "public".tests ( "id" ),
 CONSTRAINT FK_3 FOREIGN KEY ( job_opening ) REFERENCES "public".job_openings ( "id" )
);

CREATE INDEX FK_2 ON "public".JT_job_opening_tests
(
 test
);

CREATE INDEX FK_3 ON "public".JT_job_opening_tests
(
 job_opening
);

-- ************************************** "public".questions

CREATE TABLE "public".questions
(
 "id"    SERIAL,
 text  varchar(50) NOT NULL,
 question_type integer NOT NUll,
 CONSTRAINT PK_questions PRIMARY KEY ( "id" )
);

-- ************************************** "public".JT_test_questions

CREATE TABLE "public".JT_test_questions
(
 test     integer NOT NULL,
 question  integer NOT NULL,
 CONSTRAINT PK_JT_test_questions PRIMARY KEY ( test, question ),
 CONSTRAINT FK_4 FOREIGN KEY ( test ) REFERENCES "public".tests ( "id" ),
 CONSTRAINT FK_5 FOREIGN KEY ( question ) REFERENCES "public".questions ( "id" )
);

CREATE INDEX FK_4 ON "public".JT_test_questions
(
 test
);

CREATE INDEX FK_5 ON "public".JT_test_questions
(
 question
);

-- ************************************** "public".options

CREATE TABLE "public".options
(
 "id"    SERIAL,
 text               varchar(50) NOT NULL,
 is_correct_answer boolean NOT NULL,
 CONSTRAINT PK_options PRIMARY KEY ( "id" )
);

-- ************************************** "public".JT_question_options

CREATE TABLE "public".JT_question_options
(
 question  integer NOT NULL,
 option    integer NOT NULL,
 CONSTRAINT PK_JT_question_options PRIMARY KEY ( question, option ),
 CONSTRAINT FK_6 FOREIGN KEY ( question ) REFERENCES "public".questions ( "id" ),
 CONSTRAINT FK_7 FOREIGN KEY ( option ) REFERENCES "public".options ( "id" )
);

CREATE INDEX FK_6 ON "public".JT_question_options
(
 question
);

CREATE INDEX FK_7 ON "public".JT_question_options
(
 option
);

-- ************************************** "public".candidates

CREATE TABLE "public".candidates
(
 "id"    SERIAL,
 name          varchar(50) NOT NULL,
 email         varchar(50) NOT NULL,
 IP            varchar(50) NOT NULL,
 email_cleaned varchar(50) NOT NULL,
 CONSTRAINT PK_candidates PRIMARY KEY ( "id" )
);

-- ************************************** "public".exams

CREATE TABLE "public".exams
(
 "id"    SERIAL,
 test         integer NOT NULL,
 job_opening  integer NOT NULL,
 candidate    integer NOT NULL,
 time_started timestamp NOT NULL,
 time_ended   timestamp NOT NULL,
 score        integer NOT NULL,
 fraud_events integer NOT NULL,
 CONSTRAINT PK_exams PRIMARY KEY ( "id" ),
 CONSTRAINT FK_8 FOREIGN KEY ( candidate ) REFERENCES "public".candidates ( "id" ),
 CONSTRAINT FK_9 FOREIGN KEY ( job_opening ) REFERENCES "public".job_openings ( "id" ),
 CONSTRAINT FK_10 FOREIGN KEY ( test ) REFERENCES "public".tests ( "id" )
);

CREATE INDEX FK_8 ON "public".exams
(
 candidate
);

CREATE INDEX FK_9 ON "public".exams
(
 job_opening
);

CREATE INDEX FK_10 ON "public".exams
(
 test
);

-- ************************************** "public".answers

CREATE TABLE "public".answers
(
 "id"    SERIAL,
 option   integer NULL,
 question  integer NOT NULL,
 text     varchar(50) NULL,
 CONSTRAINT PK_answers PRIMARY KEY ( "id" ),
 CONSTRAINT FK_11 FOREIGN KEY ( question ) REFERENCES "public".questions ( "id" ),
 CONSTRAINT FK_12 FOREIGN KEY ( option ) REFERENCES "public".options ( "id" )
);

CREATE INDEX FK_11 ON "public".answers
(
 question
);

CREATE INDEX FK_12 ON "public".answers
(
 option
);

-- ************************************** "public".JT_exam_answers

CREATE TABLE "public".JT_exam_answers
(
 exam   integer NOT NULL,
 answer  integer NOT NULL,
 CONSTRAINT PK_JT_exam_answers PRIMARY KEY ( exam, answer ),
 CONSTRAINT FK_13 FOREIGN KEY ( exam ) REFERENCES "public".exams ( "id" ),
 CONSTRAINT FK_14 FOREIGN KEY ( answer ) REFERENCES "public".answers ( "id" )
);

CREATE INDEX FK_13 ON "public".JT_exam_answers
(
 exam
);

CREATE INDEX FK_14 ON "public".JT_exam_answers
(
 answer
);
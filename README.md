# toggl-hire

# Folder structure
- schema.sql: schema file with just table definitions
- dump_split.zip: multiple files (due to upload size constraing of Github) with database contining sample data.
- queries.sql: sample queries that show how two features are expected to work

# Disclaimer
- Schema is not optimised as I had no time to test performance.
- Data imported is in full size for part test-question-option, while schema part for taken exams contains a single entry that allowed me to test basic functioning of the solution.

# Architectural decisions
- I'm generally strongly against pushing any kind of business logic and data processing on the database side, and in favor of using it just as a storage. In this case I used that approach to solve issue with similar email. The app would due the "cleanup" of email address and then store it in the additional column. This way queries that need to find similar emails are simple "equal" comparison and thus quite fast.
- In order to distinguish different types of questions (single choice, free text, code input, video recording) the field "question_type" is used. It's value identifies different types (eg. 0 = free text, 4 = single choice). Ideally, there should be table for each question type that could cointain specific properties for that type, but for now there is a single choice only that has some specifics thus no need for complex schema.

# Future work (if more time available)
- Add "created" and "last_updated" columns to all tables.
- Introduce "version" for questions, as although not specified by the task I could foresee problems with different versions of tests pointing to the same questions and generally question needing to be updated. With the current schema there is no versioning of questions and each change would mean new question completely.

# Not done from the task list
- I have not implemented pagination in queries for candidates.
- I have not confirmed that queries run below 1s. Due to technical limitations I used online installation via https://console.scalegrid.io/. All my tests had additional network latency.

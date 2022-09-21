
-- Find suspicious candidates by criteria: same IP

select * from candidates where ip in (
    select ip from candidates
    group by ip having count(*) > 1
)


-- Find suspicious candidates by criteria: similar IP

select * from candidates where email_cleaned in (
    select email_cleaned from candidates
    group by email_cleaned having count(*) > 1
)

-- Find suspicious candidates by criteria: fraud events

select * from candidates c
join exams e on c.id=e.id
where e.fraud_events > 1


-- Select candidates based on job they applied for and minimal score

select * from candidates c
join exams e on c.id=e.id
join job_openings j  on j.id = e.job_opening
where e.score > 70

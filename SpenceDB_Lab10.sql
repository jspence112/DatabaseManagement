
--1.
--The requirement to use one parameter makes things more messy to run.
create or replace function PreReqsFor(course_num int) returns refcursor as
$$
declare
   resultset REFCURSOR;
begin
   open resultset for
   select prereqnum from Prerequisites
   where coursenum = course_num;
 return resultset;
end;
$$
language plpgsql;

--code to run the function
--Without using a parameter for a refcursor, such as is used in the example,
--it is necessary to run the below two lines in the same query,
--while referencing the correct unnamed portal manually.
--keep in mind that the portal that is being used will be determined by postgres, starting at 1.

--to figure out your unnamed portal, run the first line, which will return the current portal number.
--Then change the unnamed portal number in the second line to the number returned +1.
--Then run both lines below in one query.

select PreReqsFor(499);
Fetch all IN "<unnamed portal 31>";

--2.
create or replace function IsPreReqsFor(course_num int) returns refcursor as
$$
declare
   resultset REFCURSOR;
begin
   open resultset for
   select coursenum from Prerequisites
   where prereqnum = course_num;
 return resultset;
end;
$$
language plpgsql;

--code to run the function
select IsPreReqsFor(120);
Fetch all IN "<unnamed portal 35>";

select ji.issuenum as IssueNum,
	p.pname as Project,
	Customers.Customer as CustomerName,
    Timespent.TimeSpent,
    Timespent.Author,
    Timespent.DateModified,
    l.label,
    ji.created,
	ji.resolutiondate,
    iss.pname as IssueStatus
    from jiraissue ji
#---Customer Name
left join 
		(                        
			select A.ID as ID, cfo.customvalue as Customer from                         
				(select ji.id as ID, cfv.customfield, cfv.stringvalue  
					from jiraissue ji 
					join customfieldvalue cfv on ji.id = cfv.issue 
					where cfv.customfield = 10021 and ji.project = 10030) as A
				left join 
				customfieldoption cfo 
				on a.customfield = cfo.customfield and a.stringvalue = cfo.id
				) as Customers 
		on ji.id = Customers.ID
#Time spent by author
right join                      
	(select cg.Created as DateModified, cg.issueid as ID, 
		case when ci.oldstring is null then 0
			else ci.oldstring end as OldTime, 
			ci.NEWSTRING as NewTime, 
		case when ci.oldstring is null then ci.Newstring
			else ci.newstring - ci.oldstring
		end as TimeSpent, 
			cg.author as Author 
			from changegroup cg 
			left join changeitem ci on cg.id = ci.groupid
			where ci.field = "timespent" and cg.author in ("dhathaway", "bbafford", "sdubach", "rhudson")) as TimeSpent
	on ji.id = TimeSpent.ID
left join label l
	on l.issue = ji.id 
left join project p
	on p.id = ji.project
left join issuestatus iss
	on iss.id = ji.issuestatus
where ji.project in (10030, 11095)


select * from project

select * from customfield

select * from customfieldoption

select * from changeitem where field = "timespent"

select fieldtype, count(*) from changeitem group by fieldtype where fieldtype ="Timespent" id = 26015

select * from project in (10030)



select * from jiraissue

select * from customfieldoption cfo join  ()  as A
                        
select * from label
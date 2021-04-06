<books>
{
for $x in doc("books.xml")/catalog/book
where $x/publish_date > "2001-01-01"
order by $x/publish_date
return 
<book >
{$x/title}
{$x/publish_date}
</book>
}
</books>
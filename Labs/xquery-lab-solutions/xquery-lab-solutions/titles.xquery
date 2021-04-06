<books>
{
for $x in doc("books.xml")/catalog/book/title
return $x
}
</books>
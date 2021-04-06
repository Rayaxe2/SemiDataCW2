<books>
{
for $x in distinct-values(doc("books.xml")/catalog/book/genre)
return
<genre>
<name>{$x}</name>
{
for $y in distinct-values(doc("books.xml")/catalog/book[genre = $x]/author)
return
<author>{$y}</author>
}
</genre>
}
</books>
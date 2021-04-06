<books>
{
for $x in distinct-values(doc("books.xml")/catalog/book/genre)
return
<genre>{$x}</genre>
}
</books>
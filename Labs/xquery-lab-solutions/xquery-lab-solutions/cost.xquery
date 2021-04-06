<books>
{
for $x at $xPos in doc("books.xml")/catalog/book
where $x/price > 20
return <book>{$x/@id}</book>
}
</books>
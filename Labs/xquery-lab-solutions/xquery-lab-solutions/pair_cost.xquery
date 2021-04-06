<books>
{
for $x at $xPos in doc("books.xml")/catalog/book
for $y at $yPos in doc("books.xml")/catalog/book
let
  $sum := $x/price + $y/price
where $sum < 11 and $xPos < $yPos
return 
<buy cost="{$sum}">
  {$x/title}
  {$y/title}
</buy>
}
</books>
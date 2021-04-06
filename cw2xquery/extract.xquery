<table>
    <tr>
        <th>Target</th>
        <th>Successor</th>
    </tr>
    {
    for $hasWord in collection("./files/?select=*xml")//w (: collection('./cw2files')//w :)
    where normalize-space(lower-case($hasWord/text())) = "has"
    let $nextWord := 
    if (exists($hasWord/following-sibling::w[1]) and (not(normalize-space(($hasWord/following-sibling::w[1]/text())))))
            then (<w>[Empty Word]</w>)
            else(
                if ((exists($hasWord/following-sibling::w[1])))
                then ($hasWord/following-sibling::w[1])
                else (<w>[No Next Word]</w>)
            )
    return
    <tr>
        <td>{normalize-space(lower-case($hasWord/text()))}</td>
        <td>{normalize-space(lower-case($nextWord/text()))}</td>
    </tr>
    }
</table>
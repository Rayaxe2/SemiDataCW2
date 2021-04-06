<table>
    <tr>
        <th>Target</th>
        <th>Successor</th>
        <th>Count</th>
    </tr>
    {
    (: All the words in all the collections :)
    let $AllWords := 
        for $Word in collection('./cw2files')//w
        return $Word
    
    (: All "Has" Occrunaces :)
    let $hasOccurance := 
        for $hasWord in $AllWords
        where normalize-space(lower-case($hasWord/text())) = "has"
        return $hasWord
    
    (: Next words after each "has" occurances :)
    let $hasSiblings := 
        for $sibling in $hasOccurance
        return 
            (: Assings the sibling node the value "[Empty Word]" if there is no text in the word element and "[No Next Word]" if there is no word that proceeds the "has" occurance :)
            if (exists($sibling/following-sibling::w[1]) and (not(normalize-space(($sibling/following-sibling::w[1]/text())))))
            then (<w>[Empty Word]</w>)
            else(
                if ((exists($sibling/following-sibling::w[1])))
                then ($sibling/following-sibling::w[1])
                else (<w>[No Next Word]</w>)
            )
        
    (: Distinct Siblings :)
    let $distinctHasSiblings :=
        for $dSibling in distinct-values($hasSiblings)
        return $dSibling
    
    (: Loops through each distinct sibling of every "has" occurance :)
    for $uniqueSiblingWord at $index in $distinctHasSiblings 
        (:------------------------------------------------------------------------:)
        let $distinctHasSiblingsCount := 
            if($uniqueSiblingWord eq '[Empty Word]')
            then((count($hasSiblings[. eq $uniqueSiblingWord])) div (count($AllWords[not(./following-sibling::w[1])])))
            else(
                if($uniqueSiblingWord eq '[No Next Word]')
                then((count($hasSiblings[. eq $uniqueSiblingWord])) div (count($AllWords[./following-sibling::w[1]/. eq ""])))
                else((count($hasSiblings[. eq $uniqueSiblingWord])) div (count($AllWords[./following-sibling::w[1]/text() eq $uniqueSiblingWord])))
            ) 
        (:------------------------------------------------------------------------:)
          
        (: Find the "has" node before the sibling node and returns the first occurnace for each aggreagate :)
        let $BeforeSibling := 
            if (lower-case($uniqueSiblingWord) eq '[no next word]')
                    then ($hasOccurance[boolean(./following-sibling::w[1]) eq false()][1]/text())
                    else (
                        if (lower-case($uniqueSiblingWord) eq '[empty word]')
                        then ($hasOccurance[boolean(./following-sibling::w[1]) eq false()][1]/text())
                        else ($hasOccurance[./following-sibling::w[1]/text() eq $uniqueSiblingWord][1]/text()) 
                    )
        order by string($distinctHasSiblingsCount) descending, normalize-space(lower-case($uniqueSiblingWord))
        return
        <tr>
            <td>{normalize-space(lower-case($BeforeSibling[1])) (: Alternatively "has" can be used since all rows of this will be "has" :)}</td> 
            <td>{normalize-space(lower-case($uniqueSiblingWord))}</td>
            <td>{round-half-to-even(xs:decimal($distinctHasSiblingsCount), 2)}</td>
        </tr>
    }  
</table>
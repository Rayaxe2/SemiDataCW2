<table>
    <tr>
        <th>Target</th>
        <th>Successor</th>
        <th>Count</th>
    </tr>
    {
    (: All the words in all the collections :)
    let $AllWords := 
        for $Word in collection("./files/?select=*xml")//w
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
    
    (: Loops through each distinct sibling of every "has" occurance, returns an interlaced sequence of each "has" occurance, followed by each of their next sibling, 
    followed by each of the probability of them occurancing in the collectiong and sorts it's order bu the probability and the alphabetical order of the next sibling :)
    let $OrderedSequenceToPrint :=
        for $uniqueSiblingWord in $distinctHasSiblings 
            (:------------------------------------------------------------------------:)
            let $distinctHasSiblingsCount := 
                if($uniqueSiblingWord eq '[Empty Word]')
                then((count($hasSiblings[. eq $uniqueSiblingWord])) div (count($AllWords[not(./following-sibling::w[1])])))
                else(
                    if($uniqueSiblingWord eq '[No Next Word]')
                    then((count($hasSiblings[. eq $uniqueSiblingWord])) div (count($AllWords[./following-sibling::w[1]/normalize-space(.) eq ""])))
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
            return (normalize-space(lower-case($BeforeSibling[1])), normalize-space(lower-case($uniqueSiblingWord)), round-half-to-even(xs:decimal($distinctHasSiblingsCount), 2))
        
        (: Loops through the interlaced sequence made prior and unpacks it such that per every 3 items in the sequence, 
        the 3 items in question are selected outputed into a table row :)
        for $PrintItem at $index in $OrderedSequenceToPrint 
        where (($index mod 3) eq 0) and ($index lt 61)
        return
            <tr>
                <td>{$OrderedSequenceToPrint[$index - 2]}</td> 
                <td>{$OrderedSequenceToPrint[$index - 1]}</td>
                <td>{$PrintItem}</td>
            </tr>
    }  
</table>
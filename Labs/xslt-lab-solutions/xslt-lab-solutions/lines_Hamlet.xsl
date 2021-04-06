<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
  
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template match="/PLAY">
    <xsl:variable name="lines" 
      select=".//LINE[../SPEAKER = 'HAMLET']"/>
    <results n="{count($lines)}">
      <xsl:copy-of select="$lines"/>
    </results>    
  </xsl:template>
    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template match="/PLAY">
    <xsl:variable name="lines" 
      select=".//LINE[starts-with(.,'w')]"/>
    <results n="{count($lines)}">
      <xsl:copy-of select="$lines"/>
    </results>    
  </xsl:template>
    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
  
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template match="/PLAY">
    <results>
      <xsl:for-each-group select="ACT/SCENE/SPEECH" group-by="SPEAKER">
        <speaker>
          <xsl:attribute name="lines">
            <xsl:value-of select="count(current-group()/LINE)"/>
          </xsl:attribute>
          <xsl:value-of select="current-grouping-key()"/>
        </speaker>
      </xsl:for-each-group>
    </results>    
  </xsl:template>
  
</xsl:stylesheet>
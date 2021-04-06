<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
  
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template match="/PLAY">
    <scenes>
      <xsl:apply-templates select="ACT/SCENE"/>      
    </scenes>
  </xsl:template>
  
  <xsl:template match="SCENE">
    <scene act="{../TITLE}" lines="{count(SPEECH/LINE)}">
      <xsl:value-of select="TITLE"/>
    </scene>
  </xsl:template>
    
</xsl:stylesheet>
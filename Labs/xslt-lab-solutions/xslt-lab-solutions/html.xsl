<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
  
  <xsl:output method="html" indent="yes"/>
  
  <xsl:template match="/PLAY">
    <h1><xsl:value-of select="TITLE"/></h1>
    <p>by <xsl:value-of select="TITLE/@AUTHOR"/></p>    
    <xsl:apply-templates select="PERSONAE | SCNDESCR | ACT"/>      
  </xsl:template>
  
  <!-- List of characters -->

  <xsl:template match="PERSONAE">
    <h2><xsl:value-of select="TITLE"/></h2>
    <ul>
      <xsl:apply-templates select="PERSONA | PGROUP"/>
    </ul>
  </xsl:template>
  
  <xsl:template match="PERSONA">
    <li><xsl:value-of select="."/></li>
  </xsl:template>

  <xsl:template match="PGROUP">
    <li>
      <xsl:for-each select="PERSONA">
        <xsl:value-of select="."/>
        <xsl:text>, </xsl:text>
      </xsl:for-each>
      <xsl:value-of select="GRPDESCR"/>
    </li>
  </xsl:template>

  <!-- Acts and scenes -->
  
  <xsl:template match="SCNDESCR">
    <p><b><xsl:value-of select="."/></b></p>
  </xsl:template>
  
  <xsl:template match="ACT">
    <h2><xsl:value-of select="TITLE"/></h2>
    <xsl:apply-templates select="SCENE"/>          
  </xsl:template>

  <xsl:template match="SCENE">
    <h3><xsl:value-of select="TITLE"/></h3>
    <xsl:apply-templates select="*"/>          
  </xsl:template>
  
  <!-- Dialogue -->
  
  <xsl:template match="STAGEDIR">
    <p><em><xsl:value-of select="."/></em></p>
  </xsl:template>

  <xsl:template match="SPEECH">
    <xsl:apply-templates select="*"/>          
  </xsl:template>

  <xsl:template match="SPEAKER">
    <p><b><xsl:value-of select="."/></b></p>
  </xsl:template>

  <xsl:template match="LINE">
    <p><xsl:value-of select="."/></p>          
  </xsl:template>
  
</xsl:stylesheet>
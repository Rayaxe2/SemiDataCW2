<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/PLAY">
    <parts>
    <xsl:apply-templates select="PERSONAE/PERSONA | PERSONAE/PGROUP/PERSONA">
      <xsl:sort select="."/>
    </xsl:apply-templates>
    </parts>
  </xsl:template>

  <xsl:template match="PERSONA">
    <xsl:copy-of select="."/>
  </xsl:template>

</xsl:stylesheet>
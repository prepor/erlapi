<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:template match="code">
  <pre><xsl:apply-templates/></pre>
</xsl:template>

<xsl:template match="c">
  <tt><xsl:apply-templates/></tt>
</xsl:template>
<xsl:template match="pre">
  <pre><xsl:apply-templates/></pre>
</xsl:template>

<xsl:template match="p">
  <p><xsl:apply-templates/></p>
</xsl:template>

<!-- <xsl:template match="seealso">
	<a href=""><xsl:apply-templates/></a> (<xsl:value-of select="@marker"/>)
</xsl:template>	 -->

</xsl:stylesheet>
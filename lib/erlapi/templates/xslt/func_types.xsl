<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:template match="/">
	<ul>
    <xsl:for-each select="root/v">
    <b><xsl:value-of select="."/></b><br/>
    </xsl:for-each>
	</ul>

</xsl:template>

</xsl:stylesheet>
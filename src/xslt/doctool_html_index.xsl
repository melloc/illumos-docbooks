<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet xpath-default-namespace="http://docbook.org/ns/docbook"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xl="http://www.w3.org/1999/xlink"
	version="2.0">

<xsl:template match="index">
	<xsl:for-each-group select="//indexterm" group-by="primary/text()">
		<xsl:copy-of select="." />
	</xsl:for-each-group>
</xsl:template>

</xsl:stylesheet>

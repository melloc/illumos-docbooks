<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet xpath-default-namespace="http://docbook.org/ns/docbook"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xl="http://www.w3.org/1999/xlink"
	version="2.0">

<xsl:output
	name="html-page"
	method="html"
	encoding="UTF-8"
	indent="yes"
	omit-xml-declaration="yes" />

<!-- <xsl:param name="href-prefix" tunnel="yes">foobar</xsl:param> -->

<xsl:include href="doctool_html_nav.xsl" />
<xsl:include href="doctool_html_info.xsl" />
<xsl:include href="doctool_html_links.xsl" />
<xsl:include href="doctool_html_inlines.xsl" />
<xsl:include href="doctool_html_tables.xsl" />
<xsl:include href="doctool_html_index.xsl" />

<!-- We don't want to print the title tag except explicitly -->
<xsl:template match="title" />
<xsl:template match="title" mode="print-title">
	<xsl:apply-templates mode="print-title" />
</xsl:template>

<xsl:template match="info">
	<xsl:if test="parent::book">
		<xsl:call-template name="generate-page">
			<xsl:with-param name="contents">
				<p>Part No.: <xsl:value-of select="biblioid[@class = 'pubsnumber']" /></p>
				<p><xsl:value-of select="pubdate" /></p>
				<xsl:apply-templates select="publisher" />
				<xsl:apply-templates select="abstract" />
				<h2>Legal Notice</h2>
				<xsl:apply-templates select="legalnotice" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template match="preface | chapter">
	<xsl:call-template name="generate-page">
		<xsl:with-param name="contents">
			<xsl:apply-templates />
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="page-title">
	<xsl:for-each select="ancestor-or-self::*[1]">
		<xsl:call-template name="title"> 
			<xsl:with-param name="no-tags" tunnel="yes">true</xsl:with-param>
		</xsl:call-template>
	</xsl:for-each>
	<xsl:text> - </xsl:text>
	<xsl:for-each select="ancestor-or-self::*[2]">
		<xsl:call-template name="title"> 
			<xsl:with-param name="no-tags" tunnel="yes">true</xsl:with-param>
		</xsl:call-template>
	</xsl:for-each>
</xsl:template>

<xsl:template name="head">
	<xsl:comment>WARNING: THIS FILE IS AUTO-GENERATED FROM DOCBOOK</xsl:comment>
	<xsl:comment>Sources at https://github.com/rmustacc/illumos-docbooks/</xsl:comment>
	<xsl:variable name="bookinfo" select="ancestor-or-self::book/info" />
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="{abstract/text()}" />
	<meta name="keywords">
		<xsl:attribute name="content">
			<xsl:text>illumos</xsl:text>
			<xsl:for-each select="$bookinfo/keywordset/keyword">
				<xsl:text>, </xsl:text><xsl:value-of select="." />
			</xsl:for-each>
			<xsl:for-each select="keywordset/keyword">
				<xsl:text>,</xsl:text><xsl:value-of select="." />
			</xsl:for-each>
		</xsl:attribute>
	</meta>
	<title><xsl:call-template name="page-title" /></title>
	<link rel="stylesheet" type="text/css" href="https://brick.a.ssl.fastly.net/EB+Garamond:400,400i:f" />
	<link rel="stylesheet" type="text/css" href="https://brick.a.ssl.fastly.net/Source Code Pro:200,300,400,500,600,700,900:f" />
	<link rel="stylesheet" type="text/css" href="style.css" />
	<link rel="shortcut icon" href="https://illumos.org/favicon.ico" />
</xsl:template>

<xsl:template name="navbar">
	<xsl:variable name="current" select="." />
	<nav class="sidebar" role="navigation">
		<a href="/">
			<img src="http://wiki.illumos.org/download/attachments/327686/PhoenixRGB.svg" alt="illumos logo" width="100" />
		</a>
		<ul>
			<xsl:for-each select="../(preface|chapter|info)">
				<li>
					<xsl:call-template name="linked-title" />
					<xsl:if test=". = $current">
						<ul>
							<xsl:for-each select="sect1">
								<li><xsl:call-template name="linked-title" /></li>
							</xsl:for-each>
						</ul>
					</xsl:if>
				</li>
			</xsl:for-each>
			<li>
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="ancestor-or-self::book/@xml:id" />
						<xsl:text>.pdf</xsl:text>
					</xsl:attribute>
					<xsl:text>PDF Version</xsl:text>
				</a>
			</li>
		</ul>
	</nav>
</xsl:template>

<xsl:template name="searchbar">
</xsl:template>

<xsl:template name="footer">
	<footer role="contentinfo">
	</footer>
</xsl:template>

<xsl:template name="make-heading">
	<xsl:param name="level">1</xsl:param>
	<xsl:element name="h{$level}">
		<xsl:call-template name="add-id" />
		<xsl:call-template name="title" />
	</xsl:element>
</xsl:template>

<xsl:template match="sect1">
	<xsl:call-template name="make-heading">
		<xsl:with-param name="level" select="2" />
	</xsl:call-template>
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="sect2">
	<xsl:call-template name="make-heading">
		<xsl:with-param name="level" select="3" />
	</xsl:call-template>
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="sect3">
	<xsl:call-template name="make-heading">
		<xsl:with-param name="level" select="4" />
	</xsl:call-template>
	<xsl:apply-templates />
</xsl:template>

<xsl:template name="make-directions">
	<nav class="content">
		<xsl:for-each select="preceding-sibling::*[1]/@xml:id">
			<a style="float: left;" rel="prev">
				<xsl:attribute name="href">
					<xsl:call-template name="id2href">
						<xsl:with-param name="RefID" select="." />
					</xsl:call-template>
				</xsl:attribute>
				<xsl:text>Previous</xsl:text>
			</a>
		</xsl:for-each>
		<xsl:for-each select="following-sibling::*[1]/@xml:id">
			<a style="float: right;" rel="next">
				<xsl:attribute name="href">
					<xsl:call-template name="id2href">
						<xsl:with-param name="RefID" select="." />
					</xsl:call-template>
				</xsl:attribute>
				<xsl:text>Next</xsl:text>
			</a>
		</xsl:for-each>
	</nav>
</xsl:template>

<xsl:template name="generate-page">
	<xsl:param name="output-prefix" tunnel="yes" />
	<xsl:param name="canonical-base" tunnel="yes" />
	<xsl:param name="contents" />
	<xsl:variable name="filename">
		<xsl:call-template name="generateFileName" />
	</xsl:variable>
	<xsl:result-document
	    format="html-page"
	    href="build/{$output-prefix}/{$filename}">
		<html lang="{ancestor-or-self::book/@xml:lang}">
			<head>
				<link rel="canonical" href="{$canonical-base}/{$filename}" />
				<xsl:call-template name="head" />
			</head>
			<body>
				<xsl:call-template name="navbar" />
				<xsl:call-template name="make-directions" />
				<section id="main" role="main" class="content mod">
					<xsl:call-template name="make-heading" />
					<xsl:copy-of select="$contents" />
				</section>
				<xsl:call-template name="make-directions" />
				<xsl:call-template name="footer" />
			</body>
		</html>
	</xsl:result-document>
</xsl:template>

<xsl:template match="book">
	<xsl:param name="output-prefix" tunnel="yes" />
	<xsl:apply-templates>
		<xsl:with-param name="output-prefix" tunnel="yes">
			<xsl:value-of select="$output-prefix" />
			<xsl:text>/</xsl:text>
			<xsl:value-of select="@xml:id" />
		</xsl:with-param>
		<xsl:with-param
		    name="canonical-base"
		    tunnel="yes"
		    select="info/bibliorelation[@type = 'isversionof' and @class = 'uri']" />
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="/">
	<xsl:apply-templates />
</xsl:template>

</xsl:stylesheet>

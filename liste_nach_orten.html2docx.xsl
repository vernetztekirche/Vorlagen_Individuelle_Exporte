<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl">
<xsl:output
    method="html"
    indent="no"
    encoding="UTF-8"
/>
<xsl:strip-space elements="*" />

<!-- 
Dieses Formatierungsdatei ordnet die Veranstaltungen nach Orten.
-->

<xsl:key name="place" match="Veranstaltung" use="_place_NAME"/>

<xsl:template match="/root/Export">
	<html>
		<head>
			<title>Liste 1</title>
		</head>
		<body>
			<div id="header"><xsl:value-of select="//meta/exportuser"/></div>
			
			<div id="footer"><span style="font-size:10px;">Stand: <xsl:value-of select="php:function('strftime','%e.%m.%Y %H:%M')"/> Uhr; Exportzeitraum:
			        <xsl:value-of select="php:function('xsl_strftimeformat','%e.%m.%y',string(//meta/exportstart))"/> bis <xsl:value-of select="php:function('xsl_strftimeformat','%e.%m.%y',string(//meta/exportend))"/></span></div>
			
			<div id="content">
		<xsl:call-template name="veranstaltungen"/>
		</div>
	</body>
</html>
</xsl:template>


<xsl:template name="veranstaltungen">
<xsl:for-each select="Veranstaltung[generate-id(.)=generate-id(key('place',_place_NAME)[1])]">
<xsl:sort select="_place_NAME"/>
	<xsl:for-each select="key('place',_place_NAME)">
	<xsl:sort select="START"/>
	<xsl:if test="position() = 1">
	 <p style="font-weight:bold;margin-bottom:3px;"><xsl:value-of select="_place_NAME"/></p>
	</xsl:if>
	<p style="margin-top:0;margin-bottom:3pt;"><xsl:value-of select="_event_TITLE"/>
	: 
	<xsl:value-of select="WOCHENTAG_START_KURZ"/>, <xsl:value-of select="START_DATUM"/>, 
	<xsl:value-of select="START_UHRZEIT"/> Uhr</p>
	</xsl:for-each>
	
</xsl:for-each>

</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl">
<xsl:output
    method="html"
    indent="no"
    encoding="UTF-8"
/>
<xsl:strip-space elements="*" />
<xsl:variable name="space">
<xsl:text> </xsl:text>
</xsl:variable>


<xsl:template match="/root/Export">
<html>
	<head>
		<title>Liste 4 mit allen Detailinformationen</title>
        
<style type="text/css">
* {
	font-family:Arial, Helvetica, sans-serif;
}
#footer {
	font-size:9pt;
	color:#333333;
}
p {
	font-size:12pt;
}
.label {
	color:#666666;
}
.detail {
	margin-left:30px;
	text-indent:-30px;
	font-size:11pt;
}
.title {
	font-size:12pt;
}
</style>
	</head>
	<body>
    
<div id="header"><xsl:value-of select="meta/exportuser"/></div>

<div id="footer">Export Veranstaltungskalender :: Stand: <xsl:value-of select="meta/exportdatetime"/> Uhr</div>


<div id="content">

	<xsl:call-template name="veranstaltungen"/>
 </div>

</body>
</html>
</xsl:template>


<!-- Veranstaltungen nach Datum mit Detailangaben -->

<xsl:template name="veranstaltungen">
  <xsl:for-each select="Veranstaltung">
  <xsl:variable name="last" select="START_DATUM" />
 
  <xsl:if test="not(preceding-sibling::Veranstaltung[START_DATUM=$last])">
	<p><strong><xsl:value-of select="WOCHENTAG_START_LANG"/>, <xsl:value-of select="START_DATUM"/><xsl:value-of select="START_JAHR"/><xsl:if test="LITURG_BEZ!=''" ><xsl:value-of select="$space" />-<xsl:value-of select="$space" /><xsl:value-of select="LITURG_BEZ"/></xsl:if></strong></p>
  </xsl:if>
	
<p class="detail">
<span class="title"><xsl:value-of select="DATUM2"/><xsl:value-of select="$space" />:<xsl:value-of select="$space" /><xsl:value-of select="_event_TITLE"/> <xsl:value-of select="SUBTITLE"/></span><br />

<xsl:for-each select="_inputmask_FIELDS/*">
	<xsl:variable name="field" select="name()" />
    <xsl:choose>
	<xsl:when test="../../*[name()=$field]='' or $field='_event_TITLE' or $field='_event_FEEDBACK_ID'">
    <!-- nichts ausgeben -->
	</xsl:when>
    <xsl:when test="$field='_event_PLACE_ID'">
		<span class="label"><xsl:value-of select="../../*[name()=$field]/@Label" /></span>:<xsl:value-of select="$space" /><xsl:call-template name="place"/>
	</xsl:when>
    <xsl:when test="$field='_event_PERSON_ID'">
	<xsl:call-template name="person"/>
	</xsl:when>
    <xsl:otherwise>
		<span class="label"><xsl:value-of select="../../*[name()=$field]/@Label" /></span>:<xsl:value-of select="$space" /><xsl:value-of select="../../*[name()=$field]" /><br />
	</xsl:otherwise>
	</xsl:choose>
</xsl:for-each>
<xsl:if test="CHANNELS!=''" ><span class="label">Kanäle: </span><xsl:value-of select="$space" /><xsl:value-of select="CHANNELS"/><br /></xsl:if>
</p>
   </xsl:for-each>
   
 
</xsl:template>

<!-- Ort -->
<xsl:template name="place">
	<xsl:value-of select="../../_place_NAME"/><xsl:if test="../../_place_STREET_NR!=''" >,<xsl:value-of select="$space" /><xsl:value-of select="../../_place_STREET_NR"/></xsl:if><xsl:if test="../../_place_ZIP!='' or ../../_place_CITY!=''" >,<xsl:value-of select="$space" /><xsl:value-of select="../../_place_ZIP"/><xsl:value-of select="$space" /><xsl:value-of select="../../_place_CITY"/></xsl:if><br  />
</xsl:template>

<!-- Person -->
<xsl:template name="person">
<xsl:if test="../../_event_PERSON_ID!=''" >
	<span class="label">mit</span>:<xsl:value-of select="$space" /><xsl:value-of select="../../_person_NAME"/><xsl:if test="../../_person_EMAIL!=''" ><xsl:value-of select="$space" />(<xsl:value-of select="../../_person_EMAIL"/>)</xsl:if><br /></xsl:if>
</xsl:template>

</xsl:stylesheet>
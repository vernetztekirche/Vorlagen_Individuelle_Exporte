<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output
    method="text"
    indent="no"
    encoding="UTF-8"
/>
<xsl:strip-space elements="*" />


<xsl:template match="/root/Export">"Datum";"Titel";"Kurzbeschreibung";"Ort"
<xsl:call-template name="veranstaltungen"/>
</xsl:template>

<xsl:variable name="newline">
<xsl:text>
</xsl:text>
</xsl:variable>


<xsl:template name="veranstaltungen">
<xsl:for-each select="Veranstaltung">"<xsl:value-of select="DATUM"/>";"<xsl:value-of select="_event_TITLE"/>";"<xsl:value-of select="_event_SHORT_DESCRIPTION"/>";"<xsl:value-of select="_place_NAME"/>"
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
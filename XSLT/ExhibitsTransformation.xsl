<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="xs"
version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:variable name="baseURI">https://data.discovernewfields.org/</xsl:variable>
    <xsl:variable name="crm">http://www.cidoc-crm.org/cidoc-crm/</xsl:variable>
    
<xsl:template match="/">{"exhibitions": [
    <xsl:for-each select="table[@name='eevents']/tuple"><xsl:sort select="atom[@name='irn']" data-type="number"/><xsl:variable name="irn"><xsl:value-of select="atom[@name='irn']"/></xsl:variable><xsl:variable name="title"><xsl:value-of select="replace(atom[@name='EveEventTitle'], '&quot;', '\\&quot;')"/></xsl:variable>{<!--
        
Header-->
        "<xsl:copy-of select="$irn"/>": {
            "@context": "https://linked.art/ns/v1/linked-art.json",
            "id": "<xsl:copy-of select="$baseURI"/>exhibit/<xsl:copy-of select="$irn"/>/concept",
            "type": "PropositionalObject",
            "_label": "Concept for <xsl:copy-of select="$title"/>",<!--
                
Classification-->
            "classified_as": [
                {
                    "id": "http://vocab.getty.edu/aat/300417531", 
                    "type": "Type", 
                    "_label": "Exhibition"
                }
            ]
        }
    }<xsl:if test="position() != last()">,
    </xsl:if>
        </xsl:for-each>
]
}
    </xsl:template>
</xsl:stylesheet>
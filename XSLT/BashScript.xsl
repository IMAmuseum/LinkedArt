<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"/>
<!--Note: This transformation outputs a bash script with a cat command per object in the input file. Each command includes the input filename, which will need to be modified when the workflow is set with a final filename for combined JSON file.-->
<xsl:template match="/">#!/bin/bash
<xsl:for-each select="table[@name='ecatalogue']/tuple">
cat ObjectsSample.json | jq '.objects[]."<xsl:value-of select="atom[@name='irn']"/>"//empty' > <xsl:value-of select="atom[@name='irn']"/>.json
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
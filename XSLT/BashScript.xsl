<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"/>
<!--Note: Ideally, this transformation would not be necessary. Instead, we hope to use a bash script with a for loop that stores the object keys as an array and runs the cat command per key as f variable to output a json file [key].json. Having trouble getting the stand-alone bash script to work at this time.

This transformation outputs a bash script with a cat command per object in the input file. Each command includes the input filename, which will need to be modified when the workflow is set with a final filename for combined JSON file.-->
<xsl:template match="/">#!/bin/bash
<xsl:for-each select="table[@name='ecatalogue']/tuple">
mkdir -p objects/<xsl:value-of select="round(atom[@name='irn'] div 100) * 100"/>/<xsl:value-of select="atom[@name='irn']"/>
cat ObjectsSample.json | jq '.objects[]."<xsl:value-of select="atom[@name='irn']"/>"//empty' > objects/<xsl:value-of select="round(atom[@name='irn'] div 100) * 100"/>/<xsl:value-of select="atom[@name='irn']"/>/<xsl:value-of select="atom[@name='irn']"/>.json
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
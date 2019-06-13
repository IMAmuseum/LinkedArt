<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:variable name="baseURI">https://data.discovernewfields.org/</xsl:variable>
    <xsl:variable name="crm">http://www.cidoc-crm.org/cidoc-crm/</xsl:variable>

<xsl:template match="/">{"objects": [
    <xsl:for-each select="table[@name='ecatalogue']/tuple"><xsl:sort select="atom[@name='irn']" data-type="number"/><xsl:variable name="irn"><xsl:value-of select="atom[@name='irn']"/></xsl:variable><xsl:variable name="title"><xsl:value-of select="replace(atom[@name='TitMainTitle'], '&quot;', '\\&quot;')"/></xsl:variable>{<!--
        
Header-->
        "<xsl:copy-of select="$irn"/>": {
            "@context": "https://linked.art/ns/v1/linked-art.json",
            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>",
            "type": "HumanMadeObject",
            "_label": "<xsl:copy-of select="$title"/>",<!--
                
Classification-->
            "classified_as": [
                {
                    "id": "http://vocab.getty.edu/aat/300133025",
                    "type": "Type",
                    "_label": "works of art"
                }<xsl:if test="table[@name='ObjectTypes']/tuple/atom[@name='PhyMediaCategory'] != '' ">,<xsl:for-each select="distinct-values(table[@name='ObjectTypes']/tuple/atom[@name='PhyMediaCategory'])">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>thesauri/type/<xsl:value-of select="lower-case(translate(replace(.,'[^a-zA-Z0-9 ]',''), ' ', '-'))"/>",
                    "type": "Type",
                    "_label": "<xsl:value-of select="."/>"
                }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each></xsl:if>
            ],<!--
                
Identifiers-->
            "identified_by": [
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/irn",
                    "type": "Identifier",
                    "_label": "IMA at Newfields Collections Database Number for the Artwork",
                    "content": <xsl:copy-of select="$irn"/>,
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300404621",
                            "type": "Type",
                            "_label": "repository numbers"
                        }
                    ]
                },
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/accession-number",
                    "type": "Identifier",
                    "_label": "IMA at Newfields Accession Number for the Artwork",
                    "content": "<xsl:value-of select="atom[@name='TitAccessionNo']"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300312355",
                            "type": "Type",
                            "_label": "accession numbers"
                        }
                    ]
                }<xsl:if test="atom[@name='TitPreviousAccessionNo'] != ''"><xsl:choose><xsl:when test="not(contains(atom[@name='TitPreviousAccessionNo'], '|')) and atom[@name='TitPreviousAccessionNo'] != 'No TR Number'">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/old-accession-number/1",
                    "type": "Identifier",
                    "_label": "Identifier Assigned to the Artwork by IMA at Newfields Prior to Official Acquisition",
                    "content": "<xsl:value-of select="atom[@name='TitPreviousAccessionNo']"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300404626",
                            "type": "Type",
                            "_label": "identification numbers"
                        }
                    ]
                }</xsl:when><xsl:when test="contains(atom[@name='TitPreviousAccessionNo'], '|')"><xsl:for-each select="tokenize(atom[@name='TitPreviousAccessionNo'],' \| ')"><xsl:if test="not(contains(., '|'))">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/old-accession-number-<xsl:value-of select="position()"/>",
                    "type": "Identifier",
                    "_label": "Identifier Assigned to the Artwork by IMA at Newfields Prior to Official Acquisition",
                    "content": "<xsl:value-of select="."/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300404626",
                            "type": "Type",
                            "_label": "identification numbers"
                        }
                    ]
                }</xsl:if></xsl:for-each>
                </xsl:when><xsl:otherwise/></xsl:choose></xsl:if>,<!--
                    
Titles-->
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/title",
                    "type": "Name",
                    "_label": "Primary Title for the Artwork",
                    "content": "<xsl:copy-of select="$title"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300404670",
                            "type": "Type",
                            "_label": "preferred terms"
                        }
                    ]
                }<xsl:if test="table[@name='AltTitles']"><xsl:for-each select="table[@name='AltTitles']/tuple">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/alt-title-<xsl:value-of select="position()"/>",
                    "type": "Name",
                    "_label": "Alternate Title for the Artwork",
                    "content": "<xsl:value-of select="atom[@name='TitAlternateTitles']"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300417227",
                            "type": "Type",
                            "_label": "alternate titles"
                        }
                    ]
                }
            </xsl:for-each>
            </xsl:if><xsl:if test="atom[@name='TitSeriesTitle'] != ''">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/series-title",
                    "type": "Name",
                    "_label": "Title of the Series of Works of which the Artwork is a Part",
                    "content": "<xsl:value-of select="atom[@name='TitSeriesTitle']"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300417214",
                            "type": "Type",
                            "_label": "series title"
                        }
                    ]
                }</xsl:if><xsl:if test="atom[@name='TitCollectionTitle'] != ''">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/portfolio-title",
                    "type": "Name",
                    "_label": "Title of the Portfolio of which the Artwork is a Part",
                    "content": "<xsl:value-of select="atom[@name='TitSeriesTitle']"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300417225",
                            "type": "Type",
                            "_label": "volume titles"
                        }
                    ]
                }</xsl:if>
        ]<xsl:if test="table[@name='Medium'] or table[@name='Support']">,<!--  
            
Materials-->
            "made_of": [<xsl:for-each select="distinct-values(table[@name='Medium']/tuple/atom[@name='PhyMedium'] | table[@name='Support']/tuple/atom[@name='PhySupport'])">
                {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/material/<xsl:value-of select="lower-case(translate(replace(.,'[^a-zA-Z0-9 ]',''), ' ', '-'))"/>",
                "type": "Material",
                "_label": "Material of Which the Object is Composed",
                "content": "<xsl:value-of select="."/>"
                }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each>
            ]</xsl:if>,<!--

Production-->
            "produced_by": {
                "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/production",
                "type": "Production",
                "_label": "Production of <xsl:copy-of select="$title"/>"<xsl:if test="table[@name='Creator1'] or table[@name='Creator2']/tuple/atom[@name='CreCreationCultureOrPeople']"><xsl:choose><xsl:when test="table[@name='Creator1']">,
                "carried_out_by": [<xsl:for-each select="table[@name='Creator1']/tuple[atom[@name='irn'] != '2741'] | table[@name='Creator1']/tuple[atom[@name='irn'] != '10661'] | table[@name='Creator1']/tuple[not(exists(atom[@name='CreCreatorAfterFollower']))]">
                    {
                        "id": "<xsl:copy-of select="$baseURI"/>actor/<xsl:copy-of select="$irn"/>",
                        "type": "Actor",
                        "_label": "<xsl:value-of select="atom[@name='SummaryData']"/>"
                    }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each></xsl:when><xsl:when test="table[@name='Creator2']/tuple[atom[@name='CreCreationCultureOrPeople']]">,
                "carried_out_by": [<xsl:for-each select="table[@name='Creator2']/tuple[atom[@name='CreCreationCultureOrPeople']]">
                    {
                    "id": "<xsl:copy-of select="$baseURI"/>thesauri/culture/<xsl:value-of select="lower-case(translate(replace(atom[@name='CreCreationCultureOrPeople'],'[^a-zA-Z0-9 ]',''), ' ', '-'))"/>",
                        "type": "Actor",
                        "_label": "<xsl:value-of select="atom[@name='CreCreationCultureOrPeople']"/>"
                    }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each></xsl:when><xsl:otherwise/></xsl:choose>             
                ]</xsl:if>
            },<xsl:if test="table[@name='Color']"><!--

Dimensions--><xsl:if test="table[@name='Color']"><xsl:choose><xsl:when test="not(contains(table[@name='Color']/tuple/atom[@name='PhyColor'], '|'))">
            "dimension": [
                {
                    "type": "Dimension",
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/color-1",
                    "_label": "Color Visibly Identified by IMA staff on Part of the Work",
                    "classified_as": [ 
                        {
                            "id": "<xsl:copy-of select="$baseURI"/>thesauri/color/<xsl:value-of select="lower-case(translate(replace(table[@name='Color']/tuple/atom[@name='PhyColor'],'[^a-zA-Z0-9 ]',''), ' ', '-'))"/>",
                            "type": "Type",
                            "_label": "<xsl:value-of select="lower-case(table[@name='Color']/tuple/atom[@name='PhyColor'])"/>"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/colorness",
                            "type": "Type",
                            "_label": "Color"
                        }
                    ]
                }
            ],</xsl:when><xsl:otherwise>
            "dimension": [<xsl:for-each select="tokenize(table[@name='Color']/tuple/atom[@name='PhyColor'],' \| ')">
                {
                    "type": "Dimension",
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/color-<xsl:value-of select="position()"/>",
                    "_label": "Color Visibly Identified by IMA staff on Part of the Work",
                    "classified_as": [ 
                        {
                            "id": "<xsl:copy-of select="$baseURI"/>thesauri/color/<xsl:value-of select="lower-case(translate(replace(.,'[^a-zA-Z0-9 ]',''), ' ', '-'))"/>",
                            "type": "Type",
                            "_label": "<xsl:value-of select="lower-case(.)"/>"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/colorness",
                            "type": "Type",
                            "_label": "Color"
                        }
                    ]
                }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each>
            ],</xsl:otherwise></xsl:choose></xsl:if></xsl:if><!--
                
Owner-->
            "current_owner": {
                "id": "http://vocab.getty.edu/ulan/500300517",
                "type": "Group",
                "_label": "Indianapolis Museum of Art at Newfields",
                "classified_as": [
                    {
                        "id": "http://vocab.getty.edu/aat/300312281",
                        "type": "Type",
                        "_label": "museums (institutions)"
                    }
                ],<!--
                    
Acquisition-->
                "acquired_title_through": [
                    {
                        "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/IMA-acquisition",
                        "type": "Acquisition",
                        "_label": "Acquisition of <xsl:copy-of select="$title"/>",
                        "classified_as": [
                            {
                                "id": "http://vocab.getty.edu/aat/300157782",
                                "type": "Type",
                                "_label": "acquisition (collections management)"
                            }
                        ],
                        "took_place_at": [
                            {
                                "id": "http://vocab.getty.edu/tgn/7012924", 
                                "type": "Place", 
                                "_label": "Indianapolis, Indiana"
                            }
                        ]<xsl:if test="atom[@name='TitAccessionDate'] != ''">,
                        "timespan": {
                            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/IMA-acquisition-timespan", 
                            "type": "TimeSpan", 
                            "_label": "<xsl:value-of select="atom[@name='TitAccessionDate']"/>",<xsl:choose><xsl:when test="string-length(atom[@name='TitAccessionDate']) = 4">
                            "begin_of_the_begin": "<xsl:value-of select="atom[@name='TitAccessionDate']"/>-01-01T00:00:00Z", 
                            "end_of_the_end": "<xsl:value-of select="atom[@name='TitAccessionDate']"/>-12-31T00:00:00Z"</xsl:when><xsl:when test="string-length(atom[@name='TitAccessionDate']) = 8">
                            "begin_of_the_begin": "<xsl:value-of select="atom[@name='TitAccessionDate']"/>01T00:00:00Z", 
                            "end_of_the_end": "<xsl:value-of select="atom[@name='TitAccessionDate']"/><xsl:if test="contains(atom[@name='TitAccessionDate'], '-02-')">28</xsl:if><xsl:if test="contains(atom[@name='TitAccessionDate'], '-01-') or contains(atom[@name='TitAccessionDate'], '-03-') or contains(atom[@name='TitAccessionDate'], '-05-') or contains(atom[@name='TitAccessionDate'], '-07-') or contains(atom[@name='TitAccessionDate'], '-08-') or contains(atom[@name='TitAccessionDate'], '-10-') or contains(atom[@name='TitAccessionDate'], '-12-')">31</xsl:if><xsl:if test="contains(atom[@name='TitAccessionDate'], '-04-') or contains(atom[@name='TitAccessionDate'], '-06-') or contains(atom[@name='TitAccessionDate'], '-09-') or contains(atom[@name='TitAccessionDate'], '-11-')">30</xsl:if>T00:00:00Z"</xsl:when><xsl:when test="string-length(atom[@name='TitAccessionDate']) = 10">
                            "begin_of_the_begin": "<xsl:value-of select="atom[@name='TitAccessionDate']"/>T00:00:00Z", 
                            "end_of_the_end": "<xsl:value-of select="atom[@name='TitAccessionDate']"/>T00:00:00Z"</xsl:when></xsl:choose>
                        }</xsl:if>
                    }
                ]<!--
                    
Current Location-->
            }<xsl:if test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] != 'see related parts'"><xsl:choose><xsl:when test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel1'] = 'On Loan'">,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/on-loan",
                "type": "Place",
                "_label": "On Loan"
                }</xsl:when><xsl:when test="contains(tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'], 'Galler') or contains(tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'], 'Suite')">,
            "current_location": {
            "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/<xsl:value-of select="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel3']"/>",
                "type": "Place",
                "_label": "<xsl:value-of select="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2']"/>",
                "clasified_as": [
                    {
                        "id": "http://vocab.getty.edu/aat/300240057",
                        "type": "Type",
                        "_label": "galleries (display spaces)"
                    }
                ]
            }</xsl:when><xsl:when test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] = 'Efroymson Family Entrance'">,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/F02",
                "type": "Place",
                "_label": "Efroymson Family Entrance Pavilion"
            }</xsl:when><xsl:when test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] = 'Nature Park'">,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/ANP",
                "type": "Place",
                "_label": "Virginia B. Fairbanks Art &amp; Nature Park"
            }</xsl:when><xsl:when test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] = 'Grounds'">,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/G",
                "type": "Place",
                "_label": "Newfields Grounds"
            }</xsl:when><xsl:when test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] = 'Asian Visible Storage'">,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/K241",
                "type": "Place",
                "_label": "Leah and Charles Reddish Gallery - Asian Visible Storage",
                "clasified_as": [
                    {
                        "id": "http://vocab.getty.edu/aat/300240057",
                        "type": "Type",
                        "_label": "galleries (display spaces)"
                    }
                ]
            }</xsl:when><xsl:when test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] = 'Westerley'">,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/westerley",
                "type": "Place",
                "_label": "Westerley"
            }</xsl:when><xsl:otherwise>,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/storage",
                "type": "Place",
                "_label": "IMA Storage"
            }</xsl:otherwise></xsl:choose></xsl:if><xsl:if test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] = 'see related parts'"></xsl:if><xsl:if test="atom[@name='SumCreditLine'] != '' or atom[@name='TitTitleNotes'] != '' or atom[@name='PhyConvertedDims'] != '' or atom[@name='PhyMediumAndSupport'] != '' or table[@name='Rights']">,<!--
            
Linquistic Objects-->
            "referred_to_by": [<xsl:if test="atom[@name='SumCreditLine'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/credit-line",
                    "type": "LinguisticObject",
                    "_label": "Indianapolis Museum of Art at Newfields Credit Line for the Work",
                    "content": "<xsl:value-of select="replace(replace(atom[@name='SumCreditLine'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300026687",
                            "type": "Type",
                            "_label": "acknowledgments"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="atom[@name='TitTitleNotes'] != '' or atom[@name='PhyConvertedDimes'] != '' or atom[@name='PhyMediumAndSupport'] != '' or table[@name='Rights']">,</xsl:if></xsl:if><xsl:if test="atom[@name='TitTitleNotes'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/title-statement",
                    "type": "LinguisticObject",
                    "_label": "Notes about the Title(s) Associated with the Work",
                    "content": "<xsl:value-of select="replace(replace(atom[@name='TitTitleNotes'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300417212",
                            "type": "Type",
                            "_label": "title statements"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="atom[@name='PhyConvertedDims'] != '' or atom[@name='PhyMediumAndSupport'] != '' or table[@name='Rights']">,</xsl:if></xsl:if><xsl:if test="atom[@name='PhyConvertedDims'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/dimension-statement",
                    "type": "LinguisticObject",
                    "_label": "Notes about the Dimensions of the Work",
                    "content": "<xsl:value-of select="replace(replace(atom[@name='PhyConvertedDims'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300266036",
                            "type": "Type",
                            "_label": "dimensions"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="atom[@name='PhyMediumAndSupport'] != '' or table[@name='Rights']">,</xsl:if></xsl:if><xsl:if test="atom[@name='PhyMediumAndSupport'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/materials-statement",
                    "type": "LinguisticObject",
                    "_label": "Notes about the Materials in the Work",
                    "content": "<xsl:value-of select="replace(replace(atom[@name='PhyMediumAndSupport'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300010358",
                            "type": "Type",
                            "_label": "materials (substances)"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="table[@name='Rights']">,</xsl:if></xsl:if><xsl:if test="table[@name='Rights']">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/rights-statement",
                    "type": "LinguisticObject",
                    "_label": "Rights Statement",
                    "content": "<xsl:value-of select="replace(replace(table[@name='Rights']/tuple[1]/atom[@name='RigAcknowledgement'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300055547",
                            "type": "Type",
                            "_label": "legal concepts"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="table[@name='Rights']/tuple[1]/atom[@name='RigAcknowledgement'] = 'Public Domain'">,
                {
                    "id": "https://creativecommons.org/publicdomain/mark/1.0/",
                    "type": "LinguisticObject",
                    "_label": "Public Domain",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300055547",
                            "type": "Type",
                            "_label": "legal concepts"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }</xsl:if><xsl:if test="table[@name='Rights']/tuple[1]/atom[@name='RigAcknowledgement'] = 'No Known Rights Holder'">,
                {
                    "id": "http://rightsstatements.org/vocab/NKC/1.0/",
                    "type": "LinguisticObject",
                    "_label": "No Known Copyright",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300055547",
                            "type": "Type",
                            "_label": "legal concepts"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }</xsl:if><xsl:if test="contains(table[@name='Rights']/tuple[1]/atom[@name='RigAcknowledgement'], '©')">,
                {
                    "id": "http://rightsstatements.org/vocab/InC/1.0/",
                    "type": "LinguisticObject",
                    "_label": "In Copyright",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300055547",
                            "type": "Type",
                            "_label": "legal concepts"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }</xsl:if></xsl:if>
            ]</xsl:if><xsl:if test="(atom[@name='AssIsParent'] = 'Yes' and table[@name='Children']) or (table[@name='Dimensions']/tuple[atom[@name=
                'PhyType'] = 'Framed Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name=
                'PhyType'] = 'Sheet Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Image Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Overall Image Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions'])">,<!--

Parts-->
            "part": [<xsl:if test="atom[@name='AssIsParent'] = 'Yes' and table[@name='Children']"><xsl:for-each select="table[@name='Children']/tuple">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>",
                    "type": "HumanMadeObject",
                    "_label": "<xsl:value-of select="replace(atom[@name='TitMainTitle'], '&quot;', '\\&quot;')"/>"
                }<xsl:if test="table[@name='Grandchildren']"><xsl:for-each select="table[@name='Grandchildren']/tuple">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>",
                    "type": "HumanMadeObject",
                    "_label": "<xsl:value-of select="replace(atom[@name='TitMainTitle'], '&quot;', '\\&quot;')"/>"
                }</xsl:for-each></xsl:if><xsl:if test="position() != last()">,</xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Framed Dimensions']) or (table[@name='Dimensions']/tuple/atom[@name=
                    'PhyType'] = 'Sheet Dimensions') or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Image Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Overall Image Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions'])">,</xsl:if></xsl:if><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Framed Dimensions'])"><xsl:for-each select="table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Framed Dimensions']"><xsl:if test="atom[@name='PhyHeight'] != '' or atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/frame-<xsl:value-of select="position()"/>",
                    "type": "HumanMadeObject",
                    "_label": "Frame for <xsl:copy-of select="$title"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300189814",
                            "type": "Type",
                            "_label": "frames (protective furnishings)"
                        }
                    ],<xsl:call-template name="dimensions"><xsl:with-param name="dim_type">frame</xsl:with-param></xsl:call-template>
                }</xsl:if><xsl:if test="position() != last()">,</xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Sheet Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name=
                    'PhyType'] = 'Image Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Overall Image Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions'])">,</xsl:if></xsl:if><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Sheet Dimensions'])"><xsl:for-each select="table[@name='Dimensions']/tuple[atom[@name=
                        'PhyType'] = 'Sheet Dimensions']"><xsl:if test="atom[@name='PhyHeight'] != '' or atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/sheet-<xsl:value-of select="position()"/>",
                    "type": "HumanMadeObject",
                    "_label": "Sheet (support) for <xsl:copy-of select="$title"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300189648",
                            "type": "Type",
                            "_label": "sheets (paper artifacts)"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300014844",
                            "type": "Type",
                            "_label": "supports (artists' materials)"
                        }
                    ],<xsl:call-template name="dimensions"><xsl:with-param name="dim_type">sheet</xsl:with-param></xsl:call-template>
                }<xsl:if test="position() != last()">,</xsl:if></xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Image Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Overall Image Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions'])">,</xsl:if></xsl:if><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Image Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Overall Image Dimensions'])"><xsl:for-each select="table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Image Dimensions'] | table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Overall Image Dimensions']"><xsl:if test="atom[@name='PhyHeight'] != '' or atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/image-<xsl:value-of select="position()"/>",
                    "type": "HumanMadeObject",
                    "_label": "Image part of <xsl:copy-of select="$title"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300264387",
                            "type": "Type",
                            "_label": "images (object genre)"
                        }
                    ],<xsl:call-template name="dimensions"><xsl:with-param name="dim_type">image</xsl:with-param></xsl:call-template>
                }<xsl:if test="position() != last()">,</xsl:if></xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions'])">,</xsl:if></xsl:if><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions'])"><xsl:for-each select="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions'])"><xsl:if test="atom[@name='PhyHeight'] != '' or atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/base-<xsl:value-of select="position()"/>",
                    "type": "HumanMadeObject",
                    "_label": "Base part of <xsl:copy-of select="$title"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300001656",
                            "type": "Type",
                            "_label": "bases (object components)"
                        }
                    ],<xsl:call-template name="dimensions"><xsl:with-param name="dim_type">base</xsl:with-param></xsl:call-template>
                }<xsl:if test="position() != last()">,</xsl:if></xsl:if></xsl:for-each></xsl:if>
            ]</xsl:if><xsl:if test="(atom[@name='AdmPublishWebNoPassword'] = 'Yes') and (table[@name='Homepage']/tuple[atom[@name='EleIdentifier'] != ''])">,<!--
                
Homepage-->
            "subject-of": [
                {
                    "id": "http://collection.imamuseum.org/artwork/<xsl:value-of select="table[@name='Homepage']/tuple/atom[@name='EleIdentifier']"/>/",
                    "type": "LinguisticObject",
                    "_label": "Homepage for <xsl:copy-of select="$title"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab/getty.edu/aat/300264578",
                            "type": "Type",
                            "_label": "Web pages (documents)"
                        }
                    ],
                    "format": "text/html"
                }
            ]</xsl:if>
        }
    }<xsl:if test="position() != last()">,
    </xsl:if>
        </xsl:for-each>
]}</xsl:template>

<!--Dimensions Template-->
<xsl:template name="dimensions"><xsl:param name="dim_type"/><xsl:variable name="irn"><xsl:value-of select="ancestor::tuple/atom[@name='irn']"/></xsl:variable><xsl:variable name="title"><xsl:value-of select="replace(ancestor::tuple/atom[@name='TitMainTitle'], '&quot;', '\\&quot;')"/></xsl:variable>
                    "dimension": [<xsl:if test="atom[@name='PhyHeight'] != ''">
                        {
                            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/<xsl:value-of select="$dim_type"/>-<xsl:value-of select="position()"/>/height",
                            "type": "Dimension",
                            "value": "<xsl:value-of select="atom[@name='PhyHeight']"/>",
                            "classified_as": [
                                {
                                    "id": "http://vocab.getty.edu/aat/300055644",
                                    "type": "Type",
                                    "_label": "height"
                                }
                            ]<xsl:if test="atom[@name='PhyUnitLength'] = 'in.'">,
                            "unit": {
                                "id": "http://vocab.getty.edu/aat/300379100",
                                "type": "Type",
                                "_label": "inches"
                            }</xsl:if><xsl:if test="atom[@name='PhyUnitLength'] = 'cm.'">,
                            "unit": {
                                "id": "http://vocab.getty.edu/aat/300379098",
                                "type": "Type",
                                "_label": "centimeters"
                            }</xsl:if>
                        }<xsl:if test="atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">,</xsl:if></xsl:if><xsl:if test="atom[@name='PhyWidth'] != ''">
                        {
                            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/<xsl:value-of select="$dim_type"/>-<xsl:value-of select="position()"/>/width",
                            "type": "Dimension",
                            "value": "<xsl:value-of select="atom[@name='PhyWidth']"/>",
                            "classified_as": [
                                {
                                    "id": "http://vocab.getty.edu/aat/300055647",
                                    "type": "Type",
                                    "_label": "width"
                                }
                            ]<xsl:if test="atom[@name='PhyUnitLength'] = 'in.'">,
                            "unit": {
                                "id": "http://vocab.getty.edu/aat/300379100",
                                "type": "Type",
                                "_label": "inches"
                            }</xsl:if><xsl:if test="atom[@name='PhyUnitLength'] = 'cm.'">,
                            "unit": {
                                "id": "http://vocab.getty.edu/aat/300379098",
                                "type": "Type",
                                "_label": "centimeters"
                            }</xsl:if>
                        }<xsl:if test="atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">,</xsl:if></xsl:if><xsl:if test="atom[@name='PhyDepth'] != ''">
                        {
                            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/<xsl:value-of select="$dim_type"/>-<xsl:value-of select="position()"/>/depth",
                            "type": "Dimension",
                            "value": "<xsl:value-of select="atom[@name='PhyDepth']"/>",
                            "classified_as": [
                                {
                                    "id": "http://vocab.getty.edu/aat/300072633",
                                    "type": "Type",
                                    "_label": "depth (size/dimension)"
                                }
                            ]<xsl:if test="atom[@name='PhyUnitLength'] = 'in.'">,
                            "unit": {
                                "id": "http://vocab.getty.edu/aat/300379100",
                                "type": "Type",
                                "_label": "inches"
                            }</xsl:if><xsl:if test="atom[@name='PhyUnitLength'] = 'cm.'">,
                            "unit": {
                                "id": "http://vocab.getty.edu/aat/300379098",
                                "type": "Type",
                                "_label": "centimeters"
                            }</xsl:if>
                        }<xsl:if test="atom[@name='PhyDiameter'] != ''">,</xsl:if></xsl:if><xsl:if test="atom[@name='PhyDiameter'] != ''">
                        {
                            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/<xsl:value-of select="$dim_type"/>-<xsl:value-of select="position()"/>/depth",
                            "type": "Dimension",
                            "value": "<xsl:value-of select="atom[@name='PhyDiameter']"/>",
                            "classified_as": [
                                {
                                    "id": "http://vocab.getty.edu/aat/300055624",
                                    "type": "Type",
                                    "_label": "diameter"
                                }
                            ]<xsl:if test="atom[@name='PhyUnitLength'] = 'in.'">,
                            "unit": {
                                "id": "http://vocab.getty.edu/aat/300379100",
                                "type": "Type",
                                "_label": "inches"
                            }</xsl:if><xsl:if test="atom[@name='PhyUnitLength'] = 'cm.'">,
                            "unit": {
                                "id": "http://vocab.getty.edu/aat/300379098",
                                "type": "Type",
                                "_label": "centimeters"
                            }</xsl:if>
                        }</xsl:if>
                    ]</xsl:template>
</xsl:stylesheet>
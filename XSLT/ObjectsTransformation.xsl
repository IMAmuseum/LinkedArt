<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:variable name="baseURI">https://data.discovernewfields.org/</xsl:variable>
    <xsl:variable name="crm">http://www.cidoc-crm.org/cidoc-crm/</xsl:variable>

<xsl:template match="/">{"objects": [
    <xsl:for-each select="table[@name='ecatalogue']/tuple"><xsl:sort select="atom[@name='irn']" data-type="number"/><xsl:variable name="irn"><xsl:value-of select="atom[@name='irn']"/></xsl:variable>{<!--
        
Header-->
        "<xsl:value-of select="atom[@name='irn']"/>": {
            "@context": "https://linked.art/ns/v1/linked-art.json",
            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>",
            "type": "ManMadeObject",
            "_label": "<xsl:value-of select="replace(atom[@name='TitMainTitle'], '&quot;', '\\&quot;')"/>",<!--
                
Classification-->
            "classified_as": [
                {
                    "id": "http://vocab.getty.edu/aat/300133025",
                    "type": "Type",
                    "_label": "works of art"
                }<xsl:if test="table[@name='ObjectTypes']/tuple/atom[@name='PhyMediaCategory'] != '' ">,<xsl:for-each select="table[@name='ObjectTypes']/tuple">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>thesauri/type/<xsl:value-of select="lower-case(translate(atom[@name='PhyMediaCategory'], ' ', '-'))"/>",
                    "type": "Type",
                    "_label": "<xsl:value-of select="atom[@name='PhyMediaCategory']"/>"
                }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each></xsl:if>
            ],<!--
                
Identifiers-->
            "identified_by": [
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/irn",
                    "type": "Identifier",
                    "_label": "IMA at Newfields Collections Database Number for the Artwork",
                    "content": <xsl:value-of select="atom[@name='irn']"/>,
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300404621",
                            "type": "Type",
                            "_label": "repository numbers"
                        }
                    ]
                },
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/accession-number",
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
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/old-accession-number/1",
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
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="$irn"/>/old-accession-number-<xsl:value-of select="position()"/>",
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
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/title",
                    "type": "Name",
                    "_label": "Primary Title for the Artwork",
                    "content": "<xsl:value-of select="atom[@name='TitMainTitle']"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300404670",
                            "type": "Type",
                            "_label": "preferred terms"
                        }
                    ]
                }<xsl:if test="table[@name='AltTitles']"><xsl:for-each select="table[@name='AltTitles']/tuple">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/alt-title-<xsl:value-of select="position()"/>",
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
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/series-title",
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
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/portfolio-title",
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
            ],<!--
                
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
                        "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/IMA-acquisition",
                        "type": "Acquisition",
                        "_label": "Acquisition of <xsl:value-of select="atom[@name='TitMainTitle']"/>",
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
                            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/IMA-acquisition-timespan", 
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
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/credit-line",
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
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/title-statement",
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
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/dimension-statement",
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
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/materials-statement",
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
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>/rights-statement",
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
            ]</xsl:if><xsl:if test="atom[@name='AssIsParent'] = 'Yes' and table[@name='Children']">,<!--

Parts-->
            "part": [<xsl:for-each select="table[@name='Children']/tuple">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>",
                    "type": "ManMadeObject",
                    "_label": "<xsl:value-of select="atom[@name='TitMainTitle']"/>"
                }<xsl:if test="table[@name='Grandchildren']"><xsl:for-each select="table[@name='Grandchildren']/tuple">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>",
                    "type": "ManMadeObject",
                    "_label": "<xsl:value-of select="atom[@name='TitMainTitle']"/>"
                }</xsl:for-each></xsl:if><xsl:if test="position() != last()">,</xsl:if></xsl:for-each>
            ]</xsl:if>
        }
    }<xsl:if test="position() != last()">,
    </xsl:if>
        </xsl:for-each>
]}</xsl:template>
</xsl:stylesheet>
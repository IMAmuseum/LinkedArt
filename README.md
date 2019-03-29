# IMA Linked Art Data
This repository documents the Indianapolis Museum of Art at Newfields' process for transforming data contained in the museum's collection management system, EMu, to conform to the Linked Art data standard (JSON-LD). The Linked Art data model is in active development, so the IMA transformation and data files will evolve along with that development. Information about the Linked Art model can be found at https://linked.art/.

## Source Data (XML)
Data sourced from EMu will reflect the scope of the Linked Art model, and also align with Newfields' priorities for publishing linked data online. At this time, the following art-related information is in scope:

- Objects (EMu source: Catalogue, Rights, Narratives, and Locations modules)
- Creators (EMu source: Parties module)
- Exhibitions (EMu source: Events, Catalogue, and Parties module)

Sample data files representing these categories will be made available in this repository. Data exported from EMu is in the XML format.

Due to lack of structured data, object Provenance will not be fully modeled as linked data. Available Provenance information will be published as a E33_Linguistic_Object of E55_Type http://vocab.getty.edu/aat/300055863.

## Data Transformation (XSLT)
EMu fields are being mapped to corresponding components of the Linked Art model. Mapping determinations are being made by Newfields' Digital Collections Manager, Samantha Norling, in consultation with Registration and Curatorial staff. When necessary, cataloging practices are being adjusted to facilitate the creation of linked data.

The recommended data serialization of the Linked Art model is JSON-LD. In order to transform the export XML files to JSON-LD, XSLT is utilized. This repository will contain transformation files for each of the categories of exported EMu data.

## JSON-LD
Sample JSON-LD files will be included in this repository and will reflect the transformation of the corresponding XML by the corresponding XSLT file. For example, ObjectsSample.json would be the output of running ObjectsTransformation.xsl against ObjectsSample.xml.

Once the transformation files are finalized, a more complete JSON-LD Linked Art representation of the IMA collection (currently 63,629 individual records, including parts and parent objects) will be published online.

### Contact
Samantha Norling, Digital Collections Manager, Newfields

snorling @ discovernewfields.org

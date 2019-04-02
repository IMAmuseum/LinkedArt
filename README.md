# IMA Linked Art Data
This repository documents the Indianapolis Museum of Art at Newfields' process for transforming data contained in the museum's collection management system, EMu, to conform to the Linked Art data standard (serialized as JSON-LD). The Linked Art data model is in active development, so the IMA transformation and data files will evolve along with that development. Information about the Linked Art model can be found at https://linked.art/.

## Source Data (XML)
Data sourced from EMu will reflect the scope of the Linked Art model, and also align with Newfields' priorities for publishing linked data online. At this time, the following art-related information is in scope:

- Objects (EMu source: Catalogue, Rights, Narratives, and Locations modules)
- Creators (EMu source: Parties module)
- Exhibitions (EMu source: Events, Catalogue, and Parties module)

Sample data files representing these categories will be made available in this repository. Data exported from EMu is in the XML format.

Due to lack of structured data, object Provenance will not be fully modeled as linked data. Available Provenance information will be published as a E33_Linguistic_Object of E55_Type http://vocab.getty.edu/aat/300055863.

## Data Transformation (XSLT)
EMu fields are being mapped to corresponding components of the Linked Art model. Mapping determinations are being made by Newfields' Digital Collections Manager, Samantha Norling, in consultation with Registration and Curatorial staff. When necessary, cataloging practices are being adjusted and/or source data is being cleaned in order to facilitate the creation of linked data.

The recommended data serialization of the Linked Art model is JSON-LD. In order to transform the export XML files to JSON-LD, XSLT will be utilized. This repository will contain transformation files for each of the categories of exported EMu data.

## JSON-LD (JSON)
Sample JSON-LD files will be included in this repository and will correspond to provided raw data files exported from EMu (XML). These JSON-LD files will reflect the current XSLT transformations of the source data. Where possible, example data files will represent specific portions of the Linked Art model - particularly those that are being actively discussed by the Linked Art Editorial Board. This will include more complex portions of the model (e.g., partitioning).

Once the transformation files are finalized, a more complete JSON-LD Linked Art representation of the IMA collection (currently 63,629 individual records, including parts and parent objects) will be published online.

## Documentation
This directory contains miscellaneous workflow documents. At this time, this directory includes:
- LAB_LinkedArt_ModelTracking.xlsx - spreadsheet for tracking the status of modeling IMA data to fields/patterns within the Linked Art data model

## Issues
Issues are being created to track EMu clean-up needs (internal work), open questions, innacurracies in the modeling, and more. If you have information or questions that fit our Issues scope, please submit an issue and apply the appropriate label.

### Licencing
IMA at Newfields data files (XML and JSON) are shared in this repository free of restrictions, under a [Creative Commons Zero (CC0) license](https://creativecommons.org/choose/zero/). This means that the data can be used for any purpose without having to give attribution. However, Newfields requests that you actively acknowledge and give attribution wherever possible. Giving attribution reduces the amount of ‘orphaned data’, and will support our continued efforts to further open access to collections-related information.

### Contact
Samantha Norling, Digital Collections Manager, Newfields 

[E-mail the Newfields Lab](mailto:newfieldslab@discovernewfields.org)

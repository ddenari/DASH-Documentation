The Honors College requires certain software packaged on its client computers to ensure the college runs smoothly. There are a couple user classes in the Honors College, each with their own lists of packages. All packages will be imported into Munki for distribution, but certain software may require some work to create a distributable package (see [Software Packaging Guide](https://honorscollege.freshservice.com/solution/categories/1000023134/folders/1000035508/articles/1000015667-software-packaging-guide)).

Classes are determined and assigned by computer. For example, the computers in SSO will be imaged and configured as "advisorcomputer", but if someone who works in SSO were to login in the computer lab, they would only be able to access software available to all lab users, since computers in the Honors computer lab are configured as "labcomputer".

In addition to software packages, each class has different restrictions and login scripts that are installed via packages.

## Manifests

Here we illustrate how the software lists and classes are managed in Munki. We have a hierarchy of manifests which controls what software and scripts are installed on the different classes of computers.

We are using a "base" manifest which looks like follows:

<div style="width: 480px; height: 360px; margin: 10px; position: relative;"><iframe allowfullscreen frameborder="0" style="width:480px; height:360px" src="https://www.lucidchart.com/documents/embeddedchart/28cc149b-ad34-4479-b628-2c8b098de765" id="30qdae92R_YY"></iframe></div>



### allcomputers

| Managed Installs                  | Managed Uninstalls             | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
|-----------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| AdobeAir (21.0)*                  | Microsoft Office 2016          | Android File Transfer (1.0)       |         | available |                      |            |
<<<<<<< HEAD
| AdobeFlashPlayer (23.0.0.7)*    |                                | Cyberduck (5.2.2)*                |         |           |                      |            |
| EasyFind (4.9.3)                  |                                | Dropbox (12.3.19)*                |         |           |                      |            |
| GoogleChrome (54.0.2840.98) *   |                                 | Firefox (49.0.2)*                 |         |           |                      |            |
=======
<<<<<<< HEAD
| AdobeFlashPlayer (23.0.0.7)*    |                                | Cyberduck (5.2.2)*                  |         |           |                      |            |
| EasyFind (4.9.3)                  |                                | Dropbox (12.3.19)*                 |         |           |                      |            |
| GoogleChrome (54.0.2840.98) *   |                                | Firefox (49.0.2)*                 |         |           |                      |            |
| munkireport (2.5.3)*              |                                | GoogleDrive (1.31.2873.2758)*     |         |           |                      |            |
| munkitools (4.2.2679)*            |                                | Skype (7.37.0.178)*               |         |           |                      |            |
| munkitools_core (2.7.0.2753)*     |                                | TeamViewerQS (11.0.62308)*        |         |           |                      |            |
| munkitools_launchd (2.0.0.1969)*  |                                | VLC (2.2.4)*                      |         |           |                      |            |
| Office Installer (14.3.0)*        |                                |                                   |         |           |                      |            |            
=======
| AdobeFlashPlayer (23.0.0.7)*    |                                | Cyberduck (5.2.2)*                  |         |           |                      |            |
| EasyFind (4.9.3)                  |                                | Dropbox (12.3.19)*                 |         |           |                      |            |
| GoogleChrome (54.0.2840.98) *   |                                | Firefox (49.0.2)*                 |         |           |                      |            |
| munkireport (2.5.3)*              |                                | GoogleDrive (1.31.2873.2758)*     |         |           |                      |            |
| munkitools (4.2.2751)*            |                                | Skype (7.37.0.178)*               |         |           |                      |            |
| munkitools_core (2.7.0.2753)*     |                                | TeamViewerQS (11.0.65452)*        |         |           |                      |            |
| munkitools_launchd (2.0.0.1969)*  |                                | VLC (2.2.4)*                      |         |           |                      |            |
| Office Installer (14.3.0)*        |                                | TeamViewer (11.0.65452) *         |         |           |                      |            |
|                                   |                                | Things (2.8.8)*                   |         |           |                      |            |                      
             |                      |                                | FileZilla (3.22.2.2)                |         |           | | | |

>>>>>>> 58ec038d7b8293407ce76cc07ddc22f6f1e82c35
>>>>>>> da05195545cbbbb05286b68404d5f5c4e3b4be09
## Computer Classes

The following is a description of the existing computer classes and the according manifest as they are implemented.

### Admin
Computers used by HonorsIT.

| Managed Installs                  | Managed Uninstalls             | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
|---------------------------------|--------------------------|-------------------------------------------|---------|-----------|----------------------|------------|
<<<<<<< HEAD
| AutoDMG (1.6.0)*                |                          | 3T MongoChef (4.2.0)                      |         | available | facultystaffcomputer |            |
| CreateUserPkg (1.2.4)           |                          | Cyberduck (5.2.2)*                        |         |           | facultystaffcomputer |            |
| DeployStudioAdmin (1.6.15)*     |                          | Dropbox (10.4.26)*                        |         |           |             |            |
| munkitools_admin (2.7.1.2764)*  |                          | Firefox (49.0.2)*                         |         |           |             |            |
| TextMate2 (2.0-beta.12.4) *     |                          | Ghostscript (9.19)*                       |         |           |                      |            |
|                                 |                          | LatexIt (2.8.1)*                          |         |           |                      |            |
|                                 |                          | MacTex (2016)*                            |         |           |                      |            |
|                                 |                          | Microsoft Remote Desktop Beta (8.2.18) *  |         |           |                      |            |
|                                 |                          | Microsoft Remote Desktop Beta (8.2.18) *  |         |           |                      |            |
|                                 |                          | OneDrive (17.3.6517) *                    |         |           |                      |            |
|                                 |                          | Skype (7.37.0.178)*                       |         |           |                      |            |
|                                 |                          | Spotify (1.0.42.151.g19de0aa6) *          |         |           |                      |            |
|                                 |                          | TeamViewer (11.0.65452) *                 |         |           |                      |            |
|                                 |                          | TeamViewerQS (11.0.65452)*                |         |           |                      |
=======
| AutoDMG (1.6.0)*                |                          | 3T MongoChef (3.4.1)                      |         | available | facultystaffcomputer |            |
<<<<<<< HEAD
| CreateUserPkg (1.2.4)           |                          | LatexIt (2.8.1)*                          |         |           |                      |            |
| DeployStudioAdmin (1.6.15)*     |                          | MacTex (2016)*                            |         |           |                      |            |
| MunkiAdmin (1.4.3)*             |                          | Microsoft Remote Desktop Beta (8.2.18) *  |         |           |                      |            |
| munkitools_admin (2.7.1.2764)*       |                          | screenlockgatekeeper.mobileconfig (1.0)   |         |           |                      |            |
=======
| CreateUserPkg (1.2.4)           |                          | Ghostscript (9.19)*                       |         |           |                      |            |
| DeployStudioAdmin (1.6.15)*     |                          | LatexIt (2.8.1)*                          |         |           |                      |            |
| MunkiAdmin (1.4.3)*             |                          | MacTex (2016)*                            |         |           |                      |            |
| munkitools_admin (2.7.1.2764)*  |                          | Microsoft Remote Desktop Beta (8.2.18) *  |         |           |                      |            |
| TextMate2 (2.0-beta.12.4) *     |                          | screenlockgatekeeper.mobileconfig (1.0)   |         |           |                      |          |                          |                                           |         |
| Handbrake (0.10.5)   |          |                          |                                           |         |                      
>>>>>>> 58ec038d7b8293407ce76cc07ddc22f6f1e82c35
>>>>>>> da05195545cbbbb05286b68404d5f5c4e3b4be09

### Advisor

Advisors are any employees of the Honors College that require access to student data on a regular basis, this includes actual HC advising staff, as well as Recruitment and Student Services student workers.

| Managed Installs                  | Managed Uninstalls             | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
|-----------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| FileMakerPro14ARD (0.0)           | FileMaker Pro 12 (12.0)        | CreativeSuite6DesignStandard (6)  |         | available | facultystaffcomputer |            |
|                                   |                                | ssoprinter.mobileconfig (1.0)     |         |           |                      |            |

### Bonner Lab Computers

These computers are for general purpose computing, and will be accessed by people in the Bonner Base area in the Honors Gardens.

#### Computer Configuration
- These computers will be connected to the Xerox Printer in the Honors Garden Area.

| Managed Installs                  | Managed Uninstalls             | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
|-----------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| guestaccount.mobileconfig (1.0)   |                                |                                   |         | available |   allcomputers       |            |
| gardensxerox.mobileconfig (1.0)   |                                | Atom (1.6.0) *                    |         |           |                      |            |
<<<<<<< HEAD
| Sublime Text 3 (3103) *           |                                | Spotify (1.0.42.151.g19de0aa6) *  |         |           |                      |            |
=======
<<<<<<< HEAD
| Sublime Text 3 (3103) *           |                                | Spotify (1.0.42.151.g19de0aa6) *  |         |           |                      |            |
=======
| Sublime Text 3 (3103) *           |                                | Spotify (1.0.42.151.g19de0aa6) *  |         |           |                      |            |
>>>>>>> da05195545cbbbb05286b68404d5f5c4e3b4be09
>>>>>>> 58ec038d7b8293407ce76cc07ddc22f6f1e82c35

### Consulting Offices & Classroom Computers

These computers are for general purpose computing, and will be accessed by many people.

| Managed Installs                  | Managed Uninstalls             | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
|-----------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Adobe Reader (11.0.10) *          |                                |                                   |         | available | allcomputers         |            |
| deansareahp.mobileconfig (1.0)    |                                |                                   |         |           |                      |            |
| guestaccount.mobileconfig (1.0)   |                                |                                   |         |           |                      |            |
| OracleJava8 (1.8.101.13) *        |                                |                                   |         |           |                      |            |

### DASH Lab Computers

These computers are for general purpose computing, and will be accessed by people in the DASH area in the Honors Gardens.

#### Computer Configuration
- These computers will be connected to the Xerox Printer in the Honors Garden Area.

| Managed Installs                  | Managed Uninstalls             | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
|-----------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
<<<<<<< HEAD
| SourceTree (2.2.4)                |                         | 3T MongoChef (4.2.0)                     |         | available |   bonnerlabcomputer  |          
| gardensxerox.mobileconfig (1.0)   |                         | Atom (1.6.0) *                           |         |           |                      |            |
| Sublime Text 3 (3103) *           |                         | Brackets (1.6.0) *                       |         |           |                      |            |
| Xcode (7.3) *                     |                         | CreativeSuite6DesignStandard (6)         |         |           |                      |            |
|                                   |                         | EclipseLuna (4.4.0) *                    |         |           |                      |            |
|                                   |                         | guestaccount.mobileconfig (1.0)          |         |           |                      |            |
|                                   |                         | iWork09 (4.0)                            |         |           |                      |            |
|                                   |                         | LatexIt (2.8.1)*                         |         |           |                      |            |
|                                   |                         | MacTex (2016)*                           |         |           |                      |            |
|                                   |                         | MATLAB_R2015b (8.5.0)                    |         |           |                      |            |
|                                   |                         | Microsoft Remote Desktop Beta (8.2.18) * |         |           |                      |            |
|                                   |                         | mysql (5.7.11) *                         |         |           |                      |            |
|                                   |                         | node (6.5.0) *                           |         |           |                      |            |
|                                   |                         | OneDrive (17.3.6517) *                   |         |           |                      |            |
|                                   |                         | OracleJava8 (1.8.101.13) *               |         |           |                      |            |
|                                   |                         | R (3.3.2) *                              |         |           |                      |            |
|                                   |                         | Robomongo (0.9.0-RC4) *                  |         |           |                      |            |
|                                   |                         | RStudio (0.99.486) *                     |         |           |                      |            |
|                                   |                         | SequelPro (1.1.2) *                      |         |           |                      |            |
|                                   |                         | TeamViewer (11.0.65452) *                |         |           |                      |            |
|                                   |                         | Spotify (1.0.42.151.g19de0aa6) *         |         |           |                      |            |
=======
| SourceTree (2.2.4)                |                                |                                   |         | available |   bonnerlabcomputer  |            |
| gardensxerox.mobileconfig (1.0)   |                                | Atom (1.6.0) *                    |         |           |                      |            |
<<<<<<< HEAD
| Sublime Text 3 (3103) *           |                                | Spotify (1.0.42.151.g19de0aa6) *  |         |           |                      |            |
=======
| Sublime Text 3 (3103) *           |                                | Brackets (1.6.0) *                |         |           |                      |            |
| Xcode (7.3) *                     |                                | EclipseLuna (1.6.0) *             |         |           |                      |            |
|                                   |                                | mysql (5.7.11) *                  |         |           |                      |            |
|                                   |                                | node (6.2.2) *                    |         |           |                      |            |
|                                   |                                | R (3.3.2) *                       |         |           |                      |            |
|                                   |                                | Robomongo (0.9.0-RC4) *           |         |           |                      |            |
|                                   |                                | RStudio (0.99.486) *              |         |           |                      |            |
|                                   |                                | SequelPro (1.1.2) *               |         |           |                      |            |
|                                   |                                | TeamViewer (11.0.65280) *         |         |           |                      |            |
|                                   |                                | Spotify (1.0.42.151.g19de0aa6) *  |         |           |                      |            |
>>>>>>> da05195545cbbbb05286b68404d5f5c4e3b4be09
>>>>>>> 58ec038d7b8293407ce76cc07ddc22f6f1e82c35


### Faculty & Staff

Faculty & Staff are University employees and student workers who do not require access to student data.
#### Computer Configuration
- Automatic login to UHSHA1 (HCShare)
- Automatic login to hc-storage (HonorsShare)
- Printers can be installed via ManagedSoftware

#### Details for Munki Manifest facultystaffcomputer

- General: Catalogs  available
- Included Manfests: allcomputers
- Referencing Manifests: admincomputer, advisorcomputer
- Conditions: no conditions

| Managed Installs                             | Managed Uninstalls         | Managed Updates                   |Optional Installs                                  |
|----------------------------------------------|----------------------------|-----------------------------------|---------------------------------------------------|
<<<<<<< HEAD
| Acrobat XI (11.0.0)                          |                            | Acrobat Update 11.0.17 (11.0.17)  | 204podprinter.mobileconfig (1.0)                  |
| Login_to_NAS_Honors_Share.mobileconfig (1.0) |                            |                                   | 205podprinter.mobileconfig (1.0)                  |
| loginuhsa1.mobileconfig (1.0)                |                            |                                   | 206podprinter.mobileconfig (1.0)                  |
| Spotify (1.0.42.151.g19de0aa6) *             |                            |                                   | 212GCommunicationsColorPrinter.mobileconfig (1.0) |
=======
| Acrobat XI (11.0.0)                         |                            | Acrobat Update 11.0.17 (11.0.17)  | 204podprinter.mobileconfig (1.0)                  |
| Login_to_NAS_Honors_Share.mobileconfig (1.0) |                            |                                   | 205podprinter.mobileconfig (1.0)                  |
| loginuhsa1.mobileconfig (1.0)                |                            |                                   | 206podprinter.mobileconfig (1.0)                  |
<<<<<<< HEAD
| Spotify (1.0.42.151.g19de0aa6) *             |                            |                                   | 212GCommunicationsColorPrinter.mobileconfig (1.0) |
=======
| Spotify (1.0.42.151.g19de0aa6) *             |                            |                                   | 212GCommunicationsColorPrinter.mobileconfig (1.0) |
>>>>>>> da05195545cbbbb05286b68404d5f5c4e3b4be09
>>>>>>> 58ec038d7b8293407ce76cc07ddc22f6f1e82c35
| SSD Fan Control (2.0)                        |                            |                                   | AdobeIndesignCS6 (8.0)                            |
| Sublime Text 3 (3103) *                      |                            |                                   | Atom (1.6.0) *                                    |  
|                                              |                            |                                   | copystoragexerox.mobileconfig (1.0)               |
|                                              |                            |                                   | CreativeSuite6DesignStandard (6)                  |
|                                              |                            |                                   | deansareahp.mobileconfig (1.0)                    |
|                                              |                            |                                   | deansareaxerox.mobileconfig (1.0)                 |
|                                              |                            |                                   | gardensxerox.mobileconfig (1.0)                   |
|                                              |                            |                                   | GarageBand (6.0.5)                                |
|                                              |                            |                                   | iMovie (10.1.2)                                   |
|                                              |                            |                                   | iWork09 (4.0)                                     |
|                                              |                            |                                   | OneDrive (17.3.6517)                   |
|                                              |                            |                                   | recruitementprinter.mobileconfig (1.0)            |
|                                              |                            |                                   | Scribus (1.4.6) *                                 |
<<<<<<< HEAD
|                                              |                            |                                   | Spotify (1.0.36.134.g1cba1920) *                  |
|                                              |                            |                                   | ssoprinter.mobileconfig (1.0)                     |
|                                              |                            |                                   | TeamViewerQS  (11.0.65452) *                       |
|                                              |                            |                                   | Things (2.8.8) *                       |
|                                              |                            |                                   | Zotero (4.0.29.14) *                               |
=======
<<<<<<< HEAD
|                                              |                            |                                   | Spotify (1.0.36.134.g1cba1920) *                  |
|                                              |                            |                                   | ssoprinter.mobileconfig (1.0)                     |
|                                              |                            |                                   | TeamViewerQS (11.0.62308) *                       |
|                                              |                            |                                   | Zotero (4.0.29.14) *                               |
=======
|                                              |                            |                                   | Spotify (1.0.33.106.g60b5d1f0) *                  |
|                                              |                            |                                   | ssoprinter.mobileconfig (1.0)                     |
|                                              |                            |                                   | TeamViewerQS (11.0.62308) *                       |
|                                              |                            |                                   | Things (2.8.8) *                       |
|                                              |                            |                                   | Zotero (4.0.29.14) *                               |
>>>>>>> da05195545cbbbb05286b68404d5f5c4e3b4be09
>>>>>>> 58ec038d7b8293407ce76cc07ddc22f6f1e82c35

### Lab Computers

These computers are for general purpose computing, and will be accessed by many people.

#### Computer Configuration
- Papercut is configured to start at login using a LaunchAgent, and cannot be exited.
- These computers will be connected to the Lab Printers.

| Managed Installs                  | Managed Uninstalls             | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
|-----------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| guestaccount.mobileconfig (1.0)   |                                | Atom (1.6.0)*                     |         | available | allcomputers         |            |
<<<<<<< HEAD
| labprinters.mobileconfig (1.0)    |                                | Spotify (1.0.42.151.g19de0aa6)*   |         |           |                      |            |
=======
<<<<<<< HEAD
| labprinters.mobileconfig (1.0)    |                                | Spotify (1.0.42.151.g19de0aa6)*   |         |           |                      |            |
=======
| labprinters.mobileconfig (1.0)    |                                | Spotify (1.0.42.151.g19de0aa6)*   |         |           |                      |            |
>>>>>>> da05195545cbbbb05286b68404d5f5c4e3b4be09
>>>>>>> 58ec038d7b8293407ce76cc07ddc22f6f1e82c35
| MATLAB_R2015b (8.5.0)             |                                |                                   |         |           |                      |            |
| PaperCut Client (13.5)            |                                |                                   |         |           |                      |            |
| Sublime Text 3 (3103)*            |                                |                                   |         |           |                      |            |       


### Unsorted
I could not find these programs in any manifest.

- JavaForOSX (1.0.0.0.1.1247562015) *
- Login_to_Honors_Share.mobileconfig (1.0) *
- TeXLiveUtility (1.26) *


Note: Astericks (*) indicates that the package is imported into Munki via AutoPkr. All other packages are imported manually.

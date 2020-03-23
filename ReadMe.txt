Appendix B. ReadMe.txt

March 23, 2020

Introduction
DevTreks is a multitier ASP.NET Core 3.1 database 
application. The web project, DevTreks, uses an 
MVC pattern. The data layer, DevTreks.Data, uses 
an EF Core data repository pattern. EF data models 
are stored in the DevTreks.Models project. ASPNET 
Identity models are stored in the DevTreks web 
Project’s Data folder. Localization strings are stored in 
the DevTreks.Exceptions and DevTreks.Resources 
projects. The DevTreks.Extensions folder holds 
projects that use a Managed Extensibility Framework 
pattern. Each project holds a separate group of 
calculators and analyzers. 

Always visit the What's New link on the home site 
for the latest news. The What's New text file lists 
tutorials that have been upgraded recently. Those 
tutorials are usually associated with the current 
release. The Source Code tutorial explains how the 
source code works. The Social Budgeting tutorial 
explains how to manage networks, clubs, and 
members to deliver social budgeting data services. 
The Calculators and Analyzers tutorial explains 
how calculators and analyzers work. 

home site
https://www.devtreks.org

source code sites
https://github.com/kpboyle1/devtreks.3.1 (.NET Core 3.1)

database.zip file
https://devtreks1.blob.core.windows.net/resources/db220.zip

214 datafiles (any exceeding 500KB must be manually uploaded)
https://devtreks1.blob.core.windows.net/resources/network_carbon.zip

What's New in Version 2.2.0
1. The source updated to .NetCore 3.1. The local database upgraded to 
SqlExpress 2019.
1. This release continued focusing on uniform commmunity, product, organization, 
and household, sustainability scores. Example 12 in the SDG Plan reference 
introduces 2 new algorithms that illustrate how to automate these scores.


Server version: Sql Server 2019 Express

connection string
Server=localhost\SQLEXPRESS;Database=DevTreksDesk;Trusted_Connection=True;

DevTreks default member login
Name: kpboyle1@comcast.net
Pwd: public2A@

system administrator
SqlExpress 2016 databases can be accessed using a Windows OS logged in user –these haven’t been tested with the new db server and aren’t critical for accessing the db in SSMS
User: devtreks01_sa or sa
Pwd: public






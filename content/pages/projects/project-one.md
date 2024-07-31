---
type: ProjectLayout
title: Digital Marketing Campaign Project
colors: colors-a
date: '2024-07-31'
client: Anonymous
description: >-
  Interesting insights into the marketing performance of digital ads campaigns
  and other traditional marketing channels (presented in French).
media:
  type: ImageBlock
  url: >-
    http://res.cloudinary.com/fulechib/image/upload/v1722447263/Purple_Gradient_Marketing_Analytics_Carousel_Instagram_Post_1_djishs.png
  altText: Project image
featuredImage:
  type: ImageBlock
  url: >-
    https://res.cloudinary.com/fulechib/image/upload/v1722447263/Purple_Gradient_Marketing_Analytics_Carousel_Instagram_Post_1_djishs.png
  altText: altText of the image
  caption: Caption of the image
  elementId: >-
    https://res.cloudinary.com/fulechib/image/upload/t_Thumbnail/v1722447263/Purple_Gradient_Marketing_Analytics_Carousel_Instagram_Post_1_djishs.png
---
# Description

Ce travail a été réalisé avec une base de données d'une compagnie qui effectue des campagnes en ligne sur leur site internet afin de booster la visite de leur site, dans le but de favoriser les achats aussi bien en ligne qu’en magasin. 

Cette analyse des statistiques des réactions de la clientèle en lien avec les différentes campagnes  porte sur l’enregistrement du nombre d’achats par campagne et ceci par profil du client.



# Profilage des données

*   Nombre de colonnes : 28

*   Nombre de lignes : 2240

*   Types de données :

              numéric (int64)       : 22 colonnes

              string (nvarchar)       : 5 colonnes

              date :      1 colonne



##### **Table 1. Noms des variables et types de données** 

| Nom de colonne      | Description                                                        | Type de donnée avant  | Data de donnée après |
| ------------------- | ------------------------------------------------------------------ | --------------------- | -------------------- |
| ID                  | Unique identifier for each customer                                | smallint              | smallint             |
| Year\_Birth         | Year of birth of the customer                                      | smallint              | smallint             |
| Education           | Customer's level of education                                      | nvarchar(50)          | nvarchar(50)         |
| Marital\_Status     | Customer's marital status                                          | nvarchar(50)          | nvarchar(50)         |
| Income              | Customer's yearly household income                                 | nvarchar(50)          | int                  |
| Kidhome             | Number of small children in customer's household                   | tinyint               | tinyint              |
| Teenhome            | Number of teenagers in customer's household                        | tinyint               | tinyint              |
| Dt\_Customer        | Date of customer's enrollment with the company                     | date                  | date                 |
| Recency             | Number of days since the last purchase                             | tinyint               | tinyint              |
| MntWines            | Amount spent on wines in the last 2 years                          | smallint              | smallint             |
| MntFruits           | Amount spent on fruits in the last 2 years                         | tinyint               | tinyint              |
| MntMeatProducts     | Amount spent on meat products in the last 2 years                  | smallint              | smallint             |
| MntFishProducts     | Amount spent on fish products in the last 2 years                  | smallint              | smallint             |
| MntSweetProducts    | Amount spent on sweet products in the last 2 years                 | smallint              | smallint             |
| MntGoldProds        | Amount spent on gold products in the last 2 years                  | smallint              | smallint             |
| NumDealsPurchases   | Number of purchases made with discount                             | tinyint               | tinyint              |
| NumWebPurchases     | Number of purchases made through company's website                 | tinyint               | tinyint              |
| NumCatalogPurchases | Number of purchases made using catalog                             | tinyint               | tinyint              |
| NumStorePurchases   | Number of purchases made directly in stores                        | tinyint               | tinyint              |
| NumWebVisitsMonth   | Number of visits to company's website in the last month            | tinyint               | tinyint              |
| AcceptedCmp3        | 1 if customer accepted the offer in the 3rd campaign, 0 otherwise  | bit                   | bit                  |
| AcceptedCmp4        | 1 if customer accepted the offer in the 4th campaign, 0 otherwise  | bit                   | bit                  |
| AcceptedCmp5        | 1 if customer accepted the offer in the 5th campaign, 0 otherwise  | bit                   | bit                  |
| AcceptedCmp1        | 1 if customer accepted the offer in the 1st campaign, 0 otherwise  | bit                   | bit                  |
| AcceptedCmp2        | 1 if customer accepted the offer in the 2nd campaign, 0 otherwise  | bit                   | bit                  |
| Response            | 1 if customer accepted the offer in the last campaign, 0 otherwise | bit                   | bit                  |
| Complain            | 1 if customer complained in the last 2 years                       | bit                   | bit                  |
| Country             | Customer's country                                                 | nvarchar(50)          | nvarchar(50)         |









# Source des données

Kaggle: <https://www.kaggle.com/datasets/sahilnbajaj/marketing-campaigns-data-set>














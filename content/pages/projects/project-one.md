---
type: ProjectLayout
title: Digital Marketing Campaign Project
colors: colors-a
date: '2024-07-31'
client: Anonymous
description: >-
  Major challenge : Analyzing binary data in Microsoft SQL server (presented in
  French). This is my version of a project realized with  Ghislain Fepessi Kewou
  and Eveline Carine Kougang Soh.
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
### Description

Ce travail a été réalisé avec une base de données d'une compagnie qui effectue des campagnes en ligne sur son site internet afin d'augmenter la visite de ce site, dans le but de favoriser les achats aussi bien en ligne qu'en magasin.

Les données captent les réactions de la clientèle face aux cinq campagnes publicitaires en ligne couvrant la période de juillet 2012 à juin 2014.

Leur taux de succès est mesuré par le nombre de visites du site web, le nombre d'achats par campagne et la rapidité avec laquelle l'achat a été effectué après la lecture de la publicité. Il s'agit de la vente de six grandes catégories de produits, y compris de l'or, des sucreries, du poisson, de la viande, des fruits et du vin.

Les caractéristiques socio-économiques de la clientèle sont captées par leur année de naissance, niveau d'éducation, statut marital, revenu familial, et le nombre d'enfants et d'adolescents à la maison. Les clients proviennent de sept pays dont l'Allemagne, l'Espagne, le Canada, l'Afrique du Sud, les USA, l'Australie et l'Inde.

### Structure des données

*   Nombre de colonnes : 28

*   Nombre de lignes : 2240

######

##### **Table 1. Noms des variables et types de données**

| Nom de colonne      | Description                                                        | Type de donnée avant | Data de donnée après |
| ------------------- | ------------------------------------------------------------------ | -------------------- | -------------------- |
| ID                  | Unique identifier for each customer                                | smallint             | smallint             |
| Year\_Birth         | Year of birth of the customer                                      | smallint             | smallint             |
| Education           | Customer's level of education                                      | nvarchar(50)         | nvarchar(50)         |
| Marital\_Status     | Customer's marital status                                          | nvarchar(50)         | nvarchar(50)         |
| Income              | Customer's yearly household income                                 | nvarchar(50)         | int                  |
| Kidhome             | Number of small children in customer's household                   | tinyint              | tinyint              |
| Teenhome            | Number of teenagers in customer's household                        | tinyint              | tinyint              |
| Dt\_Customer        | Date of customer's enrollment with the company                     | date                 | date                 |
| Recency             | Number of days since the last purchase                             | tinyint              | tinyint              |
| MntWines            | Amount spent on wines in the last 2 years                          | smallint             | smallint             |
| MntFruits           | Amount spent on fruits in the last 2 years                         | tinyint              | tinyint              |
| MntMeatProducts     | Amount spent on meat products in the last 2 years                  | smallint             | smallint             |
| MntFishProducts     | Amount spent on fish products in the last 2 years                  | smallint             | smallint             |
| MntSweetProducts    | Amount spent on sweet products in the last 2 years                 | smallint             | smallint             |
| MntGoldProds        | Amount spent on gold products in the last 2 years                  | smallint             | smallint             |
| NumDealsPurchases   | Number of purchases made with discount                             | tinyint              | tinyint              |
| NumWebPurchases     | Number of purchases made through company's website                 | tinyint              | tinyint              |
| NumCatalogPurchases | Number of purchases made using catalog                             | tinyint              | tinyint              |
| NumStorePurchases   | Number of purchases made directly in stores                        | tinyint              | tinyint              |
| NumWebVisitsMonth   | Number of visits to company's website in the last month            | tinyint              | tinyint              |
| AcceptedCmp3        | 1 if customer accepted the offer in the 3rd campaign, 0 otherwise  | bit                  | bit                  |
| AcceptedCmp4        | 1 if customer accepted the offer in the 4th campaign, 0 otherwise  | bit                  | bit                  |
| AcceptedCmp5        | 1 if customer accepted the offer in the 5th campaign, 0 otherwise  | bit                  | bit                  |
| AcceptedCmp1        | 1 if customer accepted the offer in the 1st campaign, 0 otherwise  | bit                  | bit                  |
| AcceptedCmp2        | 1 if customer accepted the offer in the 2nd campaign, 0 otherwise  | bit                  | bit                  |
| Response            | 1 if customer accepted the offer in the last campaign, 0 otherwise | bit                  | bit                  |
| Complain            | 1 if customer complained in the last 2 years                       | bit                  | bit                  |
| Country             | Customer's country                                                 | nvarchar(50)         | nvarchar(50)         |

### Source des données

Kaggle: [https://www.kaggle.com/datasets/sahilnbajaj/marketing-campaigns-data-set](https://www.kaggle.com/datasets/sahilnbajaj/marketing-campaigns-data-setAnalyse)



### Analyse des données

Afin d'obtenir des informations pertinentes pour affiner notre stratégie de marketing, j'ai procédé aux requêtes suivantes :

1.  Nombre total de clients par pays dans l'ordre décroissant

2.  Quel status maritals a le revenu moyen le plus élevé?

3.  Le niveau d'education et le nombre des clients  dont les revenus sont supérieurs à la moyenne des revenus de l'échantillon d'analyse

4.  La liste des clients qui ont déjà fait au moins un achat sur le site web de la compagnie

5.  Relation entre le nombre d'enfants et adolescent àla maison et le montant des achats

6.  La liste des clients mariés qui sont clients depuis au moins 10 ans, au 31 décembre 2023

7.  Le nombre de clients depuis leur dernier achat

8.  Le nombre de visites web par mois

9.  Le taux de réponse positif aux campagnes de marketing

10. Statistiques de toutes les campagnes de marketing ('Succès' si le client a acheté pendant la campagne en question et 'Échec' si le client n'a pas fait d'achat pendant la campagne en question)

11. Le nombre de plaintes effectuées par pays

12. Quelle est la moyenne des achats par type de produit ?

13. Le produit le plus vendu et la date de la vente

14. L'année à laquelle on a eu la plus grande vente en ligne

15. Le nombre total des ventes provenant de tous les circuits de vente

16. Le pourcentage des ventes selon le type de circuit de vente

17. Le montant dépensé sur le vin pendant les deux dernières années selon le niveau d'éducation des clients

18. Les caractéristiques socio-économiques des célibataires les plus âgés selon leur pays

19. Le nombre de clients les plus jeunes, ainsi que leur âge et leur voie d'achat préférée

Le code SQL de ces 19 requêtes se trouve [ICI](https://github.com/FuleChi/Digital-marketing-campaign/blob/main/TP1_requetes%20Marketing_data_final.sql).



### Resultat de l'Analyse

La majorité des clients proviennent de l'Espagne, contribuant soit 49% des ventes totales.

Les clients ayant le statut de 'Absurd' on le revenu moyen le plus elevé

Caution: Ceux-ci ne representent que 0,1% de la pouplation. Alors, il serai sage de prêter attention plutôt aux mariés qui contiuent 38,6% de la population de la clientèle.

En terme de niveau d'éducation, les clients ayant un Doctorat sont les plus afflux, suivi par ceux avec la Maitrise et ceux ayant le niveau collegial en troisieme position. Il est quand-même important de souligner que le nombre de clients avec au moins un niveau collegial est la majorité de la clientele.

La majorité des clients ont 1 enfant/adolescent à la maison, cependant,  les clients qui ont ni enfant, ni adolescent à la maison sont responsable de la grande majorité d'achat effectué.








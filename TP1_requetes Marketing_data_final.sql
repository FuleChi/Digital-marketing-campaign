use Ifood
go

SELECT * FROM marketing_data;

--------------------PARTIE I. MANIPULATION DES DONNÉES--------------------------------------

begin tran T1

--Eliminer '$' dans "Income"
UPDATE marketing_data
set Income = SUBSTRING(Income,2,6);


--Eliminer dans "Income"  %.0
begin tran T2
UPDATE marketing_data
set Income = SUBSTRING(Income,1,4)
WHERE Income LIKE '%.0'
COMMIT;


--Convertir le data type de INCOME de 'nvarchar' en 'int'
	-- Étape 1 : Supprimer les caractères non numériques (virgules) et convertir les valeurs en format numérique

	UPDATE marketing_data
	SET income = REPLACE(income, ',', '');

	-- Supprimer le '.' sur les enregistrements (16 au total) qui contiennent le point comme dernier caractère
	UPDATE marketing_data
	set Income = rtrim(Income, '.')
	where Income LIKE '%.%';

	-- Étape 2 : Convertir temporairement les valeurs de la colonne Income en entiers dans une nouvelle colonne
	ALTER TABLE marketing_data
	ADD income_temp INT;
 
	UPDATE marketing_data
	SET income_temp = CAST(income AS INT);
 
	-- Étape 3 : Supprimer la colonne originale Income
	ALTER TABLE marketing_data
	DROP COLUMN income;
 
	-- Étape 4 : Renommer la colonne temporaire en Income
	EXEC sp_rename 'marketing_data.income_temp', 'Income', 'COLUMN';

--Uniformiser la casse des valeurs de "Education"
UPDATE marketing_data
SET Education = UPPER(Education);




--------------------PARTIE II. REQUÊTES DES DONNÉES--------------------------------------

-- R1. Nombre total de clients par pays dans l'ordre décroissant
SELECT Country, 
    COUNT(*) AS NombreClients,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM marketing_data), 1) AS Pourcentage
FROM marketing_data
GROUP BY Country
ORDER BY NombreClients DESC;


-- R2.Quel status maritals a le revenu moyen le plus élevé? 
SELECT Marital_Status, COUNT(*) AS Nombre, 
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM marketing_data), 1) AS Pourcentage,
	AVG(Income) AS RevenuMoy
FROM marketing_data
GROUP BY Marital_Status
ORDER BY RevenuMoy DESC;


-- R3. Le niveau d'education et le nombre des clients  dont les revenus sont supérieurs à la moyenne des revenus de l'échantillon d'analyse
SELECT COUNT(*), Education, AVG(Income) AS MoyIncome
FROM marketing_data 
GROUP BY Education
HAVING AVG(Income) > (
    SELECT AVG(Income) 
    FROM marketing_data
);
 

-- R4. La liste des client qui ont déjà fait au moins 1 achat sur le site web de la compagnie
 SELECT distinct ID, NumWebPurchases
 FROM marketing_data
 WHERE NumWebPurchases > 0 ;


--R5. Relation entre le nombre d'enfants et adolescent àla maison et le montant des achats
SELECT (Kidhome + Teenhome) AS NombreEnfants, COUNT(id) AS nbreClients,
       AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS MontantMoyAchats
FROM marketing_data
GROUP BY (Kidhome + Teenhome)
ORDER BY MontantMoyAchats DESC;


--R6. Le nombre de clients mariés et leur ancieneté de statut  de client avec la compagnie, au 31 décembre 2023
SELECT COUNT(*) AS NbrClients, 
       DATEDIFF(year, Dt_Customer, '2023-12-31') AS Ancienneté
FROM marketing_data
WHERE Marital_Status = 'Married'
GROUP BY DATEDIFF(year, Dt_Customer, '2023-12-31');


-- R7. Le nombre de clients depuis leur derniers achats
SELECT Recency, COUNT(*) AS NombreClients
FROM marketing_data
GROUP BY Recency
ORDER BY NombreClients DESC;


-- R8. Le nombre de visites web par mois
SELECT NumWebVisitsMonth, COUNT(ID) AS NombreClients
FROM marketing_data
GROUP BY NumWebVisitsMonth
ORDER BY NumWebVisitsMonth DESC;


--R9. Le taux de réponse positif aux campagnes de marketing
SELECT SUM(
        CASE WHEN AcceptedCmp1 = 1 THEN 1 ELSE 0 END + 
        CASE WHEN AcceptedCmp2 = 1 THEN 1 ELSE 0 END + 
        CASE WHEN AcceptedCmp3 = 1 THEN 1 ELSE 0 END + 
        CASE WHEN AcceptedCmp4 = 1 THEN 1 ELSE 0 END + 
        CASE WHEN AcceptedCmp5 = 1 THEN 1 ELSE 0 END
    ) * 100.0 / COUNT(*) AS TauxReponse
FROM marketing_data;


/* R10. Statistiques de toutes les campagnes de marketing (
		'Succès' si le client a acheté pendant la campagne en question et
		'Echec' si le client n'a pas fait d'achat pendant la campagne en question)*/
SELECT
    'Success' AS Type,
    SUM(CASE WHEN AcceptedCmp1 = 1 THEN 1 ELSE 0 END) AS Cmp1,
    SUM(CASE WHEN AcceptedCmp2 = 1 THEN 1 ELSE 0 END) AS Cmp2,
    SUM(CASE WHEN AcceptedCmp3 = 1 THEN 1 ELSE 0 END) AS Cmp3,
    SUM(CASE WHEN AcceptedCmp4 = 1 THEN 1 ELSE 0 END) AS Cmp4,
    SUM(CASE WHEN AcceptedCmp5 = 1 THEN 1 ELSE 0 END) AS Cmp5
FROM marketing_data
UNION ALL
SELECT
    'Echec' AS Type,
    SUM(CASE WHEN AcceptedCmp1 = 0 THEN 1 ELSE 0 END) AS Cmp1,
    SUM(CASE WHEN AcceptedCmp2 = 0 THEN 1 ELSE 0 END) AS Cmp2,
    SUM(CASE WHEN AcceptedCmp3 = 0 THEN 1 ELSE 0 END) AS Cmp3,
    SUM(CASE WHEN AcceptedCmp4 = 0 THEN 1 ELSE 0 END) AS Cmp4,
    SUM(CASE WHEN AcceptedCmp5 = 0 THEN 1 ELSE 0 END) AS Cmp5
FROM marketing_data;


-- R11. Le nombre de plaintes effectué par pays
SELECT Country, COUNT(*) AS NombrePlaintes
FROM marketing_data
WHERE Complain = 1
GROUP BY Country;


-- R12. Quelle est la Moyenne des achats par type de produit?
SELECT 
    AVG(MntWines) AS MoyenneVins,
    AVG(MntFruits) AS MoyenneFruits,
    AVG(MntMeatProducts) AS MoyenneViande,
    AVG(MntFishProducts) AS MoyennePoisson,
    AVG(MntSweetProducts) AS MoyenneProduitsSucres,
    AVG(MntGoldProds) AS MoyenneProduitsOr
FROM marketing_data;


--R13. Le produit le plus vendu et la date de la vente
SELECT TOP 1 Dt_Customer, SUM(MntWines) qteVins, SUM(MntFruits) qteFruits, SUM(MntMeatProducts) qteViande, 
		SUM(MntFishProducts) qtePoisson, SUM(MntSweetProducts) qteSucre, SUM(MntGoldProds) qteOr
FROM marketing_data
GROUP BY Dt_Customer
ORDER BY qteVins DESC, qteFruits DESC, qteViande DESC, qtePoisson DESC, qteSucre DESC, qteOr DESC;


--R14. L'année à laquelle on a eu la plus grande vente en ligne
SELECT TOP 1 YEAR(Dt_Customer) AS Annee, MAX(NumWebPurchases) AS MaxVentesEnLigne
FROM marketing_data
GROUP BY YEAR(Dt_Customer)
ORDER BY MaxVentesEnLigne DESC;


--R15. Le nombre total des ventes provenant de tous les circuits de vente 
SELECT (SUM(NumCatalogPurchases) + SUM(NumDealsPurchases) + SUM(NumStorePurchases) + SUM(NumWebPurchases)) AS nbreTotalVentes
FROM marketing_data;


--R16. Le pourcentage des ventes selon le type de circuit de vente
WITH TotalVentes AS (
    SELECT SUM(NumCatalogPurchases) + SUM(NumDealsPurchases) + SUM(NumStorePurchases) + SUM(NumWebPurchases) AS nbreTotalVentes
    FROM marketing_data
)
SELECT 
    (SUM(CAST(NumCatalogPurchases AS FLOAT)) / (SELECT nbreTotalVentes FROM TotalVentes)) * 100 AS Catalog,
    (SUM(CAST(NumDealsPurchases AS FLOAT)) / (SELECT nbreTotalVentes FROM TotalVentes)) * 100 AS Deals,
    (SUM(CAST(NumStorePurchases AS FLOAT)) / (SELECT nbreTotalVentes FROM TotalVentes)) * 100 AS Magasin,
    (SUM(CAST(NumWebPurchases AS FLOAT)) / (SELECT nbreTotalVentes FROM TotalVentes)) * 100 AS Internet
FROM marketing_data;


--R17. Le montant depensé sur le vin pendant les 2 dernier années selon le niveau d'éducation des clients
SELECT Education, SUM(MntWines) AS depSurVins
FROM marketing_data
GROUP BY Education;


-- R18. Les caractéristiques socio-économiques des célibataires les plus âgés selon leur pays
SELECT 
    Country,
    COUNT(id) AS nbreClients,
    MIN(Year_Birth) AS AnneeNaissanceMin,
    Education,
    (Kidhome + Teenhome) AS nbreEnfants,
    AVG(Income) AS RevenuMoyen
FROM marketing_data
WHERE Marital_Status = 'Single'
GROUP BY Country, Education, (Kidhome + Teenhome);


-- R19. Le nombre de clients par generation, ainsi que leur âge moyen et leur voie d'achat préférée
SELECT 
    COUNT(id) AS nbreClients, 
    AVG(YEAR(GETDATE()) - Year_Birth) AS Age, 
    SUM(NumCatalogPurchases) AS nbreCatalog, 
    SUM(NumDealsPurchases) AS nbreDeals, 
    SUM(NumStorePurchases) AS nbreMagasin, 
    SUM(NumWebPurchases) AS nbreInternet,
    CASE 
        WHEN YEAR(GETDATE()) - Year_Birth <= 27 THEN 'Gen Z'          -- Born 1997 and later
        WHEN YEAR(GETDATE()) - Year_Birth BETWEEN 28 AND 43 THEN 'Millennials' -- Born 1981 to 1996
        WHEN YEAR(GETDATE()) - Year_Birth BETWEEN 44 AND 59 THEN 'Gen X'      -- Born 1965 to 1980
        WHEN YEAR(GETDATE()) - Year_Birth BETWEEN 60 AND 69 THEN 'Boomers II' -- Born 1955 to 1964
        ELSE 'Boomers I'                                                      -- Born 1946 to 1954
    END AS Generation
FROM marketing_data
GROUP BY 
    CASE 
        WHEN YEAR(GETDATE()) - Year_Birth <= 27 THEN 'Gen Z'
        WHEN YEAR(GETDATE()) - Year_Birth BETWEEN 28 AND 43 THEN 'Millennials'
        WHEN YEAR(GETDATE()) - Year_Birth BETWEEN 44 AND 59 THEN 'Gen X'
        WHEN YEAR(GETDATE()) - Year_Birth BETWEEN 60 AND 69 THEN 'Boomers II'
        ELSE 'Boomers I'
    END 
ORDER BY Age ASC;


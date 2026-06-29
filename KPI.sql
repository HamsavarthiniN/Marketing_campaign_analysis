CREATE VIEW KPI_campacceptance AS
    SELECT 
    ROUND((SUM(AcceptedCmp1)+SUM(AcceptedCmp2)+SUM(AcceptedCmp3)+SUM(AcceptedCmp4)+SUM(AcceptedCmp5)+SUM(Response))*100.0/(COUNT(*)*6), 2) AS OVERALL_response_rate
    FROM marketing_campaigns_data;

-- ==================================

CREATE VIEW KPI_avgspend AS
SELECT ROUND(AVG(Total_Spend),2) AS AVG_customer_spend FROM derived_table;

-- ==================================

CREATE VIEW KPI_avgspend_seg AS
    SELECT
    ROUND(AVG(MntWines),2) AS Avg_on_wines,
    ROUND(AVG(MntFruits),2) AS Avg_on_fruits,
    ROUND(AVG(MntMeatProducts),2) AS Avg_on_meat,
    ROUND(AVG(MntFishProducts),2) AS Avg_on_fish,
    ROUND(AVG(MntSweetProducts),2) AS Avg_on_sweets,
    ROUND(AVG(MntGoldProds),2) AS Avg_on_gold

    FROM marketing_campaigns_data;

-- ==================================

CREATE VIEW KPI_avgpurchase AS
SELECT
    ROUND(AVG(NumStorePurchases),2) AS Avg_store_purchases,
    ROUND(AVG(NumWebPurchases),2) AS Avg_web_purchases,
    ROUND(AVG(NumCatalogPurchases),2) AS Avg_catalog_purchases

    FROM marketing_campaigns_data;

-- ==================================

CREATE VIEW KPI_avg_webvisit AS
    SELECT
    ROUND(AVG(NumWebVisitsMonth),2) AS Avg_web_visit
    FROM marketing_campaigns_data;

-- ==================================

CREATE VIEW KPI_edu AS
SELECT m.Education, COUNT(*) AS Customers,
    ROUND(AVG(d.Total_Spend),2) AS Avg_Spend,
    ROUND(AVG(m.NumWebVisitsMonth),2) AS Avg_Web_Visits,
    ROUND((SUM(m.AcceptedCmp1)+SUM(m.AcceptedCmp2)+SUM(m.AcceptedCmp3)+SUM(m.AcceptedCmp4)+SUM(m.AcceptedCmp5)+SUM(m.Response))*100.0/(COUNT(*)*6), 2) AS Overall_response_rate

    FROM marketing_campaigns_data m
    JOIN derived_table d
    ON m.ID=d.ID

    GROUP BY Education
    ORDER BY Avg_Spend DESC;

-- ==================================

CREATE VIEW KPI_age AS
SELECT 
    CASE
        WHEN Age BETWEEN 30 AND 44 THEN 'Young Adults'
        WHEN Age BETWEEN 45 AND 59 THEN 'Middle Aged'
        ELSE 'Senior Adults'
    END AS Age_band,
    COUNT(*) AS Customers,
    ROUND(AVG(d.Total_Spend),2) AS Avg_Spend,
    ROUND(AVG(m.NumWebVisitsMonth),2) AS Avg_Web_Visits,
    ROUND((SUM(m.AcceptedCmp1)+SUM(m.AcceptedCmp2)+SUM(m.AcceptedCmp3)+SUM(m.AcceptedCmp4)+SUM(m.AcceptedCmp5)+SUM(m.Response))*100.0/(COUNT(*)*6), 2) AS Overall_response_rate

    FROM marketing_campaigns_data m
    JOIN derived_table d ON m.ID=d.ID

    GROUP BY Age_band
    ORDER BY Avg_Spend DESC;

-- ==================================

CREATE VIEW KPI_maritalstatus AS
    SELECT m.Marital_Status, COUNT(*) AS Customers,
    ROUND(AVG(d.Total_Spend),2) AS Avg_Spend,
    ROUND(AVG(m.NumWebVisitsMonth),2) AS Avg_Web_Visits,
    ROUND((SUM(m.AcceptedCmp1)+SUM(m.AcceptedCmp2)+SUM(m.AcceptedCmp3)+SUM(m.AcceptedCmp4)+SUM(m.AcceptedCmp5)+SUM(m.Response))*100.0/(COUNT(*)*6), 2) AS Overall_response_rate

    FROM marketing_campaigns_data m
    JOIN derived_table d
    ON m.ID=d.ID

    GROUP BY m.Marital_Status
    ORDER BY Avg_Spend DESC;

-- ==================================

CREATE VIEW KPI_country AS
SELECT m.Country, COUNT(*) AS Customers,
    ROUND(AVG(d.Total_Spend),2) AS Avg_Spend,
    ROUND(AVG(m.NumWebVisitsMonth),2) AS Avg_Web_Visits,
    ROUND((SUM(m.AcceptedCmp1)+SUM(m.AcceptedCmp2)+SUM(m.AcceptedCmp3)+SUM(m.AcceptedCmp4)+SUM(m.AcceptedCmp5)+SUM(m.Response))*100.0/(COUNT(*)*6), 2) AS Overall_response_rate

    FROM marketing_campaigns_data m
    JOIN derived_table d
    ON m.ID=d.ID

    GROUP BY m.Country
    ORDER BY Avg_Spend DESC;

-- ==================================

CREATE VIEW KPI_incomeband AS
    SELECT 
    CASE
        WHEN m.Income < 28240.225 THEN 'Low Income'
        WHEN m.Income <= 86917.575 THEN 'Middle Income'
        ELSE 'High Income'
    END AS Income_band,
    COUNT(*) AS Customers,
    ROUND(AVG(d.Total_Spend),2) AS Avg_Spend,
    ROUND(AVG(m.NumWebVisitsMonth),2) AS Avg_Web_Visits,
    ROUND((SUM(m.AcceptedCmp1)+SUM(m.AcceptedCmp2)+SUM(m.AcceptedCmp3)+SUM(m.AcceptedCmp4)+SUM(m.AcceptedCmp5)+SUM(m.Response))*100.0/(COUNT(*)*6), 2) AS Overall_response_rate

    FROM marketing_campaigns_data m
    JOIN derived_table d
    ON m.ID=d.ID

    GROUP BY Income_band
    ORDER BY Avg_Spend DESC;

-- ==================================

CREATE VIEW KPI_segmentation AS
    SELECT 
    CASE
        WHEN Age BETWEEN 30 AND 44 THEN 'Young Adults'
        WHEN Age BETWEEN 45 AND 59 THEN 'Middle Aged'
        ELSE 'Senior Adults'
    END AS Age_band,
    CASE
        WHEN m.Income < 28240.225 THEN 'Low Income'
        WHEN m.Income <= 86917.575 THEN 'Middle Income'
        ELSE 'High Income'
    END AS Income_band,
    COUNT(*) AS Customers,
    ROUND(AVG(d.Total_Spend),2) AS Avg_Spend,
    ROUND(AVG(m.NumWebVisitsMonth),2) AS Avg_Web_Visits,
    ROUND(AVG(m.MntWines),2) AS Avg_on_wines,
    ROUND(AVG(m.MntFruits),2) AS Avg_on_fruits,
    ROUND(AVG(m.MntMeatProducts),2) AS Avg_on_meat,
    ROUND(AVG(m.MntFishProducts),2) AS Avg_on_fish,
    ROUND(AVG(m.MntSweetProducts),2) AS Avg_on_sweets,
    ROUND(AVG(m.MntGoldProds),2) AS Avg_on_gold,
    ROUND(AVG(m.NumDealsPurchases),2) AS Avg_new_deal,
    ROUND(AVG(m.NumWebPurchases),2) AS Avg_web_pur,
    ROUND(AVG(m.NumCatalogPurchases),2) AS Avg_catalog,
    ROUND(AVG(m.NumStorePurchases),2) AS Avg_store_pur,

    ROUND(AVG(m.AcceptedCmp1) * 100, 2) AS Campaign1_Acceptance_Rate,
    ROUND(AVG(m.AcceptedCmp2) * 100, 2) AS Campaign2_Acceptance_Rate,
    ROUND(AVG(m.AcceptedCmp3) * 100, 2) AS Campaign3_Acceptance_Rate,
    ROUND(AVG(m.AcceptedCmp4) * 100, 2) AS Campaign4_Acceptance_Rate,
    ROUND(AVG(m.AcceptedCmp5) * 100, 2) AS Campaign5_Acceptance_Rate,
    ROUND(AVG(m.Response) * 100, 2) AS Last_Campaign_Response_Rate

    FROM marketing_campaigns_data m
    JOIN derived_table d
    ON m.ID=d.ID

    GROUP BY Income_band, Age_band
    ORDER BY Avg_Spend DESC;

-- ==================================


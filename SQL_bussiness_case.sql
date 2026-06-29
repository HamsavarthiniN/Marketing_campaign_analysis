 CREATE VIEW highest_response AS
     SELECT Income_band, Age_band, Web_engagement_band, Family_band, Spend_segment, Customer_Count,

    ROUND(Campaign1_Accepted * 100.0 / Customer_Count, 2) AS Campaign1_Response_Rate,
    ROUND(Campaign2_Accepted * 100.0 / Customer_Count, 2) AS Campaign2_Response_Rate,
    ROUND(Campaign3_Accepted * 100.0 / Customer_Count, 2) AS Campaign3_Response_Rate,
    ROUND(Campaign4_Accepted * 100.0 / Customer_Count, 2) AS Campaign4_Response_Rate,
    ROUND(Campaign5_Accepted * 100.0 / Customer_Count, 2) AS Campaign5_Response_Rate,
    ROUND(Latest_Campaign_Accepted * 100.0 / Customer_Count, 2) AS Latest_Campaign_Response_Rate

FROM sql_segmentation_table

ORDER BY Campaign2_Response_Rate DESC limit 5;

-- ==================================

CREATE VIEW spending_pattern AS
    SELECT
    CASE
        WHEN m.Income < 28240.225 THEN 'Low Income'
        WHEN m.Income <= 86917.575 THEN 'Middle Income'
        ELSE 'High Income'
    END AS Income_band,

    CASE
        WHEN d.Age<45 THEN 'Young'
        When d.Age BETWEEN 45 and 63 THEN 'Middle aged'
        ELSE 'Senior'
    END AS Age_band,

    m.Marital_Status,

    m.Country,

    COUNT(*) AS Customer_Count,

    ROUND(AVG(m.MntWines), 2) AS Avg_Wine_Spend,
    ROUND(AVG(m.MntFruits), 2) AS Avg_Fruit_Spend,
    ROUND(AVG(m.MntMeatProducts), 2) AS Avg_Meat_Spend,
    ROUND(AVG(m.MntFishProducts), 2) AS Avg_Fish_Spend,
    ROUND(AVG(m.MntSweetProducts), 2) AS Avg_Sweets_Spend,
    ROUND(AVG(m.MntGoldProds), 2) AS Avg_Gold_Spend,

    ROUND(AVG(m.MntWines + m.MntFruits + m.MntMeatProducts + m.MntFishProducts + m.MntSweetProducts + m.MntGoldProds), 2) AS Avg_Total_Spend

    FROM marketing_campaigns_data m
    JOIN derived_table d
    ON m.ID = d.ID

    GROUP BY
        Income_Band,
        Age_Band,
        m.Marital_Status,
        m.Country

    ORDER BY
    Avg_Total_Spend DESC;

-- ==================================

CREATE VIEW channel_based_highvalue AS
    SELECT
    CASE
        WHEN d.Total_Spend < 441 THEN 'Low Value'
        WHEN d.Total_Spend < 1600 THEN 'Medium Value'
        ELSE 'High Value'
    END AS Customer_Value,

    COUNT(*) AS Customer_Count,

    ROUND(AVG(m.NumWebPurchases), 2) AS Avg_Web_Purchases,
    ROUND(AVG(m.NumStorePurchases), 2) AS Avg_Store_Purchases,
    ROUND(AVG(m.NumCatalogPurchases), 2) AS Avg_Catalog_Purchases,
    ROUND(AVG(m.NumDealsPurchases), 2) AS Avg_Deals_Purchases,
    ROUND(AVG(m.NumWebVisitsMonth), 2) AS Avg_Website_Visits

    FROM marketing_campaigns_data m
    JOIN derived_table d
    ON m.ID = d.ID

    GROUP BY Customer_Value

    ORDER BY
    CASE Customer_Value
        WHEN 'High Value' THEN 1
        WHEN 'Medium Value' THEN 2
        ELSE 3
    END;

-- ==================================

CREATE VIEW under_served AS
  SELECT Income_band, Age_band, Web_engagement_band, Family_band, Spend_segment, Customer_Count,

    ROUND((Campaign1_Accepted + Campaign2_Accepted + Campaign3_Accepted + Campaign4_Accepted + Campaign5_Accepted +
            Latest_Campaign_Accepted) * 100.0 / (Customer_Count * 6), 2) AS Overall_Response_Rate

FROM sql_segmentation_table

WHERE Spend_segment = 'Low spender'
  AND Web_engagement_band = 'High engagement'

ORDER BY Overall_Response_Rate ASC;

-- ==================================

CREATE VIEW ideal_target AS
    SELECT
    CASE
        WHEN m.Income < 28240.225 THEN 'Low Income'
        WHEN m.Income <= 86917.575 THEN 'Middle Income'
        ELSE 'High Income'
    END AS Income_Band,

    CASE
        WHEN d.Age < 45 THEN 'Young'
        WHEN d.Age <= 63 THEN 'Middle-aged'
        ELSE 'Senior'
    END AS Age_Band,

    CASE
        WHEN m.Kidhome >= 1 AND m.Teenhome >= 1 THEN 'Parent of child & teen'
        WHEN m.Kidhome >= 1 THEN 'Parent of a child'
        WHEN m.Teenhome >= 1 THEN 'Parent of a teen'
        ELSE 'Adult'
    END AS Family_Band,

    m.Marital_Status,

    m.Country,

    COUNT(*) AS Customer_Count,

    ROUND((SUM(m.AcceptedCmp1) + SUM(m.AcceptedCmp2) + SUM(m.AcceptedCmp3) + SUM(m.AcceptedCmp4) + SUM(m.AcceptedCmp5) + 
        SUM(m.Response)) * 100.0 / (COUNT(*) * 6), 2) AS Overall_Response_Rate,

    ROUND(AVG(d.Total_Spend), 2) AS Avg_Total_Spend

    FROM marketing_campaigns_data m
    JOIN derived_table d
    ON m.ID = d.ID

    GROUP BY
        Income_Band,
        Age_Band,
        Family_Band,
        m.Marital_Status,
        m.Country

    HAVING COUNT(*) >= 10

    ORDER BY
        Overall_Response_Rate DESC,
        Avg_Total_Spend DESC;

-- ==================================


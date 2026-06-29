CREATE VIEW income_segmentation AS 
    SELECT 
    CASE
        WHEN Income < 28240.225 THEN 'Low Income'
        WHEN Income <= 86917.575 THEN 'Middle Income'
        ELSE 'High Income'
    END AS Income_band,
    Count(*) AS Customer_Count
    FROM marketing_campaigns_data 
    Group BY Income_band;

-- ==================================

CREATE VIEW age_segmentation AS
    SELECT
    CASE
        WHEN Age<45 THEN 'Young'
        When Age BETWEEN 45 and 63 THEN 'Middle aged'
        ELSE 'Senior'
        END AS Age_band,
        COUNT(*) AS Customer_COUNT
        FROM derived_table
        GROUP BY Age_band;

-- ==================================

CREATE VIEW atleast_1campaign AS
    SELECT
    CASE 
        WHEN AcceptedCmp1 = 1
          OR AcceptedCmp2 = 1
          OR AcceptedCmp3 = 1
          OR AcceptedCmp4 = 1
          OR AcceptedCmp5 = 1
          OR Response = 1
        THEN 'Yes'
        ELSE 'No'
        END AS Accepted_campaign,
        COUNT(*) AS Customer_count
        From marketing_campaigns_data
        GROUP BY Accepted_campaign;

-- ==================================

CREATE VIEW campaignwise_segmentation AS
    SELECT
    'Campaign 1' AS Campaign,
    COUNT(CASE WHEN AcceptedCmp1 = 1 THEN 1 END) AS Accepted
FROM marketing_campaigns_data

UNION ALL

SELECT
    'Campaign 2',
    COUNT(CASE WHEN AcceptedCmp2 = 1 THEN 1 END)
FROM marketing_campaigns_data

UNION ALL

SELECT
    'Campaign 3',
    COUNT(CASE WHEN AcceptedCmp3 = 1 THEN 1 END)
FROM marketing_campaigns_data

UNION ALL

SELECT
    'Campaign 4',
    COUNT(CASE WHEN AcceptedCmp4 = 1 THEN 1 END)
FROM marketing_campaigns_data

UNION ALL

SELECT
    'Campaign 5',
    COUNT(CASE WHEN AcceptedCmp5 = 1 THEN 1 END)
FROM marketing_campaigns_data

UNION ALL

SELECT
    'Latest Campaign',
    COUNT(CASE WHEN Response = 1 THEN 1 END)
FROM marketing_campaigns_data;

-- ==================================

CREATE VIEW web_engagement AS
SELECT
    CASE
        WHEN NumWebVisitsMonth > 7 THEN 'High engagement'
        WHEN NumWebVisitsMonth Between 3 AND 7 THEN 'Average engagement'
        ELSE 'Low engagement'
        END AS Web_engagement_band,
        COUNT(*) AS Customer_count
        From marketing_campaigns_data
        GROUP BY Web_engagement_band;

-- ==================================

CREATE VIEW family_segmentation AS
    SELECT
    CASE
        WHEN kidhome>=1 THEN 'Parent of a child'
        WHEN teenhome>=1 THEN 'Parent of a teen'
        ELSE 'Adult'
        END AS Family_band,
        COUNT(*) AS Customer_count
        FROM marketing_campaigns_data
        GROUP BY Family_band;

-- ==================================

CREATE VIEW spender_segmentation AS
    SELECT
    CASE
        WHEN Total_Spend < 441 THEN 'Low spender'
        WHEN Total_Spend < 1600 THEN 'Medium spender'
        ELSE 'High spender'
    END AS Spend_segment,
    COUNT(*) AS Customer_Count
    FROM derived_table
    GROUP BY Spend_segment;

-- ==================================

CREATE VIEW spender_segmentation AS
    SELECT
    CASE
        WHEN Total_Spend < 441 THEN 'Low spender'
        WHEN Total_Spend < 1600 THEN 'Medium spender'
        ELSE 'High spender'
    END AS Spend_segment,
    COUNT(*) AS Customer_Count
    FROM derived_table
    GROUP BY Spend_segment;

-- ==================================

CREATE VIEW overall_segmentation AS
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

    CASE
        WHEN m.NumWebVisitsMonth > 7 THEN 'High engagement'
        WHEN m.NumWebVisitsMonth Between 3 AND 7 THEN 'Average engagement'
        ELSE 'Low engagement'
    END AS Web_engagement_band,

    CASE
        WHEN m.Kidhome >= 1 AND m.Teenhome >= 1 THEN 'Parent of child & teen'
        WHEN m.kidhome>=1 THEN 'Parent of a child'
        WHEN m.teenhome>=1 THEN 'Parent of a teen'
        ELSE 'Adult'
    END AS Family_band,

    CASE
        WHEN d.Total_Spend < 441 THEN 'Low spender'
        WHEN d.Total_Spend < 1600 THEN 'Medium spender'
        ELSE 'High spender'
    END AS Spend_segment,

    COUNT(*) AS Customer_Count,

    SUM(CASE WHEN m.AcceptedCmp1 = 1 THEN 1 ELSE 0 END) AS Campaign1_Accepted,
    SUM(CASE WHEN m.AcceptedCmp2 = 1 THEN 1 ELSE 0 END) AS Campaign2_Accepted,
    SUM(CASE WHEN m.AcceptedCmp3 = 1 THEN 1 ELSE 0 END) AS Campaign3_Accepted,
    SUM(CASE WHEN m.AcceptedCmp4 = 1 THEN 1 ELSE 0 END) AS Campaign4_Accepted,
    SUM(CASE WHEN m.AcceptedCmp5 = 1 THEN 1 ELSE 0 END) AS Campaign5_Accepted,
    SUM(CASE WHEN m.Response = 1 THEN 1 ELSE 0 END) AS Latest_Campaign_Accepted

    FROM marketing_campaigns_data m
    JOIN derived_table d
    ON m.ID = d.ID
    Group BY Income_band, Age_band, Web_engagement_band, Family_band, Spend_segment

    ORDER BY Customer_count DESC;

-- ==================================


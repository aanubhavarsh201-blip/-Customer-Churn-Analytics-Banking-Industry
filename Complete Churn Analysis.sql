CREATE TABLE Customer (
CustomerId BIGINT Primary Key,
Surname	Varchar(50),
CreditScore	Integer,
Geography Varchar(50),	
Gender Varchar(10),	
Age Integer,
Tenure Integer,
Balance Numeric, 
NumOfProducts Integer,	
HasCrCard Boolean, 
IsActiveMember Boolean,
EstimatedSalary Numeric, 
Exited Boolean
);

Select * From Customer;

SELECT COUNT(*) FROM Customer;

SELECT Exited, COUNT(*) AS CustomerCount
FROM Customer
GROUP BY Exited;

SELECT
  Exited,
  COUNT(*) AS CustomerCount,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) || '%' AS ExitPercentage
FROM Customer
GROUP BY Exited;

SELECT
  Geography,
  COUNT(*) AS CustomerCount
FROM Customer
GROUP BY Geography
ORDER BY Geography;
 
SELECT
  Geography,
  Exited,
  COUNT(*) AS CustomerCount
FROM Customer
GROUP BY Geography, Exited
ORDER BY Geography, Exited;

SELECT
  Geography,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS ChurnCount,
  COUNT(*) AS TotalCustomers,
  ROUND(
    COUNT(*) FILTER (WHERE Exited = TRUE) * 100.0 / NULLIF(COUNT(*), 0),
    2
  ) || '%' AS ChurnPercentage
FROM Customer
GROUP BY Geography
ORDER BY Geography;

SELECT
  Gender,
  COUNT(*) AS CustomerCount
FROM Customer
GROUP BY Gender
ORDER BY Gender;

SELECT
  Gender,
  Exited,
  COUNT(*) AS CustomerCount
FROM Customer
GROUP BY Gender, Exited
ORDER BY Gender, Exited;

SELECT
  Gender,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS ChurnCount,
  COUNT(*) AS TotalCustomers,
  ROUND(
    COUNT(*) FILTER (WHERE Exited = TRUE) * 100.0 / NULLIF(COUNT(*), 0),
    2
  ) || '%' AS ChurnPercentage
FROM Customer
GROUP BY Gender
ORDER BY Gender;

SELECT AgeBucket, CustomerCount
FROM (
  SELECT
    CASE
      WHEN Age BETWEEN 18 AND 35 THEN '18-35'
      WHEN Age > 35 AND Age <= 55 THEN '36-55'
      WHEN Age > 55 AND Age <= 65 THEN '56-65'
      WHEN Age > 65 THEN '65+'
      ELSE 'Unknown'
    END AS AgeBucket,
    COUNT(*) AS CustomerCount
  FROM Customer
  GROUP BY AgeBucket
) AS sub
ORDER BY
  CASE 
    WHEN AgeBucket = '18-35' THEN 1
    WHEN AgeBucket = '36-55' THEN 2
    WHEN AgeBucket = '56-65' THEN 3
    WHEN AgeBucket = '65+' THEN 4
    ELSE 5
  END

SELECT
  AgeBucket,
  COUNT(*) FILTER (WHERE Exited = FALSE) AS Not_Exited,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS Exited
FROM (
  SELECT
    CASE
      WHEN Age BETWEEN 18 AND 35 THEN '18-35'
      WHEN Age > 35 AND Age <= 55 THEN '36-55'
      WHEN Age > 55 AND Age <= 65 THEN '56-65'
      WHEN Age > 65 THEN '65+'
      ELSE 'Unknown'
    END AS AgeBucket,
    Exited
  FROM Customer
) AS sub
GROUP BY AgeBucket
ORDER BY
  CASE
    WHEN AgeBucket = '18-35' THEN 1
    WHEN AgeBucket = '36-55' THEN 2
    WHEN AgeBucket = '56-65' THEN 3
    WHEN AgeBucket = '65+' THEN 4
    ELSE 5
  END;

SELECT
  AgeBucket,
  COUNT(*) AS TotalCustomers,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS ExitedCount,
  ROUND(
    COUNT(*) FILTER (WHERE Exited = TRUE) * 100.0 / NULLIF(COUNT(*), 0),
    2
  ) || '%' AS ExitedPercentage
FROM (
  SELECT
    CASE
      WHEN Age BETWEEN 18 AND 35 THEN '18-35'
      WHEN Age > 35 AND Age <= 55 THEN '36-55'
      WHEN Age > 55 AND Age <= 65 THEN '56-65'
      WHEN Age > 65 THEN '65+'
      ELSE 'Unknown'
    END AS AgeBucket,
    Exited
  FROM Customer
) AS sub
GROUP BY AgeBucket
ORDER BY
  CASE
    WHEN AgeBucket = '18-35' THEN 1
    WHEN AgeBucket = '36-55' THEN 2
    WHEN AgeBucket = '56-65' THEN 3
    WHEN AgeBucket = '65+' THEN 4
    ELSE 5
  END;

SELECT TenureBucket, CustomerCount
FROM (
  SELECT
    CASE
      WHEN Tenure BETWEEN 0 AND 1 THEN '0-1'
      WHEN Tenure BETWEEN 2 AND 4 THEN '2-4'
      WHEN Tenure BETWEEN 5 AND 7 THEN '5-7'
      WHEN Tenure BETWEEN 8 AND 10 THEN '8-10'
      ELSE 'Unknown'
    END AS TenureBucket,
    COUNT(*) AS CustomerCount
  FROM Customer
  GROUP BY TenureBucket
) AS sub
ORDER BY
  CASE
    WHEN TenureBucket = '0-1' THEN 1
    WHEN TenureBucket = '2-4' THEN 2
    WHEN TenureBucket = '5-7' THEN 3
    WHEN TenureBucket = '8-10' THEN 4
    ELSE 5
  END;

SELECT
  TenureBucket,
  COUNT(*) FILTER (WHERE Exited = FALSE) AS Not_Exited,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS Exited
FROM (
  SELECT
    CASE
      WHEN Tenure BETWEEN 0 AND 1 THEN '0-1'
      WHEN Tenure BETWEEN 2 AND 4 THEN '2-4'
      WHEN Tenure BETWEEN 5 AND 7 THEN '5-7'
      WHEN Tenure BETWEEN 8 AND 10 THEN '8-10'
      ELSE 'Unknown'
    END AS TenureBucket,
    Exited
  FROM Customer
) AS sub
GROUP BY TenureBucket
ORDER BY
  CASE
    WHEN TenureBucket = '0-1' THEN 1
    WHEN TenureBucket = '2-4' THEN 2
    WHEN TenureBucket = '5-7' THEN 3
    WHEN TenureBucket = '8-10' THEN 4
    ELSE 5
  END;

SELECT
  TenureBucket,
  COUNT(*) AS TotalCustomers,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS TotalExited,
  ROUND(
    COUNT(*) FILTER (WHERE Exited = TRUE) * 100.0 / NULLIF(COUNT(*), 0),
    2
  ) || '%' AS ExitedPercentage
FROM (
  SELECT
    CASE
      WHEN Tenure BETWEEN 0 AND 1 THEN '0-1'
      WHEN Tenure BETWEEN 2 AND 4 THEN '2-4'
      WHEN Tenure BETWEEN 5 AND 7 THEN '5-7'
      WHEN Tenure BETWEEN 8 AND 10 THEN '8-10'
      ELSE 'Unknown'
    END AS TenureBucket,
    Exited
  FROM Customer
) AS sub
GROUP BY TenureBucket
ORDER BY
  CASE
    WHEN TenureBucket = '0-1' THEN 1
    WHEN TenureBucket = '2-4' THEN 2
    WHEN TenureBucket = '5-7' THEN 3
    WHEN TenureBucket = '8-10' THEN 4
    ELSE 5
  END;

SELECT
  NumOfProducts,
  COUNT(*) AS CustomerCount
FROM Customer
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

SELECT
  NumOfProducts,
  COUNT(*) FILTER (WHERE Exited = FALSE) AS Not_Exited,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS Exited
FROM Customer
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

SELECT
  NumOfProducts,
  COUNT(*) AS TotalCustomers,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS ExitedCustomers,
  ROUND(
    COUNT(*) FILTER (WHERE Exited = TRUE) * 100.0 / NULLIF(COUNT(*), 0),
    2
  ) || '%' AS ExitedPercentage
FROM Customer
GROUP BY NumOfProducts
ORDER BY NumOfProducts;


SELECT
  COUNT(CreditScore) AS CustomerCount,
  ROUND(AVG(CreditScore), 2) AS AverageCreditScore,
  ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY CreditScore)::numeric, 2) AS MedianCreditScore,
  ROUND(MIN(CreditScore), 2) AS MinCreditScore,
  ROUND(MAX(CreditScore), 2) AS MaxCreditScore,
  ROUND(STDDEV_SAMP(CreditScore), 2) AS StddevCreditScore
FROM Customer;


SELECT CreditScoreBucket, CustomerCount
FROM (
  SELECT
    CASE
      WHEN CreditScore BETWEEN 0 AND 550 THEN '0-550 (Poor)'
      WHEN CreditScore BETWEEN 551 AND 650 THEN '551-650 (Average)'
      WHEN CreditScore BETWEEN 651 AND 750 THEN '651-750 (Good)'
      WHEN CreditScore > 750 THEN '751+ (Excellent)'
      ELSE 'Unknown'
    END AS CreditScoreBucket,
    COUNT(*) AS CustomerCount
  FROM Customer
  GROUP BY CreditScoreBucket
) AS sub
ORDER BY
  CASE
    WHEN CreditScoreBucket = '0-550 (Poor)' THEN 1
    WHEN CreditScoreBucket = '551-650 (Average)' THEN 2
    WHEN CreditScoreBucket = '651-750 (Good)' THEN 3
    WHEN CreditScoreBucket = '751+ (Excellent)' THEN 4
    ELSE 5
  END;

SELECT
  CreditScoreBucket,
  COUNT(*) FILTER (WHERE Exited = FALSE) AS Not_Exited,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS Exited
FROM (
  SELECT
    CASE
      WHEN CreditScore BETWEEN 0 AND 550 THEN '0-550 (Poor)'
      WHEN CreditScore BETWEEN 551 AND 650 THEN '551-650 (Average)'
      WHEN CreditScore BETWEEN 651 AND 750 THEN '651-750 (Good)'
      WHEN CreditScore > 750 THEN '751+ (Excellent)'
      ELSE 'Unknown'
    END AS CreditScoreBucket,
    Exited
  FROM Customer
) AS sub
GROUP BY CreditScoreBucket
ORDER BY
  CASE
    WHEN CreditScoreBucket = '0-550 (Poor)' THEN 1
    WHEN CreditScoreBucket = '551-650 (Average)' THEN 2
    WHEN CreditScoreBucket = '651-750 (Good)' THEN 3
    WHEN CreditScoreBucket = '751+ (Excellent)' THEN 4
    ELSE 5
  END;

SELECT
  CreditScoreBucket,
  COUNT(*) AS TotalCustomers,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS ExitedCustomers,
  ROUND(
    COUNT(*) FILTER (WHERE Exited = TRUE) * 100.0 / NULLIF(COUNT(*), 0),
    2
  ) || '%' AS ExitedPercentage
FROM (
  SELECT
    CASE
      WHEN CreditScore BETWEEN 0 AND 550 THEN '0-550 (Poor)'
      WHEN CreditScore BETWEEN 551 AND 650 THEN '551-650 (Average)'
      WHEN CreditScore BETWEEN 651 AND 750 THEN '651-750 (Good)'
      WHEN CreditScore > 750 THEN '751+ (Excellent)'
      ELSE 'Unknown'
    END AS CreditScoreBucket,
    Exited
  FROM Customer
) AS sub
GROUP BY CreditScoreBucket
ORDER BY
  CASE
    WHEN CreditScoreBucket = '0-550 (Poor)' THEN 1
    WHEN CreditScoreBucket = '551-650 (Average)' THEN 2
    WHEN CreditScoreBucket = '651-750 (Good)' THEN 3
    WHEN CreditScoreBucket = '751+ (Excellent)' THEN 4
    ELSE 5
  END;

SELECT
  COUNT(Balance) AS CustomerBalance,
  ROUND(AVG(Balance), 2) AS AverageBalance,
  ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Balance)::numeric, 2) AS MedianBalance,
  ROUND(MIN(Balance), 2) AS MinBalance,
  ROUND(MAX(Balance), 2) AS MaxBalance,
  ROUND(STDDEV_SAMP(Balance), 2) AS StddevBalance
FROM Customer;

SELECT
  BalanceBucket,
  CustomerCount
FROM (
  SELECT
    CASE
      WHEN Balance = 0 THEN '0'
      WHEN Balance > 0 AND Balance <= 75000 THEN '1-75k'
      WHEN Balance > 75000 AND Balance <= 150000 THEN '75k-150k'
      WHEN Balance > 150000 THEN '150k+'
      ELSE 'Unknown'
    END AS BalanceBucket,
    COUNT(*) AS CustomerCount
  FROM Customer
  GROUP BY BalanceBucket
) AS sub
ORDER BY
  CASE
    WHEN BalanceBucket = '0' THEN 1
    WHEN BalanceBucket = '1-75k' THEN 2
    WHEN BalanceBucket = '75k-150k' THEN 3
    WHEN BalanceBucket = '150k+' THEN 4
    ELSE 5
  END;

SELECT
  BalanceBucket,
  COUNT(*) FILTER (WHERE Exited = FALSE) AS Not_Exited,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS Exited
FROM (
  SELECT
    CASE
      WHEN Balance = 0 THEN '0'
      WHEN Balance > 0 AND Balance <= 75000 THEN '1-75k'
      WHEN Balance > 75000 AND Balance <= 150000 THEN '75k-150k'
      WHEN Balance > 150000 THEN '150k+'
      ELSE 'Unknown'
    END AS BalanceBucket,
    Exited
  FROM Customer
) AS sub
GROUP BY BalanceBucket
ORDER BY
  CASE
    WHEN BalanceBucket = '0' THEN 1
    WHEN BalanceBucket = '1-75k' THEN 2
    WHEN BalanceBucket = '75k-150k' THEN 3
    WHEN BalanceBucket = '150k+' THEN 4
    ELSE 5
  END;

SELECT
  BalanceBucket,
  COUNT(*) AS TotalCustomers,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS ExitedCustomers,
  ROUND(
    COUNT(*) FILTER (WHERE Exited = TRUE) * 100.0 / NULLIF(COUNT(*), 0),
    2
  ) || '%' AS ExitedPercentage
FROM (
  SELECT
    CASE
      WHEN Balance = 0 THEN '0'
      WHEN Balance > 0 AND Balance <= 75000 THEN '1-75k'
      WHEN Balance > 75000 AND Balance <= 150000 THEN '75k-150k'
      WHEN Balance > 150000 THEN '150k+'
      ELSE 'Unknown'
    END AS BalanceBucket,
    Exited
  FROM Customer
) AS sub
GROUP BY BalanceBucket
ORDER BY
  CASE
    WHEN BalanceBucket = '0' THEN 1
    WHEN BalanceBucket = '1-75k' THEN 2
    WHEN BalanceBucket = '75k-150k' THEN 3
    WHEN BalanceBucket = '150k+' THEN 4
    ELSE 5
  END;

SELECT
  COUNT(EstimatedSalary) AS CustomerCount,
  ROUND(AVG(EstimatedSalary), 2) AS AverageEstimatedSalary,
  ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY EstimatedSalary)::numeric, 2) AS MedianEstimatedSalary,
  ROUND(MIN(EstimatedSalary), 2) AS MinEstimatedSalary,
  ROUND(MAX(EstimatedSalary), 2) AS MaxEstimatedSalary,
  ROUND(STDDEV_SAMP(EstimatedSalary), 2) AS StddevEstimatedSalary
FROM Customer;

SELECT
  SalaryBucket,
  CustomerCount
FROM (
SELECT
  CASE
    WHEN EstimatedSalary <= 43026 THEN 'Low income 20 Percentile'
    WHEN EstimatedSalary > 43026 AND EstimatedSalary <= 64811 THEN 'Lower-middle income 40 Percentile'
    WHEN EstimatedSalary > 64811 AND EstimatedSalary <= 84100 THEN 'Middle income 60 Percentile'
    WHEN EstimatedSalary >  84100 AND EstimatedSalary <= 123598 THEN 'Upper-middle income 80 Percentile'
    WHEN EstimatedSalary > 123598 THEN 'High income 100 Percentile'
    ELSE 'Unknown'
  END AS SalaryBucket,
  COUNT(*) AS CustomerCount
FROM Customer
GROUP BY SalaryBucket
) AS SUB 
ORDER BY
  CASE
    WHEN SalaryBucket = 'Low income 20 Percentile' THEN 1
    WHEN SalaryBucket = 'Lower-middle income 40 Percentile' THEN 2
    WHEN SalaryBucket = 'Middle income 60 Percentile' THEN 3
    WHEN SalaryBucket = 'Upper-middle income 80 Percentile' THEN 4
    WHEN SalaryBucket = 'High income 100 Percentile' THEN 5
    ELSE 6
  END;

SELECT
  SalaryBucket,
  COUNT(*) FILTER (WHERE Exited = FALSE) AS Not_Exited,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS Exited
FROM (
  SELECT
    CASE
      WHEN EstimatedSalary <= 43026 THEN 'Low income 20 Percentile'
      WHEN EstimatedSalary > 43026 AND EstimatedSalary <= 64811 THEN 'Lower-middle income 40 Percentile'
      WHEN EstimatedSalary > 64811 AND EstimatedSalary <= 84100 THEN 'Middle income 60 Percentile'
      WHEN EstimatedSalary > 84100 AND EstimatedSalary <= 123598 THEN 'Upper-middle income 80 Percentile'
      WHEN EstimatedSalary > 123598 THEN 'High income 100 Percentile'
      ELSE 'Unknown'
    END AS SalaryBucket,
    Exited
  FROM Customer
) AS sub
GROUP BY SalaryBucket
ORDER BY
  CASE
    WHEN SalaryBucket = 'Low income 20 Percentile' THEN 1
    WHEN SalaryBucket = 'Lower-middle income 40 Percentile' THEN 2
    WHEN SalaryBucket = 'Middle income 60 Percentile' THEN 3
    WHEN SalaryBucket = 'Upper-middle income 80 Percentile' THEN 4
    WHEN SalaryBucket = 'High income 100 Percentile' THEN 5
    ELSE 6
  END;

SELECT
  SalaryBucket,
  COUNT(*) AS TotalCustomers,
  COUNT(*) FILTER (WHERE Exited = TRUE) AS ExitedCustomers,
  ROUND(
    COUNT(*) FILTER (WHERE Exited = TRUE) * 100.0 / NULLIF(COUNT(*), 0),
    2
  ) || '%' AS ExitedPercentage
FROM (
  SELECT
    CASE
      WHEN EstimatedSalary <= 43026 THEN 'Low income 20 Percentile'
      WHEN EstimatedSalary > 43026 AND EstimatedSalary <= 64811 THEN 'Lower-middle income 40 Percentile'
      WHEN EstimatedSalary > 64811 AND EstimatedSalary <= 84100 THEN 'Middle income 60 Percentile'
      WHEN EstimatedSalary > 84100 AND EstimatedSalary <= 123598 THEN 'Upper-middle income 80 Percentile'
      WHEN EstimatedSalary > 123598 THEN 'High income 100 Percentile'
      ELSE 'Unknown'
    END AS SalaryBucket,
    Exited
  FROM Customer
) AS sub
GROUP BY SalaryBucket
ORDER BY
  CASE
    WHEN SalaryBucket = 'Low income 20 Percentile' THEN 1
    WHEN SalaryBucket = 'Lower-middle income 40 Percentile' THEN 2
    WHEN SalaryBucket = 'Middle income 60 Percentile' THEN 3
    WHEN SalaryBucket = 'Upper-middle income 80 Percentile' THEN 4
    WHEN SalaryBucket = 'High income 100 Percentile' THEN 5
    ELSE 6
  END;

SELECT
  COUNT(*) FILTER (WHERE HasCrCard = True) AS HasCard,
  COUNT(*) FILTER (WHERE HasCrCard = False) AS DoesNotHaveCard
FROM Customer;

SELECT
  COUNT(*) FILTER (WHERE Exited = FALSE AND HasCrCard = TRUE) AS NotExited_HasCard,
  COUNT(*) FILTER (WHERE Exited = FALSE AND HasCrCard = FALSE) AS NotExited_DoesNotHaveCard
FROM Customer;

SELECT
  COUNT(*) FILTER (WHERE Exited = TRUE AND HasCrCard = TRUE) AS Exited_HasCard,
  COUNT(*) FILTER (WHERE Exited = TRUE AND HasCrCard = FALSE) AS Exited_DoesNotHaveCard
FROM Customer;

SELECT
  'Has Credit Card' AS CardStatus,
  COUNT(*) FILTER (WHERE HasCrCard = TRUE) AS TotalCustomers,
  COUNT(*) FILTER (WHERE HasCrCard = TRUE AND Exited = TRUE) AS ExitedCustomers,
  ROUND(
    COUNT(*) FILTER (WHERE HasCrCard = TRUE AND Exited = TRUE) * 100.0 /
    NULLIF(COUNT(*) FILTER (WHERE HasCrCard = TRUE), 0), 2
  ) || '%' AS ExitedPercentage
FROM Customer

UNION ALL

SELECT
  'No Credit Card' AS CardStatus,
  COUNT(*) FILTER (WHERE HasCrCard = FALSE) AS TotalCustomers,
  COUNT(*) FILTER (WHERE HasCrCard = FALSE AND Exited = TRUE) AS ExitedCustomers,
  ROUND(
    COUNT(*) FILTER (WHERE HasCrCard = FALSE AND Exited = TRUE) * 100.0 /
    NULLIF(COUNT(*) FILTER (WHERE HasCrCard = FALSE), 0), 2
  ) || '%' AS ExitedPercentage
FROM Customer;

SELECT
  COUNT(*) FILTER (WHERE IsActiveMember = TRUE) AS ActiveMembers,
  COUNT(*) FILTER (WHERE IsActiveMember = FALSE) AS InactiveMembers
FROM Customer;

SELECT
  COUNT(*) FILTER (WHERE IsActiveMember = TRUE AND Exited = TRUE) AS Exited_ActiveMember,
  COUNT(*) FILTER (WHERE IsActiveMember = TRUE AND Exited = FALSE) AS NotExited_ActiveMember
FROM Customer;

SELECT
  COUNT(*) FILTER (WHERE IsActiveMember = FALSE AND Exited = TRUE) AS Exited_InactiveMember,
  COUNT(*) FILTER (WHERE IsActiveMember = FALSE AND Exited = FALSE) AS NotExited_InactiveMember
FROM Customer;

SELECT
  'Active Member' AS MembershipStatus,
  COUNT(*) FILTER (WHERE IsActiveMember = TRUE) AS TotalCustomers,
  COUNT(*) FILTER (WHERE IsActiveMember = TRUE AND Exited = TRUE) AS ExitedCustomers,
  ROUND(
    COUNT(*) FILTER (WHERE IsActiveMember = TRUE AND Exited = TRUE) * 100.0 /
    NULLIF(COUNT(*) FILTER (WHERE IsActiveMember = TRUE), 0), 2
  ) || '%' AS ExitedPercentage
FROM Customer

UNION ALL

SELECT
  'Inactive Member' AS MembershipStatus,
  COUNT(*) FILTER (WHERE IsActiveMember = FALSE) AS TotalCustomers,
  COUNT(*) FILTER (WHERE IsActiveMember = FALSE AND Exited = TRUE) AS ExitedCustomers,
  ROUND(
    COUNT(*) FILTER (WHERE IsActiveMember = FALSE AND Exited = TRUE) * 100.0 /
    NULLIF(COUNT(*) FILTER (WHERE IsActiveMember = FALSE), 0), 2
  ) || '%' AS ExitedPercentage
FROM Customer;

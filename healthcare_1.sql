#1- What is the gender distribution in the dataset?

SELECT gender, COUNT(id) AS Total
FROM health
GROUP BY gender;

#2- How does age vary across different groups (e.g., gender, work type)?


SELECT age_group, work_type, gender, COUNT(id) AS total
FROM health
GROUP BY age_group, work_type, gender;

#3- What is the average BMI and glucose level by age group?

SELECT age_group, COUNT(id) AS total, AVG(bmi) AS average_bmi, AVG(avg_glucose_level) AS average_glucose
FROM health
GROUP BY age_group;

#4- How prevalent are hypertension and heart disease in the population?

SELECT `status`,smoking_status,COUNT(id) AS total, 
SUM(hypertension) * 100.0 / COUNT(id) AS hypertension_percentage,
ROUND(COUNT(id) * 100.0 / COUNT(*) OVER(PARTITION BY Residence_type),2) AS total_percentage
FROM health
GROUP BY Residence_type, `status`, smoking_status;



SELECT * 
FROM health;

#5- How does marital status correlate with health conditions?


SELECT ever_married,`status` ,COUNT(id) AS total,
ROUND(COUNT(status) * 100.0 / COUNT(*) OVER(PARTITION BY ever_married),2) AS percentage 
FROM health
GROUP BY ever_married, `status`;

#6- How does the distribution of stroke cases vary by age and gender?


SELECT age_group, gender, `status`, COUNT(id) AS total
FROM health
GROUP BY age_group, gender, `status`
ORDER BY 4 DESC;

#7- How does stroke incidence vary across different work types?

SELECT  `status`, work_type ,COUNT(id) AS total
FROM health
GROUP BY `status`, work_type
ORDER BY 3 DESC;


#8- Is there a trend in stroke occurrences based on BMI and glucose levels?

SELECT 
    `status`,
    AVG(bmi) AS avg_bmi,
    AVG(avg_glucose_level) AS avg_glucose_level,
    MIN(bmi) AS min_bmi,
    MAX(bmi) AS max_bmi,
    MIN(avg_glucose_level) AS min_glucose_level,
    MAX(avg_glucose_level) AS max_glucose_level,
    COUNT(*) AS total_count
FROM 
    health
GROUP BY 
    `status`;



WITH CategorizedData AS (
    SELECT 
        CASE 
            WHEN bmi < 18.5 THEN 'Underweight'
            WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal'
            WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
            ELSE 'Obese'
        END AS bmi_category,
        CASE 
            WHEN avg_glucose_level < 140 THEN 'Normal'
            WHEN avg_glucose_level BETWEEN 140 AND 199 THEN 'Prediabetes'
            ELSE 'Diabetes'
        END AS glucose_category,
        `status`
    FROM 
        health
)
SELECT 
    bmi_category,
    glucose_category,
    `status`,
    COUNT(*) AS Count_stroke
FROM 
    CategorizedData
GROUP BY 
    bmi_category, glucose_category, `status`
ORDER BY 
    bmi_category, glucose_category, `status`;

SELECT * 
FROM health;


SELECT gender,id,age
FROM health;

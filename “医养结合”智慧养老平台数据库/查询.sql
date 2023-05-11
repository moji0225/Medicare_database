# 查询

## （1）基本信息查询

-- 查看年龄在XX岁以上的所有老年人信息
SELECT *
FROM old_basic
WHERE oage>90;


-- 查看所有有既往病史的老人信息
SELECT *
FROM old_basic
WHERE PMH != '无';


-- 查看所有居住在海沧区的老人信息
SELECT *
FROM old_basic
WHERE oaddress LIKE '%海沧区%';


-- 查看某分类下的医院
SELECT *
FROM hospital
WHERE hspt_class='三级甲等';


-- 查看医院在线诊疗医生人数
SELECT hspt_id,hspt_name,COUNT(dr_id) online_dr_num
FROM
(SELECT doctor.aff_hspt_id,hospital.hspt_name,online_diagnosis.dr_id
FROM online_diagnosis,doctor,hospital
WHERE online_diagnosis.dr_id=doctor.dr_id AND doctor.aff_hspt_id=hospital.hspt_id)AS online_dr(hspt_id,hspt_name,dr_id)
GROUP BY hspt_id;


-- 查看XX养老院的所有员工信息
SELECT *
FROM center_employees
WHERE center_id='CH004';


## (2)统计查询

-- 查询老年人健康状况总分
SELECT oid,oname,(C_pulse+C_blood_pressure+C_temperature+C_SaO2+C_BG+C_sleep_time) total_score
FROM health_condition;


-- 查询70~80年龄段老人各身体指标平均得分
SELECT '70~80' age_group,AVG(C_pulse),AVG(C_blood_pressure),AVG(C_temperature),AVG(C_SaO2),AVG(C_BG),AVG(C_sleep_time)
FROM health_condition
WHERE oage BETWEEN 70 AND 80;

-- 老年人患某一病症频次
SELECT diag_rslt, COUNT(diag_rslt)
FROM online_diagnosis
GROUP BY diag_rslt;


-- 医院平均出诊人数
SELECT dr_id, COUNT(dr_id)
FROM online_diagnosis
GROUP BY dr_id;


-- 查询各科室医生数量
SELECT doctor.aff_dept_id dept_id, hspt_department.dept_name,COUNT(aff_dept_id) dr_num
FROM doctor,hspt_department
WHERE doctor.aff_dept_id=hspt_department.dept_id
GROUP BY aff_dept_id
ORDER BY aff_dept_id asc;


-- 查看各分类下医院的数量
SELECT hspt_class class,COUNT(hspt_id) hspt_num
FROM hospital
GROUP BY hspt_class;


-- 查询各养老院派出护理人员人数
SELECT center_id,COUNT(emp_id)
FROM
	(SELECT diagnosis_service.emp_id, center_employees.center_id
	FROM diagnosis_service,center_employees
	WHERE diagnosis_service.emp_id=center_employees.emp_id)AS	in_home_service(emp_id,center_id)
GROUP BY center_id;


## (3)特定用户查询
-- 老年人查询为自己提供服务的护工的从业时长和护理等级
SELECT emp_id,emp_name,emp_sex,emp_age,emp_worktime,emp_class
FROM center_employees
WHERE emp_id='N013';

-- 查询编号为XX的老人膳食搭配情况（症状+所缺营养素+膳食）
SELECT online_diagnosis.oid ,old_basic.oname,online_diagnosis.sympt,online_diagnosis.dr_id,doctor.dr_name,symptom_diet.nutrient,symptom_diet.diet
FROM old_basic,symptom_diet,online_diagnosis,doctor
WHERE online_diagnosis.oid=old_basic.oid AND online_diagnosis.sympt=symptom_diet.symptom AND online_diagnosis.dr_id=doctor.dr_id;


-- 养老院膳食消耗情况（️养老院膳食采购指南）以鲜枣为例
SELECT '鲜枣' Ingredients,COUNT(symptom) Count
FROM symptom_diet, online_diagnosis
WHERE online_diagnosis.sympt=symptom_diet.symptom
AND diet LIKE '%鲜枣%'
GROUP BY symptom;

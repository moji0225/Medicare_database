-- 老年人的症状、诊断结果、用药建议及推荐膳食视图
CREATE VIEW old_diagnosis_diet(id,name,age,sympt,diag_rslt,instruction,sugg_diet)
AS SELECT old_basic.oid,old_basic.oname,old_basic.oage,online_diagnosis.sympt,online_diagnosis.diag_rslt,online_diagnosis.instruction,symptom_diet.diet
FROM old_basic,online_diagnosis,symptom_diet
WHERE old_basic.oid = online_diagnosis.oid AND online_diagnosis.sympt = symptom_diet.symptom;

-- 老年人的症状、推荐服务、服务人员视图
CREATE VIEW old_diagnosis_service(oid,oname,age,sympt,sugg_service,emp_id,emp_name)
AS
SELECT online_diagnosis.oid,old_basic.oname,old_basic.oage,online_diagnosis.sympt,diagnosis_service.sugg_survice,diagnosis_service.emp_id,center_employees.emp_name
FROM online_diagnosis,diagnosis_service,old_basic,center_employees
WHERE online_diagnosis.treat_id=diagnosis_service.treat_id AND online_diagnosis.oid=old_basic.oid AND diagnosis_service.emp_id=center_employees.emp_id;